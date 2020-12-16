import 'package:flutter/foundation.dart';
import 'package:flutter_cubos/controllers/base_controller.dart';
import 'package:flutter_cubos/repositories/home.dart';
import 'package:flutter_cubos/repositories/models/movie.dart';

class HomeProvider extends BaseController {
  HomeProvider() {
    getPopularMovies();
  }
  List<String> genreList = ['Ação', 'Aventura', 'Comédia', 'Drama', 'Sci-fi'];

  HomeRepository homeRepository = HomeRepository();
  List<Movie> get moviesList => homeRepository.moviesList;
  List<Map<String, dynamic>> get genresList => homeRepository.genresList;

  Future<void> getPopularMovies({int page}) async {
    this.setState(ViewState.Busy);
    try {
      await homeRepository.getPopularMovies(page: page);
      this.setState(ViewState.Idle);
    } catch (e) {
      print(e.toString());
      this.setErrorMessage(e.toString());
      this.setState(ViewState.Error);
    }
  }
}
