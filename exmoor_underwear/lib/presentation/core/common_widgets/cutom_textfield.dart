import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  var controller;
  String? icerik;
  CustomTextField({super.key, required this.controller, this.icerik});

  @override
  Widget build(BuildContext context) {
    return TextField(
      textInputAction: TextInputAction.done,
      minLines: 1,
      maxLines: null,
      controller: controller,
      decoration: InputDecoration(
          labelText: icerik, border: const OutlineInputBorder()),
    );
  }
}
