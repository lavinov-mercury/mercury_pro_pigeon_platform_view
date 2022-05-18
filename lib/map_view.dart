import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mercury_pro_demo/map_controller.g.dart';

part 'map_controller.dart';

class LatLon {
  const LatLon(this.lat, this.lon);

  final double lat;
  final double lon;

  List<double> toJson() => [lat, lon];
}

class MapView extends StatelessWidget {
  const MapView({
    this.initialCoordinate,
    this.onCreated,
    Key? key,
  }) : super(key: key);

  final LatLon? initialCoordinate;
  final void Function(MapController)? onCreated;

  @override
  Widget build(BuildContext context) {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return AndroidView(
          viewType: 'mercMap',
          onPlatformViewCreated: (id) => onCreated?.call(MapController(id)),
          creationParams: {
            'coordinate': initialCoordinate?.toJson(),
          },
          creationParamsCodec: const StandardMessageCodec(),
        );
      case TargetPlatform.iOS:
        return UiKitView(
          viewType: 'mercMap',
          onPlatformViewCreated: (id) => onCreated?.call(MapController(id)),
          creationParams: {
            'coordinate': initialCoordinate?.toJson(),
          },
          creationParamsCodec: const StandardMessageCodec(),
        );
      default:
        return const Placeholder();
    }
  }
}
