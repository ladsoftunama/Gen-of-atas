import 'package:flutter/material.dart';

Widget textFieldPersonalizado({
  required controller,
  width = 500.0,
  text = "",
  scale = 1.0,
}) {
  return SizedBox(
    width: width,
    child: TextField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Container(
          margin: const EdgeInsets.only(left: 30, right: 15),
          child: const Icon(
            Icons.title,
            size: 35,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: 30.0 * scale,
          horizontal: 30.0 * scale,
        ),
        hintText: text,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      ),
    ),
  );
}
