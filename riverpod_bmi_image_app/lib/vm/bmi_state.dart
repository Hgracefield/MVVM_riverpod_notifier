class BmiState {
  String imagePath;
  String notiText;

  BmiState({
    this.imagePath = 'bmi',
    this.notiText = '숫자를 입력하여 bmi를 계산하여라'
  });

  BmiState copywith({
    String? imagePath,
    String? notiText
  }){
    return BmiState(
      imagePath: imagePath ?? this.imagePath,
      notiText: notiText ?? this.notiText
    );
  }
}