import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'movie_search_provider.dart';
import 'search_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MovieSearchProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SearchScreen(),
      ),
    );
  }
}