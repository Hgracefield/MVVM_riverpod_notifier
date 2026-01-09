import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_bmi_image_app/vm/bmi_state.dart';

class BmiNotifier extends Notifier<BmiState> {
  BmiState build() => BmiState();

  final List<double> _rangeList = [18.5, 22.9, 24.9, 29.9];
  final List<String> _bmiList = ['저체중', '정상체중', '과체중', '비만', '고도비만'];
  final List<String> _bmiImageList = [
    'underweight',
    'normal',
    "risk",
    "overweight",
    'obese',
  ];
  double _bmiValue = 0.0;
  String _bmiString = "정상체중";
  String bmiImageString = '';
  String text = '';
  void calcAction(double _height, double _weight) {
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

    state = state.copywith(imagePath: bmiImageString, notiText: text);
  }
}

final bmiProvider = NotifierProvider<BmiNotifier, BmiState>(BmiNotifier.new);
