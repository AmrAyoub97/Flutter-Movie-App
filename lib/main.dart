import 'package:flutter/material.dart';
import 'package:todoapp/screens/movie_details_screen.dart';
import 'screens/dashboard_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  await DotEnv().load('.env');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: DashboardScreen(),
      routes: {MovieDetailsScreen.routeName: (ctx) => MovieDetailsScreen()},
    );
  }
}
