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

    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger?
    ) {
        _view = MKMapView()
        super.init()
        
        if let args = args as? Dictionary<String, Any> {
            if let coordinatesArg = args["coordinate"] as? Array<Double> {
                let location = CLLocationCoordinate2D(
                    latitude: coordinatesArg.first!,
                    longitude: coordinatesArg.last!
                )
                
                let region = MKCoordinateRegion( center: location,
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
    //
}
