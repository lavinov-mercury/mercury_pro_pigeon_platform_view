part of 'map_view.dart';

class MapController {
  MapController(this._mapId) : _sink = MapsFlutterToPlatformApi();

  final int _mapId;
  final MapsFlutterToPlatformApi _sink;

  Future<void> move(LatLon latLon) {
    return _sink.move(_mapId, PigeonLatLon(lat: latLon.lat, lon: latLon.lon));
  }

  Future<void> causeError() {
    return _sink.causeError(_mapId);
  }
}
