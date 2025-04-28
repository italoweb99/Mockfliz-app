import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/movie.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieDetailsScreen extends StatelessWidget {
  final int movieId;

  const MovieDetailsScreen({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Filme',
            style: TextStyle(color: Color(0xFFe5e7eb))),
        backgroundColor: const Color(0xFF290133),
      ),
      body: FutureBuilder<Movie>(
        future: ApiService.getMovieDetails(movieId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else {
            final movie = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                children: [
                  Image.network(movie.posterPath),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(movie.title,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  Text('Gênero: ${movie.genres.join(", ")}'),
                  Text('Lançamento: ${movie.releaseDate}'),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(movie.overview, textAlign: TextAlign.center),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (await canLaunchUrl(Uri.parse(movie.trailerUrl))) {
                        await launchUrl(Uri.parse(movie.trailerUrl));
                      }
                    },
                    child: const Text('Assistir Trailer'),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
