class Movie {
  String id;
  String title;
  String originalTitle;
  List<String> genre;
  String description;
  String releaseDate;
  String endDate;
  List<Cast> cast;
  double averageRating;
  String poster;
  String backdrop;
  List<OST> ost;
  String createdAt;
  String updatedAt;

  Movie({
    required this.id,
    required this.title,
    required this.originalTitle,
    required this.genre,
    required this.description,
    required this.releaseDate,
    required this.endDate,
    required this.cast,
    required this.averageRating,
    required this.poster,
    required this.backdrop,
    required this.ost,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    var list = json['cast'] as List;
    List<Cast> castList = list.map((i) => Cast.fromJson(i)).toList();

    var ostList = json['ost'] as List;
    List<OST> ostData = ostList.map((i) => OST.fromJson(i)).toList();

    return Movie(
      id: json['id'],
      title: json['title'],
      originalTitle: json['originalTitle'],
      genre: List<String>.from(json['genre']),
      description: json['description'],
      releaseDate: json['releaseDate'],
      endDate: json['endDate'],
      cast: castList,
      averageRating: json['averageRating'],
      poster: json['poster'],
      backdrop: json['backdrop'],
      ost: ostData,
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}

class Cast {
  String actorName;
  String characterName;
  String role;

  Cast({required this.actorName, required this.characterName, required this.role});

  factory Cast.fromJson(Map<String, dynamic> json) {
    return Cast(
      actorName: json['actorName'],
      characterName: json['characterName'],
      role: json['role'],
    );
  }
}

class OST {
  String title;
  String artist;
  String url;

  OST({required this.title, required this.artist, required this.url});

  factory OST.fromJson(Map<String, dynamic> json) {
    return OST(
      title: json['title'],
      artist: json['artist'],
      url: json['url'],
    );
  }
}
