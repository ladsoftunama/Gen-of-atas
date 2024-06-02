// ignore_for_file: file_names, use_build_context_synchronously

import 'package:flutter/material.dart';

class DateTimePickerField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final double width;
  final double scale;

  const DateTimePickerField({
    super.key,
    required this.controller,
    this.hintText = "",
    this.width = 500.0,
    this.scale = 1.0,
  });

  @override
  _DateTimePickerFieldState createState() => _DateTimePickerFieldState();
}

class _DateTimePickerFieldState extends State<DateTimePickerField> {
  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedTime != null) {
        final DateTime pickedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        setState(() {
          widget.controller.text =
              '${"${pickedDateTime.toLocal()}".split(' ')[0]} ${pickedTime.format(context)}';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: TextField(
        controller: widget.controller,
        readOnly: true,
        onTap: () => _selectDateTime(context),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            vertical: 30.0 * widget.scale,
            horizontal: 30.0 * widget.scale,
          ),
          hintText: widget.hintText,
          prefixIcon: Container(
            margin: EdgeInsets.only(left: 30, right: 15),
            child: Icon(
              Icons.date_range,
              size: 35,
            ),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        ),
      ),
    );
  }
}
