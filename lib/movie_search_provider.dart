import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_search/movie_model.dart';

class MovieSearchProvider with ChangeNotifier {
  bool isLoading = false;
  List<Movie> movies = [];

  Future<void> searchMovies(String query) async {
    isLoading = true;
    notifyListeners();

    final url = 'https://www.omdbapi.com/?apikey=52858e96&s=$query';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final List results = jsonResponse['Search'] ?? [];

        // Fetch additional details for each movie
        movies = await Future.wait(results.map((movieJson) async {
          final imdbID = movieJson['imdbID'];
          final movieDetailsUrl = 'https://www.omdbapi.com/?apikey=52858e96&i=$imdbID';
          final detailsResponse = await http.get(Uri.parse(movieDetailsUrl));
          
          if (detailsResponse.statusCode == 200) {
            final movieDetailsJson = json.decode(detailsResponse.body);
            return Movie.fromJson(movieDetailsJson);
          } else {
            return Movie.fromJson(movieJson);
          }
        }).toList());
      } else {
        throw Exception('Failed to load movies');
      }
    } catch (error) {
      print("Error fetching movies: $error");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}