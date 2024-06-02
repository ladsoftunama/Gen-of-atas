import 'package:flutter/material.dart';

Widget buttom(
    {height = 60,
    width = 250,
    text = "LoremIpsum",
    required onTap,
    Color color = const Color(0xff00BF62)}) {
  return InkWell(
    onTap: () {
      onTap();
    },
    child: Container(
      // margin: const EdgeInsets.only(bottom: 10),
      height: height,
      width: width,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black
                  .withOpacity(0.10), // Black color with 10% opacity
              offset: const Offset(0, 4), // x: 0, y: 4
              blurRadius: 4, // Blur radius: 4
              spreadRadius: 0, // Spread radius: 0
            )
          ],
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.black.withOpacity(0.1)),
          color: color),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: const TextStyle(
                fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
          )
        ],
      ),
    ),
  );
}

Widget buttomIcon(
    {height = 60,
    width = 250,
    IconData icon = Icons.delete,
    required onTap,
    Color color = const Color(0xff00BF62)}) {
  return InkWell(
    onTap: () {
      onTap();
    },
    child: Container(
      // margin: const EdgeInsets.only(bottom: 10),
      height: height,
      width: width,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black
                  .withOpacity(0.10), // Black color with 10% opacity
              offset: const Offset(0, 4), // x: 0, y: 4
              blurRadius: 4, // Blur radius: 4
              spreadRadius: 0, // Spread radius: 0
            )
          ],
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.black.withOpacity(0.1)),
          color: color),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 28,
          )
        ],
      ),
    ),
  );
}

Widget buttomText({text = "LoremIpsum", required onTap}) {
  return InkWell(
      onTap: () {
        onTap();
      },
      child: Text(
        text,
        style: const TextStyle(
            color: Colors.blue, decoration: TextDecoration.underline),
      ));
}

Widget buttomText2({text = "LoremIpsum", required onTap}) {
  return InkWell(
      onTap: () {
        onTap();
      },
      child: Text(
        text,
        style: const TextStyle(
            color: Colors.blue,
            decoration: TextDecoration.underline,
            fontSize: 25),
      ));
}
