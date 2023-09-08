import 'package:flutter/material.dart';

class FormStyle {
  static TextStyle textStyle = TextStyle(
    color: Colors.black,
    fontSize: 16.0,
  );

  static InputDecoration inputDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      border: OutlineInputBorder(),
      contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    );
  }

// Ajoutez d'autres styles spécifiques au widget LoginTextField ici
}
