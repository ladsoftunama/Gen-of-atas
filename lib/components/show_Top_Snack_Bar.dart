import 'package:flutter/material.dart';

void showTopSnackBar(BuildContext context, String message,
    {bool success = false, bool fail = false}) {
  final overlay = Overlay.of(context);
  final overlayEntry = OverlayEntry(
    builder: (context) {
      Color backgroundColor;

      if (success) {
        backgroundColor = Colors.green.withOpacity(0.8);
      } else if (fail) {
        backgroundColor = Colors.red.withOpacity(0.8);
      } else {
        backgroundColor = Colors.black.withOpacity(0.8);
      }

      return Positioned(
        top: 50.0,
        left: MediaQuery.of(context).size.width * 0.1,
        width: MediaQuery.of(context).size.width * 0.8,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.info, color: Colors.white),
                const SizedBox(width: 12.0),
                Expanded(
                  child: Text(
                    message,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );

  overlay.insert(overlayEntry);

  Future.delayed(const Duration(seconds: 3), () {
    overlayEntry.remove();
  });
}
