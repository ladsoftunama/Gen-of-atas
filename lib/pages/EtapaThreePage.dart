import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gen_atas/animations/animation.dart';
import 'package:gen_atas/components/button.dart';
import 'package:gen_atas/components/show_Top_Snack_Bar.dart';
import 'package:gen_atas/components/textFieldPersonalizado.dart';
import 'package:gen_atas/components/topBar.dart';
import 'package:gen_atas/pages/EtapaOnePage.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:universal_html/html.dart' as html;

class EtapaThreePage extends StatefulWidget {
  Map<String, dynamic> data = {
    'integrantesPresentes': [],
    'titulo': "",
    'data': "",
    "hora": ""
  };
  EtapaThreePage({super.key, required this.data});

  @override
  State<EtapaThreePage> createState() => _EtapaThreePageState();
}

class _EtapaThreePageState extends State<EtapaThreePage> {
  final ScrollController _scrollController = ScrollController();
  TextEditingController tituloController = TextEditingController();
  final List<TextEditingController> _controllers = [TextEditingController()];

  pw.MemoryImage? _image;

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

  List<String> _getFilledValues() {
    List<String> filledValues = [];
    for (var controller in _controllers) {
      if (controller.text.isNotEmpty) {
        filledValues.add(controller.text);
      }
    }
    return filledValues;
  }

  Future<void> _generatePdf(Map<String, dynamic> data) async {
    try {
      final pdf = pw.Document();

      pdf.addPage(
        pw.Page(
          build: (pw.Context context) => pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  // pw.Image(_image!, width: 100, height: 100),
                ],
              ),
              pw.SizedBox(height: 20),
              pw.Text(
                'ATA DA REUNIÃO DA LIGA ACADÊMICA',
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(
                  fontSize: 11,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 20),
              pw.Text(
                'Data: ${data['data']}',
                style: const pw.TextStyle(fontSize: 11),
              ),
              pw.Text(
                'Local: ${data['modalidade']}',
                style: const pw.TextStyle(fontSize: 11),
              ),
              pw.Text(
                'Horário de Início: ${data['hora']}',
                style: const pw.TextStyle(fontSize: 11),
              ),
              pw.SizedBox(height: 20),
              pw.Text(
                widget.data['titulo'],
                style: pw.TextStyle(
                  fontSize: 11,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 5),
              pw.Text(
                'No dia ${widget.data['data']}, foi realizada uma reunião da Liga Acadêmica na modalidade ${widget.data['modalidade']}, com início às ${widget.data['hora']}. O encontro teve como objetivo discutir assuntos pertinentes ao desenvolvimento das atividades da liga, bem como planejar futuras ações e projetos. A reunião contou com a presença dos seguintes integrantes:',
                style: const pw.TextStyle(
                  fontSize: 11,
                ),
                textAlign: pw.TextAlign.justify,
              ),
              pw.SizedBox(height: 5),
              pw.Text(
                'Presentes:',
                style: pw.TextStyle(
                  fontSize: 11,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              ...data['integrantesPresentes'].map<pw.Widget>((integrante) {
                return pw.Text(
                  '$integrante',
                  style: const pw.TextStyle(fontSize: 11),
                );
              }).toList(),
              pw.SizedBox(height: 20),
              pw.Text(
                'Pauta:',
                style: pw.TextStyle(
                  fontSize: 11,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.Text(
                'A pauta da reunião abrangeu diversos temas essenciais para o progresso das atividades da liga. Foram discutidos tópicos gerais sobre o funcionamento da liga, o planejamento de ações futuras, a coordenação de atividades e outras questões relevantes para os membros presentes. Os principais tópicos abordados foram:',
                style: const pw.TextStyle(
                  fontSize: 11,
                ),
                textAlign: pw.TextAlign.justify,
              ),
              pw.SizedBox(height: 5),
              ...data['topicos'].map<pw.Widget>((topico) {
                return pw.Bullet(
                  text: topico,
                  style: const pw.TextStyle(fontSize: 11),
                );
              }).toList(),
            ],
          ),
        ),
      );

      // Salvar o PDF localmente
      final bytes = await pdf.save();

      // Criar um blob e baixar o arquivo
      final blob = html.Blob([bytes], 'application/pdf');
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.AnchorElement(href: url)
        ..setAttribute('download', 'ata_academica-${widget.data['data']}.pdf')
        ..click();
      html.Url.revokeObjectUrl(url);
    } catch (e) {
      print('Error generating PDF: $e');
    }
  }

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
                children: [
                  const SizedBox(height: 50),
                  topBar(largura),
                  const SizedBox(height: 50),
                  const Text(
                    "Topicos",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                  ),
                  Container(
                    width: largura > 600 ? larguraContainer : largura - 50,
                    alignment: Alignment.center,
                    child: const Text(
                      "Escreva quais topicos foram abordados na reunião",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: SizedBox(
                      height: 400, // Defina a altura máxima para a lista
                      child: Scrollbar(
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
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                  ),
                  buttom(
                    width: 300,
                    height: largura > 800 ? 80 : 70,
                    onTap: () {
                      List<String> temp = _getFilledValues();
                      if (temp.isNotEmpty) {
                        showTopSnackBar(
                          context,
                          "documento ata gerado com sucesso",
                          success: true,
                        );
                        widget.data['topicos'] = temp;
                        print(widget.data);
                        _generatePdf(widget.data);
                      } else {
                        showTopSnackBar(
                          context,
                          "Verifique se todos os campos foram preenchidos",
                          fail: true,
                        );
                      }
                    },
                    text: "Gerar ata",
                  ),
                  const SizedBox(height: 10),
                  buttom(
                    width: 300,
                    height: largura > 800 ? 80 : 70,
                    onTap: () {
                      navigateToPageWithReverseSlideAnimation(
                        context,
                        const EtapaOnePage(),
                      );
                    },
                    text: "Gerar uma do zero",
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
