import 'package:flutter/material.dart';
import 'package:gen_atas/animations/animation.dart';
import 'package:gen_atas/components/button.dart';
import 'package:gen_atas/components/show_Top_Snack_Bar.dart';
import 'package:gen_atas/components/topBar.dart';
import 'package:gen_atas/pages/EtapaOnePage.dart';
import 'package:gen_atas/pages/EtapaThreePage.dart';
import 'package:gen_atas/components/textFieldPersonalizado.dart';

class EtapaTwoPage extends StatefulWidget {
  Map<String, dynamic> data = {};
  EtapaTwoPage({super.key, required this.data});

  @override
  State<EtapaTwoPage> createState() => _EtapaTwoPageState();
}

class _EtapaTwoPageState extends State<EtapaTwoPage> {
  @override
  void initState() {
    super.initState();
    _checkData();
  }

  void _checkData() {
    if (widget.data.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const EtapaOnePage()),
        );
      });
    }
  }

  List<bool> boolList = List<bool>.filled(21, false);
  final List<TextEditingController> _controllers = [TextEditingController()];

  void checkAndSetBool(int index, bool value) {
    if (index >= 0 && index < boolList.length) {
      boolList[index] = value;
    } else if (index == boolList.length) {
      boolList.add(value);
    } else {}
  }

  void _addTextField() {
    setState(() {
      _controllers.add(TextEditingController());
    });
  }

  void _removeTextFieldAt(int index) {
    setState(() {
      if (index >= 0 && index < _controllers.length) {
        _controllers[index].dispose();
        _controllers.removeAt(index);
      }
    });
  }

  int indexx = 0;
  List<String> _getFilledValues() {
    List<String> filledValues = [];
    for (var item in boolList) {
      if (item) {
        filledValues.add(_checkboxValues[indexx]);
      }
      indexx++;
    }
    return filledValues;
  }

  List<String> _getFilledValues2() {
    List<String> filledValues = [];
    for (var controller in _controllers) {
      if (controller.text.isNotEmpty) {
        filledValues.add(controller.text);
      }
    }
    return filledValues;
  }

  final List<String> _checkboxValues = [
    "Marco Antonio",
    "Thiago Tomé",
    "Diosne Marlon",
    "Mateus Cunha",
    "Caique Pinto",
    "Carlos Victor",
    "José Ribeiro",
    "Maria Luiza",
    "Yuri Afonso Costa",
    "Gabriel Maia",
    "Jean Dias",
    "Alex",
    "Igor Alexsandro",
    "Iago Dantas",
    "Matheus Barbosa",
    "Rellan Monteiro",
    "Felipe",
    "João Emannuel",
    "Jackeline",
    "Henrique Jeremias",
    "Pablo Silva"
  ];
  String _selectedOption = "LADSOFT";
  void _handleRadioValueChange(String? value) {
    setState(() {
      _selectedOption = value!;
    });
  }

  final ScrollController _scrollController = ScrollController();
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
                  const SizedBox(height: 10),
                  const Text(
                    "Integrantes da liga academica",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 300,
                    child: Column(
                      children: [
                        RadioListTile(
                          title: const Text('LADSOFT'),
                          value: 'LADSOFT',
                          groupValue: _selectedOption,
                          onChanged: _handleRadioValueChange,
                        ),
                        RadioListTile(
                          title: const Text('Liga academica'),
                          value: 'Liga academica',
                          groupValue: _selectedOption,
                          onChanged: _handleRadioValueChange,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Integrantes presentes",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 400, // Defina a altura máxima para a lista
                    child: _selectedOption == "LADSOFT"
                        ? SizedBox(
                            width: 300,
                            child: Scrollbar(
                              controller: _scrollController,
                              thumbVisibility: true,
                              child: ListView.builder(
                                controller: _scrollController,
                                itemCount: _checkboxValues.length,
                                itemBuilder: (context, index) {
                                  return CheckboxListTile(
                                    title: Text(_checkboxValues[index]),
                                    value: boolList[index],
                                    onChanged: (value) {
                                      setState(() {
                                        checkAndSetBool(index, value!);
                                      });
                                    },
                                  );
                                },
                              ),
                            ),
                          )
                        : Scrollbar(
                            controller: _scrollController,
                            thumbVisibility: true,
                            child: ListView.builder(
                              controller: _scrollController,
                              itemCount: _controllers.length,
                              itemBuilder: (context, index) {
                                return Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    margin: const EdgeInsets.only(bottom: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        textFieldPersonalizado(
                                          width: largura > 1000
                                              ? 500.0
                                              : largura > 800
                                                  ? 450.0
                                                  : largura > 600
                                                      ? (largura - 250)
                                                      : (largura - 150),
                                          scale: largura > 1000 ? 1.0 : 0.8,
                                          controller: _controllers[index],
                                          text: "digite",
                                        ),
                                        const SizedBox(width: 10),
                                        _controllers.length - 1 == index
                                            ? buttomIcon(
                                                onTap: () {
                                                  _addTextField();
                                                },
                                                icon: Icons.add,
                                                color: Colors.blueAccent,
                                                width: 100,
                                                height: largura > 1000
                                                    ? 75
                                                    : largura > 800
                                                        ? 65
                                                        : 63,
                                              )
                                            : buttomIcon(
                                                onTap: () {
                                                  _removeTextFieldAt(index);
                                                },
                                                icon: Icons.delete,
                                                color: Colors.redAccent
                                                    .withOpacity(0.7),
                                                width: 100,
                                                height: largura > 1000
                                                    ? 75
                                                    : largura > 800
                                                        ? 65
                                                        : 63,
                                              ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                  ),
                  const SizedBox(height: 20),
                  buttom(
                    width: 300,
                    height: largura > 800 ? 80 : 70,
                    onTap: () {
                      if (_selectedOption == "LADSOFT") {
                        List<String> temp = _getFilledValues();
                        if (temp.isNotEmpty) {
                          widget.data['integrantesPresentes'] = temp;

                          navigateToPageWithReverseSlideAnimation(
                              context, EtapaThreePage(data: widget.data));
                        } else {
                          showTopSnackBar(context,
                              "Verifique se todos os campos foram preenchidos",
                              fail: true);
                        }
                      } else {
                        List<String> temp = _getFilledValues2();
                        if (temp.isNotEmpty) {
                          widget.data['integrantesPresentes'] = temp;
                          navigateToPageWithReverseSlideAnimation(
                              context, EtapaThreePage(data: widget.data));
                        } else {
                          showTopSnackBar(context,
                              "Verifique se todos os campos foram preenchidos",
                              fail: true);
                        }
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
