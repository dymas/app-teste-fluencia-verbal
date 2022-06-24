import 'package:app/presentation/pages/test_page.dart';
import 'package:app/presentation/utils/appbartitle_textstyle.dart';
import 'package:app/presentation/utils/constants.dart';
import 'package:app/presentation/utils/durationchooser_buttonstyle.dart';
import 'package:app/presentation/utils/label_textstyle.dart';
import 'package:app/presentation/utils/textformfield_textstyle.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class NewTest extends StatefulWidget {
  const NewTest({Key? key}) : super(key: key);

  @override
  State<NewTest> createState() => _NewTestState();
}

class _NewTestState extends State<NewTest> {
  @override
  Widget build(BuildContext context) {
    verify() async {
      var storagestatus = await Permission.storage.status;
      var readwritestatus = await Permission.manageExternalStorage.status;
      if (storagestatus.isDenied) {
        Permission.manageExternalStorage.request();
      }
      if (readwritestatus.isDenied) {
        Permission.storage.request();
      }
    }

    verify();
    TextEditingController nameField = TextEditingController();
    String? educationalLevel;
    TextEditingController categoryField = TextEditingController();
    int selectedSeconds = 0;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Novo Teste'),
          backgroundColor: kPrimaryColorTFV,
          shadowColor: Colors.transparent,
          titleTextStyle: appBarTitleTextStyle,
        ),
        backgroundColor: kPrimaryColorTFV,
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Nome do Paciente',
                    style: labelTextStyle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Nome do paciente',
                    ),
                    controller: nameField,
                    style: textFormFieldStyle,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Grau de Escolaridade',
                    style: labelTextStyle,
                  ),
                ),
                StatefulBuilder(
                    builder: (context, setState) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButton<String>(
                            value: educationalLevel,
                            isExpanded: true,
                            iconEnabledColor: Colors.white,
                            hint: const Text('Informe o nível'),
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: kPrimaryFontFamily,
                              fontWeight: kBoldFontWeight,
                            ),
                            dropdownColor: Theme.of(context).primaryColor,
                            items: <String>[
                              'Analfabeto',
                              '1 a 7 anos',
                              '8 anos ou mais'
                            ].map((String e) {
                              return DropdownMenuItem<String>(
                                  value: e, child: Text(e));
                            }).toList(),
                            onChanged: (String? value) {
                              setState(() {
                                educationalLevel = value ?? "";
                              });
                            },
                          ),
                        )),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Categoria',
                    style: labelTextStyle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Informe a categoria do teste',
                    ),
                    controller: categoryField,
                    style: textFormFieldStyle,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Determine a duração do teste',
                    style: labelTextStyle,
                  ),
                ),
                StatefulBuilder(
                    builder: (context, setState) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: ElevatedButton(
                                  style: durationChooserButtonStyle,
                                  child: Text(
                                    '1 min',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: kPrimaryFontFamily,
                                        fontWeight: ((selectedSeconds == 60)
                                            ? kBoldFontWeight
                                            : FontWeight.w400)),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      selectedSeconds = 60;
                                    });
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: ElevatedButton(
                                  style: durationChooserButtonStyle,
                                  child: Text(
                                    '2 min',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: kPrimaryFontFamily,
                                        fontWeight: ((selectedSeconds == 120)
                                            ? kBoldFontWeight
                                            : FontWeight.w400)),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      selectedSeconds = 120;
                                    });
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: ElevatedButton(
                                  style: durationChooserButtonStyle,
                                  child: Text(
                                    '3 min',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: kPrimaryFontFamily,
                                        fontWeight: ((selectedSeconds == 180)
                                            ? kBoldFontWeight
                                            : FontWeight.w400)),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      selectedSeconds = 180;
                                    });
                                  },
                                ),
                              ),
                            )
                          ],
                        ))),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => RunningTest(
                          chosenSeconds: selectedSeconds,
                          name: nameField.text,
                          category: categoryField.text,
                          educationalLevel:
                              educationalLevel ?? "Não especificado",
                        )));
          },
          label: const Text('Iniciar Teste'),
          icon: const Icon(Icons.play_arrow_rounded),
        ));
  }
}
