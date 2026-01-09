import 'package:flutter/material.dart';

class BmiCalc extends ChangeNotifier {
  final List<double> _rangeList = [18.5, 22.9, 24.9, 29.9];
  final List<String> _bmiList = ['저체중', '정상체중', '과체중', '비만', '고도비만'];
  final List<String> _bmiImageList = [
    'underweight',
    'normal',
    "risk",
    "overweight",
    'obese',
  ];

  // double _height = 0;
  // double _weight = 0;

  String text = '숫자를 입력하여 bmi를 계산하여라';

  double _bmiValue = 0.0;
  String _bmiString = "정상체중";
  String bmiImageString = "bmi";

  void calcAction(double _height, double _weight) {
    int bmiIndex = _rangeList.length - 1;
    _bmiValue = double.parse(
      (_weight / (_height * _height)).toStringAsFixed(1),
    );

    for (int i = 0; i < _rangeList.length; i++) {
      if (_bmiValue < _rangeList[i]) {
        _bmiString = _bmiList[i];
        bmiImageString = _bmiImageList[i];
        text = '너의 bmi는 $_bmiValue이며 $_bmiString이다';
        break;
      }
    }

    // print('$_bmiValue / $_bmiString');
    notifyListeners();
    // return (bmiList[bmiIndex], bmiIndex, bmi);
  }
}
