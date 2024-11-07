class Movie {
  final String title;
  
  final String year;
  final String imdbID;
  final String type;
  final String poster;
  final String genre;
  final String imdbRating;

  Movie({
    required this.title,
    required this.year,
    required this.imdbID,
    required this.type,
    required this.poster,
    required this.genre,
    required this.imdbRating,
  });

  // Factory constructor to create a Movie instance from JSON
  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['Title'],
      year: json['Year'],
      imdbID: json['imdbID'],
      type: json['Type'],
      poster: json['Poster'],
      genre: json['Genre'] ?? 'N/A',
      imdbRating: json['imdbRating'] ?? 'N/A',
    );
  }
}
