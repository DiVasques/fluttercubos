import 'package:flutter_cubos/http/http_services.dart';
import 'package:flutter_cubos/repositories/models/movie_details.dart';

class MovieDetailsRepository {
  MovieDetails _movieDetails;
  MovieDetails get movieDetails => _movieDetails;
  List<dynamic> _castList;
  List<dynamic> _crewList;

  Future<void> getMovieCastAndCrew(int movieId) async {
    try {
      Map<String, dynamic> json =
          await HttpServices.getMovieCastAndCrew(movieId);
      if (json['cast'] != null) {
        _castList = json['cast'];
      }
      if (json['crew'] != null) {
        _crewList = json['crew'];
      }
    } catch (exception) {
      throw exception;
    }
  }

  Future<void> getMovieDetails(int movieId) async {
    try {
      await getMovieCastAndCrew(movieId);
      Map<String, dynamic> json = await HttpServices.getMovieDetails(movieId);
      if (json != null) {
        _movieDetails = MovieDetails.fromJson(json, _castList, _crewList);
      }
    } catch (exception) {
      print('caiu na hora do modelo');
      print(exception.toString());
      throw exception;
    }
  }
}
