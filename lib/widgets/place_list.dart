import 'package:flutter/material.dart';
import 'package:my_favourite_places/models/places.dart';
import 'package:my_favourite_places/screens/place.dart';

class PlaceList extends StatelessWidget {
  const PlaceList({super.key, required this.places});
  final List<Places> places;

  @override
  Widget build(BuildContext context) {
    // print(places[0].address);
    if (places.isEmpty) {
      return const Center(
        child: Text("NO places yet...add new places"),
      );
    }
    return ListView.builder(
      itemCount: places.length,
      itemBuilder: ((context, index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 1),
            child: ListTile(
              subtitle: (places[index].address.isEmpty)
                  ? Text(
                      "data",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground),
                    )
                  : Text(
                      places[index].address,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
              leading: CircleAvatar(
                  radius: 24, backgroundImage: FileImage(places[index].image)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PlaceDetailScreen(
                      place: places[index],
                    ),
                  ),
                );
              },
              title: Text(
                places[index].title,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
            ),
          )),
    );
  }
}
