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
        padding: const EdgeInsets.all(10.0),
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

                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height / 4,
                            child: Stack(
                              children: [
                                // Poster image positioned on the left

                                // Text content positioned with shadow and text offset
                                Positioned(
                                  left:
                                      0, // Start the shadow container from the very left
                                  bottom: 0,
                                  right: 0,
                                  child: Material(
                                    elevation: 8, // Shadow elevation
                                    color: Colors
                                        .transparent, // Transparent background for shadow effect
                                    borderRadius: BorderRadius.circular(8),
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                          left: 170,
                                          top: 8,
                                          bottom: 8,
                                          right:
                                              8), // Offset text display by 160 pixels
                                      decoration: BoxDecoration(
                                        color: AppColors.white,
                                        borderRadius: BorderRadius.circular(8),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.2),
                                            blurRadius: 8,
                                            offset: const Offset(2, 4),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            movie.title,
                                            style: GoogleFonts.roboto(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            "Year: ${movie.year}",
                                            style: GoogleFonts.roboto(),
                                          ),
                                          Text(
                                            "Genre: ${movie.genre}",
                                            style: GoogleFonts.roboto(),
                                          ),
                                          Text(
                                            "IMDb Rating: ${movie.imdbRating}",
                                            style: GoogleFonts.roboto(
                                              color: AppColors.blue,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 10,
                                  bottom: 10,
                                  child: Container(
                                    height: MediaQuery.of(context).size.height /
                                        4.2,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: NetworkImage(movie.poster),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
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
