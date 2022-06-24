import 'package:app/presentation/utils/constants.dart';
import 'package:app/presentation/utils/durationchooser_buttonstyle.dart';
import 'package:flutter/material.dart';

int? selectedSeconds;

Widget testDurationChooser = StatefulBuilder(
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
        )));
