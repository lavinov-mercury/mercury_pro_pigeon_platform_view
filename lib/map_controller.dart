part of 'map_view.dart';

class MapController implements MapsPlatformToFlutterApi {
  MapController(this._mapId)
      : _sink = MapsFlutterToPlatformApi(),
        _coordinateController = StreamController.broadcast() {
    MapsPlatformToFlutterApi.setup(this);
  }

  final int _mapId;
  final MapsFlutterToPlatformApi _sink;

  final StreamController<LatLon> _coordinateController;

  Stream<LatLon> get coordinateStream => _coordinateController.stream;

  void dispose() {
    _coordinateController.close();
  }

  Future<void> move(LatLon latLon) {
    return _sink.move(_mapId, PigeonLatLon(lat: latLon.lat, lon: latLon.lon));
  }

  Future<void> causeError() {
    return _sink.causeError(_mapId);
  }

  @override
  void updateLocation(int mapId, PigeonLatLon latLon) {
    _coordinateController.add(LatLon(latLon.lat, latLon.lon));
  }
}
