import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:riverpod_firebase_app/model/memo.dart';

// FireStore 컬렉션 Provider

final memosCollectionProvider = Provider<CollectionReference>(
  (ref) => FirebaseFirestore.instance.collection('memos'),
);

// 실시간 메모 목록 Provider(StreamProvider)
final memoListProvider = StreamProvider<List<Memo>>((ref) {
  final col = ref.watch(memosCollectionProvider);

  return col.snapshots().map((snapshot) {
    return snapshot.docs
        .map((doc) => Memo.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
  });
});
// 메모 액션 Provider(추가, 삭제)

class MemoActionNotifier extends Notifier<void> {
  @override
  void build() {}

  CollectionReference get _memos => ref.read(memosCollectionProvider);

  Future<void> addMemo(String title, String content) async {
    await _memos.add({'title': title, 'content': content});
  }

  Future<void> deleteMemo(String id) async {
    await _memos.doc(id).delete();
  }
} // MemoNotifier

final memeoActionProvider = NotifierProvider<MemoActionNotifier, void>(
  MemoActionNotifier.new,
);
