import 'package:flutter/material.dart';
import 'package:todoapp/widget/now_playing_movie_list.dart';
import '../widget/popular_movie_list.dart';
import '../widget/top_rated_movie_list.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movies App'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () {})
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Now Playing',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  FlatButton(
                    child: Text('View All'),
                    onPressed: () {},
                  )
                ],
              ),
            ),
            NowPlayingMovieList(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Top 3 Rated',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  FlatButton(
                    child: Text('View All'),
                    onPressed: () {},
                  )
                ],
              ),
            ),
            TopRatedMovieList(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Popular',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  FlatButton(
                    child: Text('View All'),
                    onPressed: () {},
                  )
                ],
              ),
            ),
            PopularMovieList(),
          ],
        ),
      ),
    );
  }
}
