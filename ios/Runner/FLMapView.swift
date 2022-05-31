//
//  FLMapView.swift
//  Runner
//
//  Created by Сергей Лавинов on 18.05.2022.
//

import Foundation
import Flutter
import MapKit

class FLMapViewFactory: NSObject, FlutterPlatformViewFactory, MapsFlutterToPlatformApi {
    var messenger: FlutterBinaryMessenger
    
    var viewsMap: NSMapTable<NSNumber, FLMapView>
    
    init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
        viewsMap = NSMapTable(keyOptions: .copyIn, valueOptions: .weakMemory)
        
        super.init()
        
        MapsFlutterToPlatformApiSetup(messenger, self)
    }
    
    func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
          return FlutterStandardMessageCodec.sharedInstance()
    }
    
    func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        let platformView = FLMapView(frame: frame,
                                     viewIdentifier: viewId,
                                     arguments: args,
                                     binaryMessenger: messenger)
        
        viewsMap.setObject(platformView, forKey: NSNumber(value: viewId))
        
        return platformView
    }
    
    func moveMap(withId mapId: NSNumber, to latLon: PigeonLatLon, completion: @escaping (FlutterError?) -> Void) {
        guard let view = viewsMap.object(forKey: mapId) else { return }
        view.moveMap(withId: mapId, to: latLon, completion: completion)
    }
    
    func causeErrorOnMap(withId mapId: NSNumber, completion: @escaping (FlutterError?) -> Void) {
        guard let view = viewsMap.object(forKey: mapId) else { return }
        view.causeErrorOnMap(withId: mapId, completion: completion)
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
    func moveMap(withId mapId: NSNumber, to latLon: PigeonLatLon, completion: @escaping (FlutterError?) -> Void) {
        _view.setCenter(
            CLLocationCoordinate2D(
                latitude: Double(truncating: latLon.lat),
                longitude: Double(truncating: latLon.lon)
            ),
            animated: true
        )
        
        completion(nil)
    }
    
    func causeErrorOnMap(withId mapId: NSNumber, completion: @escaping (FlutterError?) -> Void) {
        completion(FlutterError(code: "ERROR", message: "Successfully failed, mapId: \(_viewId)", details: nil))
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
