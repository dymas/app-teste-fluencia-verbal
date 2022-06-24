import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';

class CountdownTimer extends StatelessWidget {
  final int? countdownDuration;
  const CountdownTimer({Key? key, this.countdownDuration}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularCountDownTimer(
      duration: countdownDuration ?? 0,
      initialDuration: 0,
      controller: CountDownController(),
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
          fontSize: 33.0, color: Colors.white, fontWeight: FontWeight.bold),
      textFormat: CountdownTextFormat.S,
      isReverse: false,
      isReverseAnimation: false,
      isTimerTextShown: true,
      autoStart: false,
      onStart: () {
        debugPrint('Countdown Started');
      },
      onComplete: () {
        debugPrint('Countdown Ended');
      },
    );
  }
}
