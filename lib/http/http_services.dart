import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpServices {
  static final String apiUrlEndpoint = "https://api.themoviedb.org/3";
  static final String apiKey = "d1755766ad3383f77e88e68115b48a89";

  /// Gets the list of most popular movies, without filters.
  static Future<Map<String, dynamic>> getPopularMovies({int page = 1}) async {
    String url = apiUrlEndpoint +
        "/movie/popular?api_key=$apiKey&language=pt-BR&page=$page";

    Map<String, dynamic> responseBody;
    try {
      http.Response response = await http.get(url);
      responseBody = json.decode(response.body);
      if (response.statusCode == 200) {
        return responseBody;
      } else {
        throw Exception(
            '${response.statusCode}-${responseBody['status_code']}\n${responseBody['status_message']}');
      }
    } catch (exception) {
      throw exception;
    }
  }

  /// Gets the list of every `genre` avaiable.
  static Future<Map<String, dynamic>> getGenres() async {
    String url =
        apiUrlEndpoint + "/genre/movie/list?api_key=$apiKey&language=pt-BR";

    Map<String, dynamic> responseBody;
    try {
      http.Response response = await http.get(url);
      responseBody = json.decode(response.body);
      if (response.statusCode == 200) {
        return responseBody;
      } else {
        throw Exception(
            '${response.statusCode}-${responseBody['status_code']}\n${responseBody['status_message']}');
      }
    } catch (exception) {
      throw exception;
    }
  }

  /// Gets most popular movies that corresponds to the selected `genreId`.
  static Future<Map<String, dynamic>> getMoviesByGenre(int genreId) async {
    String url = apiUrlEndpoint +
        "/genre/$genreId/movies?api_key=$apiKey&language=pt-BR";

    Map<String, dynamic> responseBody;
    try {
      http.Response response = await http.get(url);
      responseBody = json.decode(response.body);
      if (response.statusCode == 200) {
        return responseBody;
      } else {
        throw Exception(
            '${response.statusCode}-${responseBody['status_code']}\n${responseBody['status_message']}');
      }
    } catch (exception) {
      throw exception;
    }
  }
}
