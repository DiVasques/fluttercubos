import 'package:flutter/foundation.dart';
import 'package:flutter_cubos/controllers/base_controller.dart';
import 'package:flutter_cubos/repositories/models/movie_details.dart';
import 'package:flutter_cubos/repositories/movie_details.dart';

class MovieDetailsProvider extends BaseController {
  final int movieId;
  MovieDetailsProvider({@required this.movieId}) {
    getMovieDetails(movieId: movieId);
  }

  MovieDetailsRepository movieDetailsRepository = MovieDetailsRepository();
  MovieDetails get movie => movieDetailsRepository.movieDetails;

  Future<void> getMovieDetails({@required int movieId}) async {
    this.setState(ViewState.Busy);
    try {
      await movieDetailsRepository.getMovieDetails(movieId);
      this.setState(ViewState.Idle);
    } catch (e) {
      print('controller');
      print(e.toString());
      this.setErrorMessage(e.toString());
      this.setState(ViewState.Error);
    }
  }
}
