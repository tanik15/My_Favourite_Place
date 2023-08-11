import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput(
      {super.key, required this.onPickedImage, required this.inputtitle});
  final void Function(File image) onPickedImage;
  final String inputtitle;
  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? selectedImage;

  void showSnackMsg() {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Please Enter the title')));
  }

  void takeImage() async {
    final imagepicker = ImagePicker();
    final pickedImage = await imagepicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    if (pickedImage == null) {
      return;
    }

    setState(() {
      selectedImage = File(
        pickedImage.path,
      );
    });
    widget.onPickedImage(selectedImage!);
  }

  void fromGallery() async {
    final imagepicker = ImagePicker();
    final pickedImage = await imagepicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 600,
    );
    if (pickedImage == null) {
      return;
    }

    setState(() {
      selectedImage = File(
        pickedImage.path,
      );
    });
    widget.onPickedImage(selectedImage!);
  }

  @override
  Widget build(BuildContext context) {
    print(widget.inputtitle);
    Widget content = Row(
      children: [
        TextButton.icon(
          icon: const Icon(Icons.camera),
          label: const Text('Take Photo'),
          onPressed: takeImage,
        ),
        TextButton.icon(
          icon: const Icon(Icons.photo),
          label: const Text('Photo from gallery'),
          onPressed: fromGallery,
        )
      ],
    );

    if (selectedImage != null) {
      setState(() {
        content = GestureDetector(
          onTap: takeImage,
          child: Image.file(
            selectedImage!,
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
        );
      });
    }
    return Container(
        height: 250,
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border.all(
                width: 1,
                color: Theme.of(context).colorScheme.primary.withOpacity(0.2))),
        child: content);
  }
}
