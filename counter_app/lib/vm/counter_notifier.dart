import 'package:counter_app/vm/counter_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

// CounterNotifier : 상태를 변경하는 로직을 담당하는 클래스
// StateNotifier : 상태를 직접 관리하고 변경하는 로직을 담당하는 클래스
// CounterState :  우리가 관리할 상태의 데이터 타입을 지정하는 클래스
class CounterNotifier extends Notifier<CounterState> {
  // Notifier가 처음 생성될때 초기 상태값을 설정
  CounterState build() => CounterState();
  // + 버튼
  void increment() {
    state = state.copyWith(
      count: state.count + 1,
      totalClick: state.totalClick + 1,
    );
  }
  // - 버튼

  void decrement() {
    state = state.copyWith(
      count: state.count - 1,
      totalClick: state.totalClick - 1,
    );
  }
} // class

// StateNotifierProvider : 클래스를 외부에서 사용 가능하게 만들어 주는 provider
final counterProvider = NotifierProvider<CounterNotifier, CounterState>(
  CounterNotifier.new,
);
