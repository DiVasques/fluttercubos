import 'package:flutter_cubos/http/http_services.dart';

class Movie {
  final bool adult;
  final String backdropPath;
  final List<dynamic> genreIds;
  final int id;
  final String originalLang;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterPath;
  final String releaseDate;
  final String releaseYear;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;
  List<String> genres;
  final String posterUrl;

  Movie.fromJson(
      Map<String, dynamic> json, List<dynamic> _genresIdList)
      : adult = json['adult'],
        backdropPath = json['backdrop_path'],
        genreIds = json['genre_ids'],
        id = json['id'],
        originalLang = json['original_language'],
        originalTitle = json['original_title'],
        overview = json['overview'],
        popularity = json['popularity'],
        posterPath = json['poster_path'],
        posterUrl =
            "https://image.tmdb.org/t/p/original" + json['poster_path'],
        releaseDate = json['release_date'],
        releaseYear = json['release_date'].split('-')[0],
        title = json['title'],
        video = json['video'],
        voteAverage = json['vote_average'],
        voteCount = json['vote_count'] {
    genres = List<String>();
    genreIds.forEach(
      (id) {
        _genresIdList.forEach(
          (e) {
            if (e['id'] == id) genres.add(e['name']);
          },
        );
      },
    );
  }
}
