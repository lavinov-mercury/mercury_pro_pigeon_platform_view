//
//  FLMapView.swift
//  Runner
//
//  Created by Сергей Лавинов on 18.05.2022.
//

import Foundation
import Flutter
import MapKit

class FLMapViewFactory: NSObject, FlutterPlatformViewFactory {
    var messenger: FlutterBinaryMessenger
    
    init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
        
        super.init()
    }
    
    func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
          return FlutterStandardMessageCodec.sharedInstance()
    }
    
    func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        return FLMapView(frame: frame,
                         viewIdentifier: viewId,
                         arguments: args,
                         binaryMessenger: messenger)
    }
}

class FLMapView: NSObject, FlutterPlatformView {
    private var _view: MKMapView
    private var _viewId: Int64
    
    private var _sink: MapsPlatformToFlutterApi
    
    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger
    ) {
        _view = MKMapView()
        _viewId = viewId
        _sink = MapsPlatformToFlutterApi(binaryMessenger: messenger)
        
        super.init()
        
        MapsFlutterToPlatformApiSetup(messenger, self)
        
        _view.delegate = self
        
        if let args = args as? Dictionary<String, Any> {
            if let coordinatesArg = args["coordinate"] as? Array<Double> {
                let location = CLLocationCoordinate2D(
                    latitude: coordinatesArg.first!,
                    longitude: coordinatesArg.last!
                )
                
                let region = MKCoordinateRegion(center: location,
                                                latitudinalMeters: CLLocationDistance(exactly: 15000)!,
                                                longitudinalMeters: CLLocationDistance(exactly: 15000)!)
                
                _view.setRegion(_view.regionThatFits(region), animated: false)
            }
            
        }
    }

    func view() -> UIView {
        return _view
    }
}

extension FLMapView: MapsFlutterToPlatformApi {
    func moveMapId(_ mapId: NSNumber, latLon: PigeonLatLon, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        _view.setCenter(
            CLLocationCoordinate2D(
                latitude: Double(truncating: latLon.lat),
                longitude: Double(truncating: latLon.lon)
            ),
            animated: true
        )
    }

    func causeErrorMapId(_ mapId: NSNumber, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        error.pointee = FlutterError(code: "ERROR", message: "Successfully failed, mapId: \(_viewId)", details: nil)
    }
}

extension FLMapView: MKMapViewDelegate {
    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
        let lat = mapView.centerCoordinate.latitude
        let lon = mapView.centerCoordinate.longitude
        
        _sink.updateLocationMapId(NSNumber(value: _viewId),
                                  latLon: PigeonLatLon.make(
                                            withLat: NSNumber(value: lat),
                                            lon: NSNumber(value: lon))) { _ in }
    }
}
