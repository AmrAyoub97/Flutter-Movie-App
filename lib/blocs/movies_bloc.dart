import 'dart:async';
import '../networking/Response.dart';
import '../repository/movie_repository.dart';
import '../models/movie.dart';

class MovieBloc {
  MovieRepository _movieRepository;
  StreamController _movieDataController;

  StreamSink<Response<List<Movie>>> get movieDataSink =>
      _movieDataController.sink;

  Stream<Response<List<Movie>>> get movieDataStream =>
      _movieDataController.stream;

  MovieBloc(url) {
    _movieDataController = StreamController<Response<List<Movie>>>();
    _movieRepository = MovieRepository();
    fetchMovie(url);
  }

  fetchMovie(url) async {
    print("getting movies-- BLoC");
    movieDataSink.add(Response.loading('Getting movies!'));
    try {
      List<Movie> movies = await _movieRepository.fetchMoviesData(url);
      movieDataSink.add(Response.completed(movies));
    } catch (e) {
      movieDataSink.add(Response.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _movieDataController?.close();
  }
}
