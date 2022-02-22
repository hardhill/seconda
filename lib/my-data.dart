import 'dart:async';

import 'package:flutter/material.dart';

class MyData extends ChangeNotifier {
  late int _count;
  late bool _isRunning;
  late bool _stopPressed;
  MyData() {
    _count = 0;
    _isRunning = false;
    _stopPressed = false;
  }
  void _run() {
    if (!_isRunning) {
      Timer.periodic(Duration(milliseconds: 10), (timer) {
        if (_stopPressed) {
          timer.cancel();
          _isRunning = false;
          notifyListeners();
        } else {
          _count++;
          _isRunning = true;
          notifyListeners();
        }
      });
    }
  }

  void startstop() {
    if (_isRunning) {
      _stopPressed = true;
    } else {
      _stopPressed = false;
      _run();
    }
  }

  void reset() {
    if (!_isRunning) {
      _count = 0;
      notifyListeners();
    }
  }

  int get count => _count;
  bool get running => _isRunning;
}
