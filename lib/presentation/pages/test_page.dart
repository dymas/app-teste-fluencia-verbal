import 'package:app/presentation/pages/result_tfv.dart';
import 'package:app/presentation/utils/appbartitle_textstyle.dart';
import 'package:app/presentation/utils/constants.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'dart:io';

int words = 0;
String wordtxt = "palavras";
final recording = Record();
CountDownController _countdownController = CountDownController();

class RunningTest extends StatefulWidget {
  final int chosenSeconds;
  final dynamic name;
  final dynamic category;
  final String educationalLevel;

  const RunningTest(
      {Key? key,
      this.chosenSeconds = 0,
      this.name,
      this.category,
      this.educationalLevel = "Não especificado"})
      : super(key: key);

  @override
  _RunningTestState createState() => _RunningTestState();
}

class _RunningTestState extends State<RunningTest> {
  @override
  Widget build(BuildContext context) {
    verify() async {
      if (await recording.hasPermission()) {
        Directory pathToAudio = await getApplicationDocumentsDirectory();
        String pathURI = '${pathToAudio.path}/Gravação de ${widget.name}.m4a';
        await recording.start(path: pathURI);
        _countdownController.start();
      }
    }

    verify();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Executando Teste'),
        actions: [
          TextButton(
            child: const Text('Cancelar'),
            style: TextButton.styleFrom(primary: Colors.white),
            onPressed: () async {
              await recording.stop();
              _countdownController.pause();
              Navigator.pop(context);
            },
          )
        ],
        backgroundColor: kPrimaryColorTFV,
        shadowColor: Colors.transparent,
        titleTextStyle: appBarTitleTextStyle,
      ),
      backgroundColor: kPrimaryColorTFV,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: CircularCountDownTimer(
                duration: widget.chosenSeconds,
                initialDuration: 0,
                controller: _countdownController,
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.height / 2,
                ringColor: Colors.grey[300]!,
                ringGradient: null,
                fillColor: Colors.purpleAccent[100]!,
                fillGradient: null,
                backgroundColor: Colors.purple[500],
                backgroundGradient: null,
                strokeWidth: 20.0,
                strokeCap: StrokeCap.round,
                textStyle: const TextStyle(
                    fontSize: 33.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
                textFormat: CountdownTextFormat.S,
                isReverse: false,
                isReverseAnimation: false,
                isTimerTextShown: true,
                autoStart: false,
                onStart: () {
                  debugPrint('Countdown Started');
                },
                onComplete: () async {
                  await recording.stop();
                  debugPrint('Countdown Ended');

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResultadoTFV(
                            name: widget.name,
                            chosenSeconds: widget.chosenSeconds,
                            category: widget.category,
                            educationalLevel: widget.educationalLevel,
                            words: words),
                      ));
                },
              ),
            ),
          ),
          StatefulBuilder(
            builder: (context, setState) => Column(
              children: [
                Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 32),
                    child: Text('$words $wordtxt',
                        style: const TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 20))),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: ElevatedButton(
                          child: const Text(
                            '+1 palavra',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                          ),
                          onPressed: () async {
                            setState(() {
                              words += 1;
                              if (words == 1) {
                                wordtxt = 'palavra';
                              } else {
                                wordtxt = 'palavras';
                              }
                            });
                          }),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                          ),
                          child: const Text(
                            'Pausar',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            await recording.pause();
                            _countdownController.pause();
                            words = 0;
                          },
                        )),
                  ),
                  Expanded(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                          ),
                          child: const Text(
                            'Retomar',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            _countdownController.resume();
                          },
                        )),
                  )
                ])
              ],
            ),
          )
        ],
      ),
    );
  }
}
