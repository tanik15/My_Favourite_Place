// import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:location/location.dart';
// import 'dart:io';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key, required this.addressInput});
  final void Function(String address) addressInput;

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  final _addresscontroller = TextEditingController();
  // bool _loadingLocation = false;

  // void getLocation() async {
  //   Location location = Location();

  //   bool serviceEnabled;
  //   PermissionStatus permissionGranted;
  //   LocationData locationData;

  //   serviceEnabled = await location.serviceEnabled();
  //   if (!serviceEnabled) {
  //     serviceEnabled = await location.requestService();
  //     if (!serviceEnabled) {
  //       return;
  //     }
  //   }

  //   permissionGranted = await location.hasPermission();
  //   if (permissionGranted == PermissionStatus.denied) {
  //     permissionGranted = await location.requestPermission();
  //     if (permissionGranted != PermissionStatus.granted) {
  //       return;
  //     }
  //   }

  //   setState(() {
  //     _loadingLocation = true;
  //   });

  //   locationData = await location.getLocation();
  //   final lat = locationData.latitude;
  //   final lng = locationData.longitude;
  //   final url = Uri.parse(
  //       "https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=AIzaSyDTJaXmh3B0kLs_aNYJwThBO8gSbv1VRcM");
  //   final response = await http.get(url);
  //   final resData = json.decode(response.body);
  //   print(resData);
  //   // final address = resData['results'][0]['formatted_address'];
  //   // print(address);
  //   // if (locationData.latitude == null || locationData.longitude == null) {
  //   //   return;
  //   // }
  //   // List<geocoding.Placemark> placemarks =
  //   //     await geocoding.placemarkFromCoordinates(
  //   //         locationData.latitude!, locationData.longitude!);
  //   // print(placemarks);
  //   setState(() {
  //     _loadingLocation = false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // Widget previewContent = Text('No Location has choosen',
    //     style: Theme.of(context)
    //         .textTheme
    //         .bodyLarge!
    //         .copyWith(color: Theme.of(context).colorScheme.onBackground));
    // if (_loadingLocation) {
    //   const CircularProgressIndicator();
    // }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          // height: 170,
          alignment: Alignment.center,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
            ),
          ),
          child: TextField(
            controller: _addresscontroller,
            maxLines: 3,
          ),

          // previewContent),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: [
          //     TextButton.icon(
          //       onPressed: getLocation,
          //       icon: const Icon(Icons.location_on),
          //       label: const Text('Get current location'),
          //     ),
          //     TextButton.icon(
          //       onPressed: () {},
          //       icon: const Icon(Icons.map),
          //       label: const Text('Select on Map'),
          //     )
          //   ],
        ),
        TextButton(
          style: TextButton.styleFrom(alignment: Alignment.bottomRight),
          onPressed: () {
            widget.addressInput(_addresscontroller.text);
          },
          child: Text('okay',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Theme.of(context).colorScheme.primary)),
        )
      ],
    );
  }
}
