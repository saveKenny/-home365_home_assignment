import 'package:geolocator/geolocator.dart';
import 'package:rxdart/rxdart.dart';

const _distanceFilter = 5;

class UserLocation {
  static final UserLocation _userLocation = UserLocation._internal();

  factory UserLocation() {
    return _userLocation;
  }

  UserLocation._internal() {
    _subscribeUserLocation();
  }

  final _userPosition = BehaviorSubject<Position>();

  Stream<Position> get userPosition => _userPosition.stream;

  Future<void> _subscribeUserLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    _userPosition.addStream(
      Geolocator.getPositionStream(
        locationSettings:
            const LocationSettings(distanceFilter: _distanceFilter),
      ),
    );
  }

  void dispose() {
    _userPosition.close();
  }
}
