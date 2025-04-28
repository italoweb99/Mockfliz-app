import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie.dart';

class ApiService {
  static const String _apiKey = 'c603e5708f0df97ff3bcd6e0833721a8';
  static const String _baseUrl = 'https://api.themoviedb.org/3';

  static Future<List<Movie>> getPopularMovies() async {
    return _fetchMovies(
        '$_baseUrl/movie/popular?api_key=$_apiKey&language=pt-BR');
  }

  static Future<List<Movie>> getNowPlayingMovies() async {
    return _fetchMovies(
        '$_baseUrl/movie/now_playing?api_key=$_apiKey&language=pt-BR');
  }

  static Future<List<Movie>> getTopRatedMovies() async {
    return _fetchMovies(
        '$_baseUrl/movie/top_rated?api_key=$_apiKey&language=pt-BR');
  }

  static Future<Movie> getMovieDetails(int movieId) async {
    final response = await http.get(Uri.parse(
        '$_baseUrl/movie/$movieId?api_key=$_apiKey&language=pt-BR&append_to_response=videos'));

    if (response.statusCode == 200) {
      return Movie.fromJson(json.decode(response.body));
    } else {
      throw Exception('Erro ao carregar detalhes do filme');
    }
  }

  static Future<List<Movie>> _fetchMovies(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['results'] as List)
          .map((json) => Movie.fromJson(json))
          .toList();
    } else {
      throw Exception('Erro ao carregar filmes');
    }
  }
}
