import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LatLon {
  const LatLon(this.lat, this.lon);

  final double lat;
  final double lon;

  List<double> toJson() => [lat, lon];
}

class MapView extends StatelessWidget {
  const MapView({
    this.initialCoordinate,
    Key? key,
  }) : super(key: key);

  final LatLon? initialCoordinate;

  @override
  Widget build(BuildContext context) {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return AndroidView(
          viewType: 'mercMap',
          creationParams: {
            'coordinate': initialCoordinate?.toJson(),
          },
          creationParamsCodec: const StandardMessageCodec(),
        );
      case TargetPlatform.iOS:
        return UiKitView(
          viewType: 'mercMap',
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
