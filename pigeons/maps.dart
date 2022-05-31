import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/map_controller.g.dart',
    objcHeaderOut: 'ios/Runner/Pigeons/MapControllerProtocol.h',
    objcSourceOut: 'ios/Runner/Pigeons/MapControllerProtocol.m',
  ),
)
class PigeonLatLon {
  PigeonLatLon(this.lat, this.lon);

  double lat;
  double lon;
}

@FlutterApi()
abstract class MapsPlatformToFlutterApi {
  void updateLocation(int mapId, PigeonLatLon latLon);
}

@HostApi()
abstract class MapsFlutterToPlatformApi {
  @async
  @ObjCSelector('moveMapWithId:to:')
  void move(int mapId, PigeonLatLon latLon);

  @async
  @ObjCSelector('causeErrorOnMapWithId:')
  void causeError(int mapId);
}
