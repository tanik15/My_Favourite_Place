import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_favourite_places/models/places.dart';

class PlaceDetailScreen extends ConsumerWidget {
  const PlaceDetailScreen({super.key, required this.place});
  final Places place;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
  
    return Scaffold(
        appBar: AppBar(title: Text(place.title)),
        body: Stack(
          children: [
            Image.file(
              place.image,
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            )
          ],
        ));
  }
}
