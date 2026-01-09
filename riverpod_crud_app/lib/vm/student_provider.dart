import 'dart:async';
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_crud_app/model/student.dart';

class StudentNotifier extends AsyncNotifier<List<Student>> {
  final String baseUrl = "http://172.16.250.217:8000";

  @override
  Future<List<Student>> build() async {
    return await fetchStudents(); // build되자마자 fetch되는
  }

  Future<List<Student>> fetchStudents() async {
    final res = await http.get(Uri.parse("$baseUrl/select"));

    if (res.statusCode != 200) {
      throw Exception('불러오기 실패 : ${res.statusCode}'); // throw에서 걸리면 밑으로 진행 X.
    }

    final data = json.decode(utf8.decode(res.bodyBytes));
    return (data['results'] as List).map((d) => Student.fromJson(d)).toList(); // 등록필
  }

  Future<String> insertStudent(Student s) async {
    final url = Uri.parse("$baseUrl/insert");
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(s.toJson()),
    );
    final data = json.decode(utf8.decode(response.bodyBytes));
    await refreshStudents();
    return data['result'];
  }

  Future<String> updateStudent(Student s) async {
    final url = Uri.parse('$baseUrl/update');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(s.toJson()),
    );
    final data = json.decode(utf8.decode(response.bodyBytes));
    await refreshStudents();
    return data['result'];
  }

  Future<String> deleteStudent(String code) async {
    final url = Uri.parse('$baseUrl/delete');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'code': code}),
    );
    final data = json.decode(utf8.decode(response.bodyBytes));
    await refreshStudents();
    return data['result'];
  }

  // 입력은 도ㅒㅆ는데 화면에 안나오는거때문에 넣은 함수
  Future<void> refreshStudents() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async => await fetchStudents());
  }
} // StudentNotofier

final studentNotifierProvider = AsyncNotifierProvider<StudentNotifier, List<Student>>(
  StudentNotifier.new,
);
