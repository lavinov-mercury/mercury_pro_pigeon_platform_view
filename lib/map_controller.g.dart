// Autogenerated from Pigeon (v3.0.3), do not edit directly.
// See also: https://pub.dev/packages/pigeon
// ignore_for_file: public_member_api_docs, non_constant_identifier_names, avoid_as, unused_import, unnecessary_parenthesis, prefer_null_aware_operators, omit_local_variable_types, unused_shown_name
// @dart = 2.12
import 'dart:async';
import 'dart:typed_data' show Uint8List, Int32List, Int64List, Float64List;

import 'package:flutter/foundation.dart' show WriteBuffer, ReadBuffer;
import 'package:flutter/services.dart';

class PigeonLatLon {
  PigeonLatLon({
    required this.lat,
    required this.lon,
  });

  double lat;
  double lon;

  Object encode() {
    final Map<Object?, Object?> pigeonMap = <Object?, Object?>{};
    pigeonMap['lat'] = lat;
    pigeonMap['lon'] = lon;
    return pigeonMap;
  }

  static PigeonLatLon decode(Object message) {
    final Map<Object?, Object?> pigeonMap = message as Map<Object?, Object?>;
    return PigeonLatLon(
      lat: pigeonMap['lat']! as double,
      lon: pigeonMap['lon']! as double,
    );
  }
}

class _MapsPlatformToFlutterApiCodec extends StandardMessageCodec {
  const _MapsPlatformToFlutterApiCodec();
  @override
  void writeValue(WriteBuffer buffer, Object? value) {
    if (value is PigeonLatLon) {
      buffer.putUint8(128);
      writeValue(buffer, value.encode());
    } else 
{
      super.writeValue(buffer, value);
    }
  }
  @override
  Object? readValueOfType(int type, ReadBuffer buffer) {
    switch (type) {
      case 128:       
        return PigeonLatLon.decode(readValue(buffer)!);
      
      default:      
        return super.readValueOfType(type, buffer);
      
    }
  }
}
abstract class MapsPlatformToFlutterApi {
  static const MessageCodec<Object?> codec = _MapsPlatformToFlutterApiCodec();

  void updateLocation(int mapId, PigeonLatLon latLon);
  static void setup(MapsPlatformToFlutterApi? api, {BinaryMessenger? binaryMessenger}) {
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.MapsPlatformToFlutterApi.updateLocation', codec, binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          assert(message != null, 'Argument for dev.flutter.pigeon.MapsPlatformToFlutterApi.updateLocation was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final int? arg_mapId = (args[0] as int?);
          assert(arg_mapId != null, 'Argument for dev.flutter.pigeon.MapsPlatformToFlutterApi.updateLocation was null, expected non-null int.');
          final PigeonLatLon? arg_latLon = (args[1] as PigeonLatLon?);
          assert(arg_latLon != null, 'Argument for dev.flutter.pigeon.MapsPlatformToFlutterApi.updateLocation was null, expected non-null PigeonLatLon.');
          api.updateLocation(arg_mapId!, arg_latLon!);
          return;
        });
      }
    }
  }
}

class _MapsFlutterToPlatformApiCodec extends StandardMessageCodec {
  const _MapsFlutterToPlatformApiCodec();
  @override
  void writeValue(WriteBuffer buffer, Object? value) {
    if (value is PigeonLatLon) {
      buffer.putUint8(128);
      writeValue(buffer, value.encode());
    } else 
{
      super.writeValue(buffer, value);
    }
  }
  @override
  Object? readValueOfType(int type, ReadBuffer buffer) {
    switch (type) {
      case 128:       
        return PigeonLatLon.decode(readValue(buffer)!);
      
      default:      
        return super.readValueOfType(type, buffer);
      
    }
  }
}

class MapsFlutterToPlatformApi {
  /// Constructor for [MapsFlutterToPlatformApi].  The [binaryMessenger] named argument is
  /// available for dependency injection.  If it is left null, the default
  /// BinaryMessenger will be used which routes to the host platform.
  MapsFlutterToPlatformApi({BinaryMessenger? binaryMessenger}) : _binaryMessenger = binaryMessenger;

  final BinaryMessenger? _binaryMessenger;

  static const MessageCodec<Object?> codec = _MapsFlutterToPlatformApiCodec();

  Future<void> move(int arg_mapId, PigeonLatLon arg_latLon) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.MapsFlutterToPlatformApi.move', codec, binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(<Object?>[arg_mapId, arg_latLon]) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error = (replyMap['error'] as Map<Object?, Object?>?)!;
      throw PlatformException(
        code: (error['code'] as String?)!,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else {
      return;
    }
  }

  Future<void> causeError(int arg_mapId) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.MapsFlutterToPlatformApi.causeError', codec, binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(<Object?>[arg_mapId]) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error = (replyMap['error'] as Map<Object?, Object?>?)!;
      throw PlatformException(
        code: (error['code'] as String?)!,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else {
      return;
    }
  }
}