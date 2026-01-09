class CounterState {
  // 전체 계산 상태를 저장하는 데이터 모델
  final int count;
  final int totalClick;

  // 초기상태 지정

  CounterState({this.count = 0, this.totalClick = 0});

  // 특정값이 변경되면 새로운 상태 객체로 만든다.
  // Riverpod 에서는 상태를 직접 수정 할 수 없고, 항상 새로운 상태 객체를 만든다.
  CounterState copyWith({int? count, int? totalClick}) {
    return CounterState(
      count: count ?? this.count,
      totalClick: totalClick ?? this.totalClick,
    );
  }
}
