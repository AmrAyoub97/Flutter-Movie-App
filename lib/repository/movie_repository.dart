import '../networking/ApiProvider.dart';
import 'dart:async';
import '../models/movie.dart';

class MovieRepository {
  ApiProvider _provider = ApiProvider();
  Future<List<Movie>> fetchMoviesData(url) async {
    final response = await _provider.get("$url");
    return Movie.listFromJson(response);
  }
}
