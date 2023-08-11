import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_favourite_places/provider/addItemProvider.dart';
import 'package:my_favourite_places/screens/add_place.dart';
import 'package:my_favourite_places/widgets/place_list.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});
  @override
  ConsumerState<Home> createState() {
    return HomeState();
  }
}

class HomeState extends ConsumerState<Home> {
  late Future<void> _placeFuture;
  @override
  void initState() {
    super.initState();
    _placeFuture = ref.read(addItemProvider.notifier).loadData();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final placesList = ref.watch(addItemProvider);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Places'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddNewItem(),
                  ),
                );
              },
              icon: const Icon(Icons.add),
            )
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: FutureBuilder(
              future: _placeFuture,
              builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return  Center(
                    child: Text(snapshot.error.toString()),
                  );
                }
                return 
                PlaceList(
                  places: placesList,
                );
              }),
            )));
  }
}
