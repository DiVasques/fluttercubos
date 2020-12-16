import 'package:flutter_cubos/http/http_services.dart';
import 'package:flutter_cubos/repositories/models/movie.dart';

class HomeRepository {
  List<Movie> _moviesList;
  List<Movie> get moviesList => _moviesList;
  List<dynamic> _genresList;
  List<dynamic> get genresList => _genresList;

  Future<void> _getGenres() async {
    try {
      Map<String, dynamic> json = await HttpServices.getGenres();
      if (json['genres'] != null) {
        _genresList = json['genres'];
      } else {
        throw Exception('Erro ao carregar gêneros.');
      }
    } catch (exception) {
      throw exception;
    }
  }

  Future<void> getPopularMovies({int page}) async {
    try {
      await _getGenres();
      Map<String, dynamic> json =
          await HttpServices.getPopularMovies(page: page);
      if (json['results'] != null) {
        _moviesList = new List<Movie>();
        json['results'].forEach((v) {
          _moviesList.add(new Movie.fromJson(v, _genresList));
        });
      }
    } catch (exception) {
      throw exception;
    }
  }
}
