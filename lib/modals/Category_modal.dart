import 'package:flutter/services.dart';

class CategoryModal {
  String Title;

  Uint8List Image;

  CategoryModal(
    this.Title,
    this.Image,
  );

  factory CategoryModal.fromMap({required Map data}) {
    return CategoryModal(
      data["Title"],
      data["Image"],
    );
  }
}
