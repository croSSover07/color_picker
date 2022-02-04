import 'dart:ui';

import 'package:flutter/material.dart';

class ColorInfoCard extends StatefulWidget {
  const ColorInfoCard({Key? key, Color colorToSave = Colors.white})
      : _colorToSave = colorToSave,
        super(key: key);

  final Color _colorToSave;

  @override
  State<StatefulWidget> createState() => ColorInfoCardState();
}

class ColorInfoCardState extends State<ColorInfoCard> {
  double value = 50;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2 / 3,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 24.0,
                left: 24.0,
                right: 24.0,
              ),
              child: AspectRatio(
                aspectRatio: 1,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          stops: const [0, 0.5, 1],
                          colors: [
                            Colors.white,
                            widget._colorToSave,
                            Colors.black
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: (MediaQuery.of(context).size.width - 48 - 16) *
                              value /
                              100 -
                          2.5,
                      top: 0,
                      width: 5,
                      height: MediaQuery.of(context).size.width - 48 - 16,
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.black26,
                            border: Border.symmetric(
                                vertical: BorderSide(
                              width: 1,
                              color: Colors.white70,
                            ))),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Slider(
              activeColor: Colors.grey,
              inactiveColor: Colors.grey,
              min: 0,
              max: 100,
              value: value,
              onChanged: (newValue) {
                setState(() {
                  value = newValue;
                });
              },
            ),
            AspectRatio(
              aspectRatio: 5 / 1,
              child: Container(
                color: _modifyColor(widget._colorToSave, value),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Color _modifyColor(Color initialColor, double initialValue) {
  int initialR = int.parse(
      initialColor.hashCode.toRadixString(16).substring(2, 4),
      radix: 16);
  int initialG = int.parse(
      initialColor.hashCode.toRadixString(16).substring(4, 6),
      radix: 16);
  int initialB = int.parse(
      initialColor.hashCode.toRadixString(16).substring(6, 8),
      radix: 16);

  double value = initialValue * 200 / 100 - 100;

  bool isNegative = value < 0;
  double deltaR = _getChannelDelta(initialR, isNegative);
  double deltaG = _getChannelDelta(initialG, isNegative);
  double deltaB = _getChannelDelta(initialB, isNegative);

  int r = initialR - (deltaR * value).toInt();
  int g = initialG - (deltaG * value).toInt();
  int b = initialB - (deltaB * value).toInt();

  return Color.fromARGB(255, r, g, b);
}

double _getChannelDelta(int initialValue, bool isNegative) {
  return isNegative ? (255 - initialValue) / 100 : initialValue / 100;
}
