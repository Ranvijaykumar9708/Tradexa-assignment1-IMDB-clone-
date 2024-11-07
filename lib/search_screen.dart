import 'package:flutter/material.dart';
import 'package:movie_search/theme.dart';
import 'package:provider/provider.dart';
import 'movie_search_provider.dart';

class SearchScreen extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

  SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
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
                    return const Center(child: Text('No results found.'));
                  } else {
                    return ListView.builder(
                      itemCount: provider.movies.length,
                      itemBuilder: (context, index) {
                        final movie = provider.movies[index];
                        return ListTile(
                          leading: Container(
                            height: 200,
                            width: 130,
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
                                width: 130,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          title: Text(movie.title),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Year: ${movie.year}"),
                              Text("Genre: ${movie.genre}"),
                              Text(
                                "IMDb Rating: ${movie.imdbRating}",
                                style: const TextStyle(color: AppColors.blue),
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
                              style: const TextStyle(color: AppColors.white),
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