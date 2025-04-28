class Movie {
  final int id;
  final String title;
  final String posterPath;
  final String overview;
  final String releaseDate;
  final List<String> genres;
  final String trailerUrl;

  Movie({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
    required this.releaseDate,
    required this.genres,
    required this.trailerUrl,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    List<String> genreNames = (json['genres'] as List<dynamic>?)
            ?.map((g) => g['name'].toString())
            .toList() ??
        [];

    String trailer = '';
    if (json['videos'] != null && json['videos']['results'] != null) {
      final videoList = json['videos']['results'] as List<dynamic>;
      final video = videoList.firstWhere(
          (v) => v['type'] == 'Trailer' && v['site'] == 'YouTube',
          orElse: () => {});
      if (video.isNotEmpty) {
        trailer = 'https://www.youtube.com/watch?v=${video['key']}';
      }
    }

    return Movie(
      id: json['id'],
      title: json['title'],
      posterPath: 'https://image.tmdb.org/t/p/w500${json['poster_path']}',
      overview: json['overview'] ?? 'Sem descrição disponível',
      releaseDate: json['release_date'] ?? 'Desconhecido',
      genres: genreNames,
      trailerUrl: trailer,
    );
  }
}
