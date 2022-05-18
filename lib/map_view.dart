import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MapView extends StatelessWidget {
  const MapView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return const AndroidView(viewType: 'mercMap');
      case TargetPlatform.iOS:
        return const UiKitView(viewType: 'mercMap');
      default:
        return const Placeholder();
    }
  }
}
