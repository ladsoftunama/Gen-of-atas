import 'package:flutter/material.dart';

Widget topBar(largura) {
  return Center(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "images/logo.png",
          scale: largura > 1000
              ? 1
              : largura > 800
                  ? 1.1
                  : 1.5,
        ),
        const SizedBox(width: 10),
        Text(
          "Gen of atas",
          style: TextStyle(
            fontSize: largura > 1000
                ? 50
                : largura > 800
                    ? 30
                    : 20,
            fontWeight: FontWeight.w900,
            color: const Color(0xff4D4D4D),
          ),
        ),
      ],
    ),
  );
}
