import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:textfield_calc_ex_app/vm/calc_notifier.dart';

class Home extends ConsumerWidget {
  Home({super.key});
  // property
  final num1Controller = TextEditingController();
  final num2Controller = TextEditingController();
  final addController = TextEditingController();
  final subController = TextEditingController();
  final mulController = TextEditingController();
  final divController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(calcProvider);

    // 초기값 정의 : 결과를 텍스트로 갱신
    // num1, num2 를 써도 되는데 쓰게되면 0이 보여서 사용자가 지우고 작성 해야함.
    addController.text = state.addResult.toString();
    subController.text = state.subResult.toString();
    mulController.text = state.mulResult.toString();
    divController.text = state.divResult.toStringAsFixed(3);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('간단한 계산기')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildInputTextField('첫번째 숫자를 입력하세요', num1Controller),
              buildInputTextField('두번째 숫자를 입력하세요', num2Controller),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 10, 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    ElevatedButton(
                      onPressed: () {
                        calcAction(
                          context,
                          ref,
                        ); // context 를 만드는게 build 함수라서 build 밖에서는 context를 모르기때문에 작성해줘야함
                      },
                      child: Text('계산하기'),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        removeAction(
                          context,
                          ref,
                        ); // context 를 만드는게 build 함수라서 build 밖에서는 context를 모르기때문에 작성해줘야함
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        foregroundColor: Colors.white,
                      ),
                      child: Text('지우기'),
                    ),
                  ],
                ),
              ),

              buildResultTextField('덧셈 결과', addController),
              buildResultTextField('뺄셈 결과', subController),
              buildResultTextField('곱셈 결과', mulController),
              buildResultTextField('나눗셈 결과', divController),
            ],
          ),
        ),
      ),
    );
  } // build

  // =========== widgets ======================
  Widget buildInputTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
      keyboardType: TextInputType.number,
    );
  }

  // 결과 위젯
  Widget buildResultTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
        ),

        readOnly: true,
      ),
    );
  }

  // ==================== functions==================
  void calcAction(BuildContext context, WidgetRef ref) {
    final num1Text = num1Controller.text.trim();
    final num2Text = num2Controller.text.trim();

    if (num1Text.isEmpty || num2Text.isEmpty) {
      errorSnackBar(context);
      return;
    }
    final num1 =
        int.tryParse(num1Text) ?? 0; // parsing이 안되면 무조건 0. => space 사용시
    final num2 = int.tryParse(num2Text) ?? 0;

    ref.read(calcProvider.notifier).calculate(num1, num2);
  }

  void removeAction(BuildContext context, WidgetRef ref) {
    num1Controller.clear();
    num2Controller.clear();
    ref.read(calcProvider.notifier).clear();
  }

  void errorSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('숫자를 입력 하세요'),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
      ),
    );
  }
} // class
