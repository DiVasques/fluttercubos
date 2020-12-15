import 'package:flutter_cubos/http/http_services.dart';
import 'package:flutter_cubos/repositories/models/movie.dart';

class HomeRepository {
  List<Movie> _moviesList;
  List<Movie> get moviesList => _moviesList;
  List<Map<String, dynamic>> _genresList;
  List<Map<String, dynamic>> get genresList => _genresList;

  Future<void> getGenres() async {
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
      Map<String, dynamic> json =
          await HttpServices.getPopularMovies(page: page);
      if (json['results'] != null) {
        _moviesList = new List<Movie>();
        json['results'].forEach((Map<String, dynamic> v) {
          _moviesList.add(new Movie.fromJson(v, _genresList));
        });
      }
    } catch (exception) {
      throw exception;
    }
  }
}
