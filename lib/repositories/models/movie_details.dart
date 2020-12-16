class MovieDetails {
  final bool adult;
  final String backdropPath;
  final int budget;
  final int id;
  final String originalLang;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterPath;
  final String company;
  final String releaseDate;
  final String releaseYear;
  final String runtime;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;
  List<String> genres;
  final String posterUrl;
  List<String> cast;
  List<String> crew;

  MovieDetails.fromJson(
    Map<String, dynamic> json,
    List<dynamic> castJson,
    List<dynamic> crewJson,
  )   : adult = json['adult'],
        backdropPath = json['backdrop_path'],
        budget = json['budget'],
        id = json['id'],
        originalLang = json['original_language'],
        originalTitle = json['original_title'],
        overview = json['overview'],
        popularity = json['popularity'],
        posterPath = json['poster_path'],
        posterUrl = "https://image.tmdb.org/t/p/original" + json['poster_path'],
        company = json['production_companies'][0]['name'],
        releaseDate = json['release_date'],
        releaseYear = json['release_date'].split('-')[0],
        runtime = json['runtime'].toString(),
        title = json['title'],
        video = json['video'],
        voteAverage = json['vote_average'],
        voteCount = json['vote_count'] {
    genres = List<String>();
    json['genres'].forEach(
      (genre) {
        if (genre['name'] == "Ficção científica")
          genres.add("Sci-fi");
        else
          genres.add(genre['name']);
      },
    );
    cast = List<String>();
    for (int i = 0; i < castJson.length && i < 6; i++) {
      cast.add(castJson[i]['name']);
    }
    crew = List<String>();
    int count = 0;
    int i = 0;
    while (i < crewJson.length && count < 3) {
      if (crewJson[i]['known_for_department'] == "Directing" &&
          !crew.contains(crewJson[i]['name'])) {
        crew.add(crewJson[i]['name']);
        count++;
      }
      i++;
    }
  }
}
