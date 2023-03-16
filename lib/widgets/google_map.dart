import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_complete_guide/Bloc/Company/company_cubit.dart';
import 'package:flutter_complete_guide/Bloc/DailyReportNotes/dailyreports_cubit.dart';
import 'package:flutter_complete_guide/Bloc/User/userCubit.dart';
import 'package:flutter_complete_guide/widgets/main_drawer.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GetLocation extends StatefulWidget {
  const GetLocation({Key? key}) : super(key: key);
  static const routeName = '/getlocation';

  @override
  State<GetLocation> createState() => _GetLocationState();
}

class _GetLocationState extends State<GetLocation> {
  LatLng currentlocation = LatLng(33.6428, 73.0706);
  late GoogleMapController googleMapController;
  Map<String, Marker> _marker = {};

  @override
  void initState() {
    getcurrentLatLng();
    super.initState();
  }

  getcurrentLatLng() {
    if (BlocProvider.of<UserCubit>(context).state.position != null) {
      currentlocation = LatLng(
          BlocProvider.of<UserCubit>(context).state.position!.latitude,
          BlocProvider.of<UserCubit>(context).state.position!.longitude);
    }
  }

  @override
  Widget build(BuildContext context) {
    final companyProvider = BlocProvider.of<CompanyCubit>(context);
    return Scaffold(
        appBar: AppBar(
            title: Text(
          "Google Map",
          style: TextStyle(fontFamily: context.watch<UserCubit>().state.font),
        )),
        drawer: Drawer(
          child: MainDrawer(
            lstcompany: companyProvider.state.lstcompany ?? [],
          ),
        ),
        body: GoogleMap(
          initialCameraPosition:
              CameraPosition(zoom: 14, target: currentlocation),
          onMapCreated: (controller) {
            googleMapController = controller;
            addmarker('test', currentlocation);
          },
          onTap: (location) {
            addmarker('test', location);
          },
          markers: _marker.values.toSet(),
        ));
  }

  addmarker(String markerid, LatLng Location) async {
    final provider = BlocProvider.of<DailyReportsCubit>(context).state;
    await placemarkFromCoordinates(Location.latitude, Location.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      Placemark place2 = placemarks[2];
      if (place.thoroughfare != null) {
        if (place.thoroughfare == "") {
          if (place2.street != place.subLocality) {
            provider.location =
                "${place2.street},${place.subLocality},${place.locality},${place.administrativeArea}";
          } else {
            provider.location =
                "${placemarks[3].name},${place.subLocality},${place.locality},${place.administrativeArea}";
          }
        } else {
          provider.location =
              "${place.thoroughfare},${place.subLocality},${place.locality},${place.administrativeArea}";
        }
      }
    }).catchError((e) {
      debugPrint(e);
    });
    var marker = Marker(
        markerId: MarkerId(markerid),
        position: Location,
        infoWindow:
            InfoWindow(title: 'Location', snippet: '${provider.location}'));

    _marker[markerid] = marker;

    setState(() {});
  }
}
