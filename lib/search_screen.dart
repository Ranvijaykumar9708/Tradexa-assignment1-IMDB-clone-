import 'package:flutter/material.dart';
import 'package:movie_search/theme.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts
import 'movie_search_provider.dart';

class SearchScreen extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

  SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
          style: GoogleFonts.roboto(), // Apply Google Font to AppBar title
        ),
        backgroundColor: AppColors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search....',
                hintStyle: GoogleFonts.roboto(), // Apply Google Font to hint
                suffixIcon: const Icon(Icons.search),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onSubmitted: (query) {
                if (query.isNotEmpty) {
                  Provider.of<MovieSearchProvider>(context, listen: false)
                      .searchMovies(query);
                }
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Consumer<MovieSearchProvider>(
                builder: (context, provider, child) {
                  if (provider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (provider.movies.isEmpty) {
                    return Center(
                      child: Text(
                        'No results found.',
                        style: GoogleFonts.roboto(), // Apply Google Font
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: provider.movies.length,
                      itemBuilder: (context, index) {
                        final movie = provider.movies[index];
                        return ListTile(
                          leading: Container(
                            decoration: const BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.black,
                                  blurRadius: 8,
                                  offset: Offset(2, 4),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                movie.poster,
                                height: 200,
                                width: 50,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          title: Text(
                            movie.title,
                            style: GoogleFonts.roboto(
                              fontWeight: FontWeight.bold,
                            ), // Apply Google Font with bold weight
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Year: ${movie.year}",
                                style: GoogleFonts.roboto(), // Apply Google Font
                              ),
                              Text(
                                "Genre: ${movie.genre}",
                                style: GoogleFonts.roboto(), // Apply Google Font
                              ),
                              Text(
                                "IMDb Rating: ${movie.imdbRating}",
                                style: GoogleFonts.roboto(
                                  color: AppColors.blue,
                                ), // Apply Google Font with color
                              ),
                            ],
                          ),
                          trailing: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.green,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              movie.type,
                              style: GoogleFonts.roboto(
                                color: AppColors.white,
                              ), // Apply Google Font with color
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
