import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';

typedef Fn = void Function();
String avaliarResultado(score, escolaridade) {
  if (escolaridade == 'Analfabeto') {
    if (score == 9) {
      return 'Dentro da média';
    } else if (score < 9) {
      return 'Abaixo da média';
    } else if (score > 9) {
      return 'Acima da média';
    }
  }
  if (escolaridade == '1 a 7 anos') {
    if (score == 12) {
      return 'Dentro da média';
    } else if (score < 12) {
      return 'Abaixo da média';
    } else if (score > 12) {
      return 'Acima da média';
    }
  }
  if (escolaridade == '8 anos ou mais') {
    if (score == 13) {
      return 'Dentro da média';
    } else if (score < 13) {
      return 'Abaixo da média';
    } else if (score > 13) {
      return 'Acima da média';
    }
  }

  return 'Indisponível';
}

class ResultadoTFV extends StatefulWidget {
  final int chosenSeconds;
  final dynamic name;
  final dynamic category;
  final String educationalLevel;
  final int words;

  const ResultadoTFV(
      {Key? key,
      this.chosenSeconds = 0,
      this.name,
      this.category,
      this.educationalLevel = "Não especificado",
      this.words = 0})
      : super(key: key);

  @override
  _ResultadoTFVState createState() => _ResultadoTFVState();
}

class _ResultadoTFVState extends State<ResultadoTFV> {
  FlutterSoundPlayer? _mPlayer = FlutterSoundPlayer();
  bool _mPlayerIsInited = false;

  @override
  void initState() {
    super.initState();
    _mPlayer!.openAudioSession().then((value) {
      setState(() {
        _mPlayerIsInited = true;
      });
    });
  }

  @override
  void dispose() {
    stopPlayer();
    // Be careful : you must `close` the audio session when you have finished with it.
    _mPlayer!.closeAudioSession();
    _mPlayer = null;

    super.dispose();
  }

  // -------  Here is the code to playback a remote file -----------------------

  void play() async {
    Directory pathToAudio = await getApplicationDocumentsDirectory();
    String pathURI = '${pathToAudio.path}/Gravação de ${widget.name}.m4a';

    await _mPlayer!.startPlayer(
        fromURI: pathURI,
        codec: Codec.mp3,
        whenFinished: () {
          setState(() {});
        });
    setState(() {});
  }

  Future<void> stopPlayer() async {
    if (_mPlayer != null) {
      await _mPlayer!.stopPlayer();
    }
  }

  // --------------------- UI -------------------

  Fn? getPlaybackFn() {
    if (!_mPlayerIsInited) {
      return null;
    }
    return _mPlayer!.isStopped
        ? play
        : () {
            stopPlayer().then((value) => setState(() {}));
          };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Resultado')),
        body: ListView(children: [
          ListTile(
              title: const Text('Nome do paciente:'),
              subtitle: Text('${widget.name}')),
          ListTile(
              title: const Text('Grau de escolaridade:'),
              subtitle: Text(widget.educationalLevel)),
          ListTile(
            title: const Text('Tópico do teste:'),
            subtitle: Text('${widget.category}'),
          ),
          ListTile(
              title: const Text('Avaliação:'),
              subtitle: Text(
                  avaliarResultado(widget.words, widget.educationalLevel))),
          const ListTile(
            title: Text('Áudio:'),
          ),
          Row(children: [
            const Padding(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 6)),
            ElevatedButton(
              onPressed: getPlaybackFn(),
              //color: Colors.white,
              //disabledColor: Colors.grey,
              child: Text(_mPlayer!.isPlaying ? 'Parar' : 'Play'),
            ),
            const SizedBox(
              width: 20,
            ),
            Text(_mPlayer!.isPlaying ? 'Tocando' : 'Parado.'),
          ])
        ]));
  }
}
