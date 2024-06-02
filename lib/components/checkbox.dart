import 'package:flutter/material.dart';

Widget checkbox({
  title = 'Lorem Ipsum',
  required onChanged,
  initialValue = false,
}) {
  return CheckboxListTile(
    title: Text(title),
    value: initialValue,
    onChanged: (bool? value) {
      onChanged(value);
    },
    controlAffinity: ListTileControlAffinity.leading,
  );
}
