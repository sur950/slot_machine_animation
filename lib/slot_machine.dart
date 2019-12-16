import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class LuckyDraw extends StatefulWidget {
  final List<String> participants;
  final double width;
  final double height;

  LuckyDraw(
    this.participants,
    this.height,
    this.width,
  );

  @override
  _LuckyDrawState createState() => _LuckyDrawState();
}

class _LuckyDrawState extends State<LuckyDraw> {
  Random random = Random();
  FixedExtentScrollController fixedExtentScrollController;
  int currentPosition = 0;
  Timer _timer;
  String winner = "";
  int _start = 20;
  bool startAnimation = false;
  bool done = false;
  bool started = false;
  int _milliSeconds = 300;

  @override
  void initState() {
    _start = _start + random.nextInt(10);
    fixedExtentScrollController =
        FixedExtentScrollController(initialItem: currentPosition);

    super.initState();
  }

  @override
  void dispose() {
    fixedExtentScrollController.dispose();
    _timer.cancel();
    super.dispose();
  }

  void _listener(int position) {
    setState(() {
      currentPosition = position;
    });
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            timer.cancel();
            done = true;
          } else {
            _start = _start - 1;
            if (_start == 18) {
              _milliSeconds = 200;
            } else if (_start == 16) {
              _milliSeconds = 100;
            } else if (_start == 14) {
              _milliSeconds = 50;
            } else if (_start == 12) {
              _milliSeconds = 30;
            } else if (_start == 10) {
              _milliSeconds = 10;
            } else if (_start == 8) {
              _milliSeconds = 30;
            } else if (_start == 7) {
              _milliSeconds = 50;
            } else if (_start == 6) {
              _milliSeconds = 100;
            } else if (_start == 4) {
              _milliSeconds = 200;
            } else if (_start == 3) {
              _milliSeconds = 250;
            } else if (_start == 2) {
              _milliSeconds = 300;
            } else if (_start == 1) {
              _milliSeconds = 400;
            }
          }
        },
      ),
    );
  }

  animate() {
    if (done == false) {
      if (currentPosition == widget.participants.length - 1) {
        fixedExtentScrollController.jumpToItem(0);
        animate();
      } else {
        fixedExtentScrollController
            .animateToItem(
          currentPosition + 1,
          duration: Duration(milliseconds: _milliSeconds),
          curve: Curves.easeIn,
        )
            .then((_) {
          animate();
        });
      }
    } else {
      setState(() {
        started = false;
        winner = widget.participants[currentPosition];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Slot Machine",
          style: TextStyle(
            color: Colors.red,
            fontSize: 25,
          ),
        ),
        SizedBox(height: 25),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  width: widget.width,
                  height: widget.height,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("lib/assets/lottery.gif"),
                      fit: BoxFit.fill,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: RotatedBox(
                    quarterTurns: 0,
                    child: Container(
                      alignment: Alignment.center,
                      height: widget.height - 50 ?? double.infinity - 50,
                      width: widget.width ?? double.infinity,
                      child: ListWheelScrollView.useDelegate(
                        onSelectedItemChanged: _listener,
                        perspective: 0.01,
                        controller: fixedExtentScrollController,
                        physics: FixedExtentScrollPhysics(),
                        childDelegate: ListWheelChildLoopingListDelegate(
                          children: widget.participants.map((f) {
                            int ind = widget.participants.indexOf(f);
                            return Text(
                              "$f",
                              style: TextStyle(
                                color: ind == currentPosition
                                    ? Colors.red
                                    : Colors.black,
                                fontSize: 15.0,
                              ),
                            );
                          }).toList(),
                        ),
                        useMagnifier: true,
                        magnification: 1,
                        itemExtent: 30,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: widget.width,
                  height: widget.height,
                  alignment: Alignment.center,
                  color: Colors.transparent,
                ),
              ],
            ),
            InkWell(
              onTap: () {
                if (started == false) {
                  setState(() {
                    startAnimation = true;
                    started = true;
                    done = false;
                    winner = "";
                    _start = 20 + random.nextInt(10);
                    _milliSeconds = 300;
                  });
                  Future.delayed(Duration(milliseconds: 900), () {
                    animate();
                    startTimer();
                    startAnimation = false;
                  });
                }
              },
              child: Container(
                width: 45,
                key: UniqueKey(),
                height: widget.height,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      startAnimation
                          ? "lib/assets/slot_animation.gif"
                          : "lib/assets/slot_static.png",
                    ),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 100),
        done == false
            ? SizedBox()
            : Text(
                "Winner:",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
        SizedBox(width: 50),
        done == false
            ? SizedBox()
            : Text(
                "$winner",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 35,
                ),
              ),
      ],
    );
  }
}
