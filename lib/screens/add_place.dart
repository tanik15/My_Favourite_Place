import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_favourite_places/provider/addItemProvider.dart';
import 'package:my_favourite_places/widgets/image_input.dart';
import 'package:my_favourite_places/widgets/location.dart';
// import 'package:my_favourite_places/provider/addItemProvider.dart';

class AddNewItem extends ConsumerStatefulWidget {
  const AddNewItem({super.key});

  @override
  ConsumerState<AddNewItem> createState() => _AddNewItemState();
}

class _AddNewItemState extends ConsumerState<AddNewItem> {
  TextEditingController titleController = TextEditingController();
  String? addressInput;
  File? selectedimage;
  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
  }

  void addPlace() {
    final enteredTitle = titleController.text;
    if (enteredTitle.isEmpty || selectedimage == null) {
      return;
    }
    ref
        .read(addItemProvider.notifier)
        .addItem(enteredTitle, selectedimage!, addressInput!);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add new Place')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(children: [
            TextFormField(
              controller: titleController,
              decoration: const InputDecoration(label: Text('Title')),
            ),
            const SizedBox(
              height: 20,
            ),
            ImageInput(
              inputtitle: titleController.text,
              onPickedImage: (image) {
                selectedimage = image;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            LocationInput(
              addressInput: (address) {
                addressInput = address;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 120,
              child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(),
                  onPressed: addPlace,
                  icon: const Icon(Icons.add),
                  label: const Text('Add place')),
            )
          ]),
        ),
      ),
    );
  }
}
