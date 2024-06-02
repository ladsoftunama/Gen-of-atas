import 'package:flutter/material.dart';
import 'package:gen_atas/animations/animation.dart';
import 'package:gen_atas/components/DateTime_Picker_Field.dart';
import 'package:gen_atas/components/button.dart';
import 'package:gen_atas/components/show_Top_Snack_Bar.dart';
import 'package:gen_atas/components/textFieldPersonalizado.dart';
import 'package:gen_atas/components/topBar.dart';
import 'package:gen_atas/pages/EtapaTwoPage.dart';
import 'package:intl/intl.dart';

class EtapaOnePage extends StatefulWidget {
  const EtapaOnePage({super.key});

  @override
  State<EtapaOnePage> createState() => _EtapaOnePageState();
}

class _EtapaOnePageState extends State<EtapaOnePage> {
  List<bool> boolList = List<bool>.filled(21, false);

  void checkAndSetBool(int index, bool value) {
    if (index >= 0 && index < boolList.length) {
      boolList[index] = value;
    } else if (index == boolList.length) {
      boolList.add(value);
    } else {}
  }

  String _selectedOption = "Discord";
  void _handleRadioValueChange(String? value) {
    setState(() {
      _selectedOption = value!;
    });
  }

  TextEditingController tituloController = TextEditingController();
  TextEditingController topicosController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double largura = MediaQuery.of(context).size.width;
    double larguraContainer = 800.0;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              width: larguraContainer,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                border: Border.symmetric(
                  vertical: BorderSide(
                    color: Colors.black.withOpacity(0.1),
                    width: 1.0,
                  ),
                ),
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  topBar(largura),
                  const SizedBox(height: 50),
                  const Text(
                    "Titulo da ata",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 20),
                  textFieldPersonalizado(
                    width: largura > 1000
                        ? 500.0
                        : largura > 800
                            ? 450.0
                            : largura > 500
                                ? (largura - 200)
                                : (largura - 100),
                    scale: largura > 1000 ? 1.0 : 0.8,
                    controller: tituloController,
                    text: "Digite o titulo",
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Data da reunião",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),
                  DateTimePickerField(
                    controller: dateController,
                    hintText: "Selecione a data",
                    width: largura > 1000
                        ? 500.0
                        : largura > 800
                            ? 450.0
                            : largura > 500
                                ? (largura - 200)
                                : (largura - 100),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Local",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 5),
                  Expanded(
                    child: SizedBox(
                      width: 300,
                      child: Column(
                        children: [
                          RadioListTile(
                            title: const Text('Presencial'),
                            value: 'Presencial',
                            groupValue: _selectedOption,
                            onChanged: _handleRadioValueChange,
                          ),
                          RadioListTile(
                            title: const Text('Google Meets'),
                            value: 'Google Meets',
                            groupValue: _selectedOption,
                            onChanged: _handleRadioValueChange,
                          ),
                          RadioListTile(
                            title: const Text('Discord'),
                            value: 'Discord',
                            groupValue: _selectedOption,
                            onChanged: _handleRadioValueChange,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  buttom(
                    width: 300,
                    height: largura > 800 ? 80 : 70,
                    onTap: () {
                      if (tituloController.text.isNotEmpty &&
                          dateController.text.isNotEmpty) {
                        DateFormat inputFormat =
                            DateFormat("yyyy-MM-dd hh:mm a");
                        DateTime dateTime =
                            inputFormat.parseStrict(dateController.text);

                        // Format the DateTime to desired formats
                        String formattedHora =
                            DateFormat("HH:mm").format(dateTime);
                        String formattedData =
                            DateFormat("dd-MM-yyyy").format(dateTime);

                        navigateToPageWithReverseSlideAnimation(
                            context,
                            EtapaTwoPage(
                              data: {
                                'titulo': tituloController.text,
                                'data': formattedData,
                                'hora': formattedHora,
                                'modalidade': _selectedOption
                              },
                            ));
                      } else {
                        showTopSnackBar(context,
                            "Verifique se todos os campos foram preenchidos",
                            fail: true);
                      }
                    },
                    text: "proximo",
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
