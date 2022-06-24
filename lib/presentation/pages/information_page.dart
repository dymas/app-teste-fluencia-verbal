import 'package:app/core/utils/constants.dart';
import 'package:app/presentation/pages/newtest_page.dart';
import 'package:app/presentation/utils/appbartitle_textstyle.dart';
import 'package:app/presentation/utils/constants.dart';
import 'package:flutter/material.dart';

class InformationPage extends StatelessWidget {
  const InformationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(kModuleName),
          actions: [
            IconButton(
              icon: const Icon(Icons.info),
              tooltip: 'Sobre o Teste',
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => const AlertDialog(
                          title: Text('Sobre o teste'),
                          content: Text(kDescriptionTFV,
                              style: TextStyle(
                                fontSize: 12,
                              )),
                        ));
              },
            ),
          ],
          backgroundColor: kPrimaryColorTFV,
          shadowColor: Colors.transparent,
          titleTextStyle: appBarTitleTextStyle,
        ),
        backgroundColor: kPrimaryColorTFV,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Center(
                child: RichText(
                    text: const TextSpan(
                  text: 'Bem-vindo(a) ao\n',
                  style: TextStyle(
                      fontFamily: kPrimaryFontFamily,
                      color: Colors.white,
                      fontSize: 24),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Teste de Fluência Verbal',
                      style: TextStyle(
                          fontFamily: kPrimaryFontFamily,
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: kBoldFontWeight),
                    )
                  ],
                )),
              ),
            ),
            OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.all(16.0),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const NewTest()));
                },
                child: Text('Prosseguir',
                    style: TextStyle(
                        color: kPrimaryColorTFV,
                        fontWeight: kBoldFontWeight,
                        fontSize: 24))),
          ],
        ));
  }
}
