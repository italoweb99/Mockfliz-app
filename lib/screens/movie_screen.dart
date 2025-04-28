import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_screen.dart';
import '/services/api_service.dart';
import '/models/movie.dart';
import '/screens/movie_details_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({super.key});

  @override
  _MovieScreenState createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  late Future<List<Movie>> _popularMovies;
  late Future<List<Movie>> _nowPlayingMovies;
  late Future<List<Movie>> _topRatedMovies;

  void _signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  @override
  void initState() {
    super.initState();
    _popularMovies = ApiService.getPopularMovies();
    _nowPlayingMovies = ApiService.getNowPlayingMovies();
    _topRatedMovies = ApiService.getTopRatedMovies();
  }

  Widget buildMovieCarousel(String title, Future<List<Movie>> moviesFuture) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(title,
              style:
                  const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        ),
        FutureBuilder<List<Movie>>(
          future: moviesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Erro: ${snapshot.error}'));
            } else {
              return CarouselSlider(
                options: CarouselOptions(
                    height: 400, autoPlay: true, enlargeCenterPage: true),
                items: snapshot.data!.map((movie) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              MovieDetailsScreen(movieId: movie.id),
                        ),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(movie.posterPath, fit: BoxFit.cover),
                    ),
                  );
                }).toList(),
              );
            }
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser == null) return const LoginScreen();

    return Scaffold(
      appBar: AppBar(title: const Text('Mockflix'), actions: [
        IconButton(onPressed: _signOut, icon: const Icon(Icons.logout))
      ]),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildMovieCarousel("🎬 Filmes Populares", _popularMovies),
            buildMovieCarousel("🎥 Filmes em Cartaz", _nowPlayingMovies),
            buildMovieCarousel("⭐ Mais Bem Avaliados", _topRatedMovies),
          ],
        ),
      ),
    );
  }
}
