import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_movie_github_app/model/movie.dart';
import 'package:json_movie_github_app/vm/movie_provider.dart';

class Home extends ConsumerWidget {
  //  <<<<<<<
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // <<<<<<<<<
    final movieAsyncValue = ref.watch(movieProvider);
    // async 는 구성이 정해져 있음.
    return Scaffold(
      appBar: AppBar(title: Text('Riverpod JSON App')),
      body: movieAsyncValue.when(
        data: (data) => ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            final Movie movie = data[index];
            return Card(
              child: Row(
                children: [
                  Image.network(movie.image, width: 70),
                  Text('      ${movie.title}'),
                ],
              ),
            );
          },
        ),
        error: (error, stackTrace) => Center(child: Text('오류 발생: $error')),
        loading: () => Center(child: CircularProgressIndicator()),
      ),
    );
  }
}


      // Builder(
      //   builder: (context) {
      //     if (movieAsyncValue.isLoading) {
      //       return Center(child: CircularProgressIndicator());
      //     }
      //     if (movieProvider.error != null) {
      //       return Center(child: Text('오류발생 : ${movieProvider.error}'));
      //     }
      //     return ListView.builder(
      //       itemCount: movieProvider.movies.length,
      //       itemBuilder: (context, index) {
      //         final movie = movieProvider.movies[index];
      //         return Padding(
      //           padding: const EdgeInsets.symmetric(vertical: 3),
      //           child: Card(
      //             child: Row(
      //               children: [
      //                 Image.network(movie.image, width: 70),
      //                 Text('      ${movie.title}'),
      //               ],
      //             ),
      //           ),
      //         );
      //       },
      //     );
      //   },
      // ),