import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_complete_guide/Bloc/DailyReportNotes/dailyreports_cubit.dart';
import 'package:flutter_complete_guide/Bloc/User/userCubit.dart';
import 'package:weather/weather.dart' as wf;
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';

Future<bool> handleLocationPermission(BuildContext context) async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
            'Location services are disabled. Please enable the services')));
    return false;
  }
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location permissions are denied')));
      return false;
    }
  }
  if (permission == LocationPermission.deniedForever) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
            'Location permissions are permanently denied, we cannot request permissions.')));
    return false;
  }
  return true;
}

Future<String> getAddressFromLatLng(
    Position position, String currentLocation) async {
  await placemarkFromCoordinates(position.latitude, position.longitude)
      .then((List<Placemark> placemarks) {
    Placemark place = placemarks[0];
    Placemark place2 = placemarks[2];
    if (place.thoroughfare != null) {
      if (place.thoroughfare == "") {
        if (place2.street != place.subLocality) {
          currentLocation =
              "${place2.street},${place.subLocality},${place.locality},${place.administrativeArea}";
        } else {
          currentLocation =
              "${placemarks[3].name},${place.subLocality},${place.locality},${place.administrativeArea}";
        }
      } else {
        currentLocation =
            "${place.thoroughfare},${place.subLocality},${place.locality},${place.administrativeArea}";
      }
    }
  }).catchError((e) {
    debugPrint(e);
  });
  return currentLocation;
}

Future<void> getCurrentPosition(BuildContext context) async {
  final provider = BlocProvider.of<DailyReportsCubit>(context).state;
  WeatherFactory wf = WeatherFactory("7839e67319dc2b52fee25dbeaac1ea57");
  final hasPermission = await handleLocationPermission(context);
  if (!hasPermission) return;
  await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
      .then((Position position) async {
    provider.location = await getAddressFromLatLng(position, provider.location);
    Weather w = await wf.currentWeatherByLocation(
        position.latitude, position.longitude);
    context.read<UserCubit>().setPosition(position);
    if (w.temperature != null)
      provider.weather =
          "${w.weatherDescription} ${w.temperature!.celsius.toString().substring(0, 4)} C";
  }).catchError((e) {
    debugPrint(e);
  });
}
