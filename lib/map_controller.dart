part of 'map_view.dart';

class MapCoordinateUpdate {
  MapCoordinateUpdate(this.mapId, this.latLon);

  final int mapId;
  final LatLon latLon;
}

class _MapControllerResolver implements MapsPlatformToFlutterApi {
  _MapControllerResolver._()
      : _coordinateController = StreamController.broadcast() {
    MapsPlatformToFlutterApi.setup(this);
  }

  static _MapControllerResolver? _instance;

  factory _MapControllerResolver() => _instance ??= _MapControllerResolver._();

  final StreamController<MapCoordinateUpdate> _coordinateController;
  Stream<MapCoordinateUpdate> get coordinateUpdatesStream =>
      _coordinateController.stream;

  @override
  void updateLocation(int mapId, PigeonLatLon latLon) {
    _coordinateController.add(
      MapCoordinateUpdate(
        mapId,
        LatLon(latLon.lat, latLon.lon),
      ),
    );
  }
}

class MapController {
  MapController(this._mapId) : _sink = MapsFlutterToPlatformApi();

  final int _mapId;
  final MapsFlutterToPlatformApi _sink;

  Stream<LatLon> get coordinateStream => _MapControllerResolver()
      .coordinateUpdatesStream
      .where((update) => update.mapId == _mapId)
      .map((update) => update.latLon);

  Future<void> move(LatLon latLon) {
    return _sink.move(_mapId, PigeonLatLon(lat: latLon.lat, lon: latLon.lon));
  }

  Future<void> causeError() {
    return _sink.causeError(_mapId);
  }
}
