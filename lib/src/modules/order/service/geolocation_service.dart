import 'package:geolocator/geolocator.dart';

class GeolocationService {
  bool _serviceEnabled = false;
  late LocationPermission _permission = LocationPermission.denied;

  Future<bool> _enableService() async {
    _serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!_serviceEnabled) {
      return Future.error('Geolocation service are disabled');
    }
    return Future.sync(() => true);
  }

  Future<void> _requestPermission() async {
    _permission = await Geolocator.checkPermission();
    if (_permission == LocationPermission.denied) {
      _permission = await Geolocator.requestPermission();
    }
    return Future.sync(() => null);
  }

  Future<Position> getPosition() async {
    return await Geolocator.getCurrentPosition();
  }

  bool isPermissionEnabled() {
    if (_permission == LocationPermission.denied || _permission == LocationPermission.deniedForever) {
      return false;
    }
    return true;
  }

  Future<bool> start() async {
    bool enabled = await _enableService();
    if (enabled) {
      await _requestPermission();
      return Future.sync(() => true);
    }
    return Future.sync(() => false);
  }
}
