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
    
    func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        return FLMapView(frame: frame,
                         viewIdentifier: viewId,
                         arguments: args,
                         binaryMessenger: messenger)
    }
}

class FLMapView: NSObject, FlutterPlatformView {
    private var _view: UIView

    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger?
    ) {
        _view = MKMapView()
        super.init()
    }

    func view() -> UIView {
        return _view
    }
}
