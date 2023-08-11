import 'package:uuid/uuid.dart';
import 'dart:io';

const uuid = Uuid();

class Places {
  Places({required this.title, required this.image, required this.address,String ? id})
      : id = id ?? uuid.v4();

  final String title;
  final String address;
  final String id;
  File image;
}
