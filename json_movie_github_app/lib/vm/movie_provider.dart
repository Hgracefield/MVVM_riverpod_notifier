// api 가져오면 끝. state 가 필요없음.
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:json_movie_github_app/model/movie.dart';
import 'package:http/http.dart' as http;

class MovieNotifier extends AsyncNotifier<List<Movie>> {
  @override
  Future<List<Movie>> build() async {
    return fetchMovies();
  }
}

Future<List<Movie>> fetchMovies() async {
  final url = Uri.parse("https://zeushahn.github.io/Test/movies.json");
  final response = await http.get(url);

  if (response.statusCode != 200) {
    throw Exception('데이터 로딩 실패!: ${response.statusCode}');
  }

  if (response.statusCode == 200) {
    final data = json.decode(utf8.decode(response.bodyBytes));
    final List results = data['results'];
    // Data 존재 파악
    return results
        .map((data) => Movie(image: data['image'] ?? '', title: data['title'] ?? ''))
        .toList();
  }
} // MovieNOtifier

// 상태 저장용
final movieProvider = AsyncNotifierProvider<MovieNotifier, List<Movie>>(
  MovieNotifier.new,
);
// 여기까지는 상태를 저장하는 용도 보여주기 x.(e)
