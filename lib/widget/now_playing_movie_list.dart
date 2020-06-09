import 'package:flutter/material.dart';
import 'package:todoapp/models/movie.dart';
import 'package:todoapp/screens/movie_details_screen.dart';
import '../blocs/movies_bloc.dart';
import '../networking/Response.dart';

class NowPlayingMovieList extends StatefulWidget {
  @override
  _GetMovieState createState() => _GetMovieState();
}

class _GetMovieState extends State<NowPlayingMovieList> {
  MovieBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = MovieBloc('now_playing');
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      child: RefreshIndicator(
        onRefresh: () => _bloc.fetchMovie('now_playing'),
        child: StreamBuilder<Response<List<Movie>>>(
          stream: _bloc.movieDataStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data.status) {
                case Status.LOADING:
                  return Loading(loadingMessage: snapshot.data.message);
                  break;
                case Status.COMPLETED:
                  print(snapshot.data.data);
                  return MovieList(
                    movieList: snapshot.data.data,
                  );
                  break;
                case Status.ERROR:
                  return Error(
                    errorMessage: snapshot.data.message,
                    onRetryPressed: () => _bloc.fetchMovie('now_playing'),
                  );
                  break;
              }
            }
            return Container();
          },
        ),
      ),
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movieList;

  const MovieList({this.movieList});

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: movieList.length,
      itemBuilder: (context, index) {
        return Container(
          width: 160,
          padding: const EdgeInsets.all(10.0),
          child: GestureDetector(
            onTap: () {
              print(movieList[index]);
              Navigator.of(context).pushNamed(MovieDetailsScreen.routeName,
                  arguments: {'movie': movieList[index]});
            },
            child: Column(
              children: <Widget>[
                Card(
                  elevation: 10,
                  child: Hero(
                    tag: movieList[index].id,
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                            image: NetworkImage(
                                'https://image.tmdb.org/t/p/w500' +
                                    movieList[index].backdropPath),
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    movieList[index].title,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class Error extends StatelessWidget {
  final String errorMessage;

  final Function onRetryPressed;

  const Error({Key key, this.errorMessage, this.onRetryPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 8),
          RaisedButton(
            color: Colors.white,
            child: Text('Retry', style: TextStyle(color: Colors.black)),
            onPressed: onRetryPressed,
          )
        ],
      ),
    );
  }
}

class Loading extends StatelessWidget {
  final String loadingMessage;

  const Loading({Key key, this.loadingMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            loadingMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
          SizedBox(height: 24),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ],
      ),
    );
  }
}
