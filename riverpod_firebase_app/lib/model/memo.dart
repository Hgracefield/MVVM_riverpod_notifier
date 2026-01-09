class Memo {
  final String id;
  final String title;
  final String content;

  Memo({required this.id, required this.title, required this.content});

  factory Memo.fromMap(Map<String, dynamic> map, String id) {
    return Memo(
      id: id,
      title: map['title'] ?? "",
      content: map['content'] ?? '',
    );
  }
}
