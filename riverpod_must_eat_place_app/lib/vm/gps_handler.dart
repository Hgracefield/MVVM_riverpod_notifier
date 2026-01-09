import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

class GpsState {
  final String latitude;
  final String longitude;

  GpsState({this.latitude = '', this.longitude = ''});

  GpsState copyWith({String? latitude, String? longitude}) {
    return GpsState(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }
} // GpsStste

class GpsNotifier extends Notifier<GpsState> {
  @override
  GpsState build() => GpsState();

  Future<void> checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) return;

    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      final position = await Geolocator.getCurrentPosition();
      state = state.copyWith(
        latitude: position.latitude.toString(),
        longitude: position.longitude.toString(),
      );
    }
  }
} // GPsNotifier

final gpsNotifierProvider = NotifierProvider<GpsNotifier, GpsState>(GpsNotifier.new);
