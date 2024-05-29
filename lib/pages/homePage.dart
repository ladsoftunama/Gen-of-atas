// ignore_for_file: file_names

import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    double largura = MediaQuery.of(context).size.width;
    bool tabletMode = largura < 1000 ? true : false;
    bool smartphoneMode = largura < 700 ? true : false;
    // bool smartphoneNanoMode = largura < 500 ? true : false;

    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            // ======================================================================
            Expanded(
                flex: !tabletMode
                    ? 100
                    : !smartphoneMode
                        ? 70
                        : 0,
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("images/imgBackground.png"),
                          fit: largura > 1450
                              ? BoxFit.fitWidth
                              : BoxFit.fitHeight)),
                )),
            // ======================================================================
            //                             Dev aqui
            // ======================================================================
            Expanded(
                flex: 100,
                child: Container(
                  color: Colors.green,
                )),
            // ======================================================================
          ],
        ),
      ),
    );
  }
}
