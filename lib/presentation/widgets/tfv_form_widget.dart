import 'package:app/presentation/utils/constants.dart';
import 'package:app/presentation/utils/label_textstyle.dart';
import 'package:app/presentation/utils/textformfield_textstyle.dart';
import 'package:app/presentation/widgets/testduration_widget.dart';
import 'package:flutter/material.dart';

class TfvForm extends StatefulWidget {
  const TfvForm({Key? key}) : super(key: key);

  @override
  State<TfvForm> createState() => _TfvFormState();
}

class _TfvFormState extends State<TfvForm> {
  @override
  Widget build(BuildContext context) {
    TextEditingController nameField = TextEditingController();
    String? educationalLevel;
    TextEditingController categoryField = TextEditingController();

    return Form(
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
          testDurationChooser,
        ],
      ),
    );
  }
}
