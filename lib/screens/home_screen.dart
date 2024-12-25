import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:kwave/data/movies.dart';
import 'package:kwave/models/movie.dart';
import 'package:kwave/screens/detail_movie_screen.dart';
import 'package:kwave/widgets/genre_chip.dart';

class HomeScreen extends StatefulWidget {
  final String name;

  const HomeScreen({super.key, required this.name});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

List<Movie> loadMovies() {
  String jsonString = movies;

  List<dynamic> jsonData = json.decode(jsonString);

  return jsonData.map((data) => Movie.fromJson(data)).toList();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Movie> movies = loadMovies();

  var selectedGenre = <String>{};

  @override
  Widget build(BuildContext context) {
    final List<Movie> bestMovies = movies
        .where((element) => element.averageRating > 8)
        .toList()
      ..sort((a, b) => b.averageRating.compareTo(a.averageRating));
    final List<String> genreList =
        movies.expand((element) => element.genre).toSet().toList();

    var filteredMovies = movies.where((movie) {
      if (selectedGenre.isEmpty) return true;
      return movie.genre.any((g) => selectedGenre.contains(g));
    }).toList();

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          centerTitle: true,
          title: SizedBox(
            height: 60,
            width: 60,
            child: ClipRRect(
              child: Image.asset(
                "assets/kwave.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                'Recomendation for you, ${widget.name}',
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize:
                        Theme.of(context).textTheme.headlineSmall?.fontSize),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                "Best Movies",
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: Theme.of(context).textTheme.titleLarge?.fontSize),
              ),
            ),
            CarouselSlider.builder(
                itemCount: bestMovies.take(5).length,
                itemBuilder: (context, index, _) =>
                    movieCard(bestMovies[index]),
                options: CarouselOptions(
                    height: MediaQuery.of(context).size.height * 0.6,
                    aspectRatio: 7 / 8,
                    autoPlay: true)),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                "All Movies",
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: Theme.of(context).textTheme.titleLarge?.fontSize),
              ),
            ),
            filterGenreMovies(genreList),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: filteredMovies.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:
                      MediaQuery.of(context).size.width > 1000 ? 4 : 2,
                  mainAxisExtent: 300,
                ),
                itemBuilder: (context, index) {
                  return movieCard(filteredMovies[index], isShowGenre: false);
                },
              ),
            ),
          ]),
        ));
  }

  SingleChildScrollView filterGenreMovies(List<String> genreList) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: FilterChip(
              label: Text("All"),
              selected: selectedGenre.isEmpty,
              onSelected: (bool value) {
                setState(() {
                  if (value) {
                    selectedGenre.clear();
                  }
                });
              },
            ),
          ),
          Row(
            children: List.generate(
              genreList.length,
              (index) => Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: FilterChip(
                  label: Text(genreList[index]),
                  selected: selectedGenre.contains(genreList[index]),
                  onSelected: (bool value) {
                    setState(() {
                      if (value) {
                        selectedGenre.add(genreList[index]);
                      } else {
                        selectedGenre.remove(genreList[index]);
                      }
                    });
                  },
                ),
              ),
            ),
          ),
          SizedBox(width: 8),
        ],
      ),
    );
  }

  Widget movieCard(Movie movie, {bool isShowGenre = true}) {
    return Padding(
      padding: EdgeInsets.all(6),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailMovieScreen(movie: movie)));
        },
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: Image.network(
                  MediaQuery.of(context).size.width > 600
                      ? movie.backdrop
                      : movie.poster,
                  errorBuilder: (context, error, stackTrace) {
                    return Center(
                      child: Icon(Icons.error, color: Colors.red),
                    );
                  },
                ).image,
                fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(20),
          ),
          child: movieContainer(movie, isShowGenre),
        ),
      ),
    );
  }

  Container movieContainer(Movie movie, bool isShowGenre) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 14),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Colors.black.withAlpha(200),
              Colors.black.withAlpha(50),
              Colors.black.withAlpha(0),
            ],
          )),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (isShowGenre) movieGenre(movie),
          Expanded(child: movieDescription(movie, isTitleLarge: isShowGenre)),
        ],
      ),
    );
  }

  SingleChildScrollView movieGenre(Movie movie) {
    return SingleChildScrollView(
      child: Row(
        children: movie.genre
            .map((genre) => Theme(
                  data: Theme.of(context)
                      .copyWith(canvasColor: Colors.transparent),
                  child: Row(
                    children: [
                      GenreChip(genre: genre),
                      const SizedBox(
                        width: 2,
                      ),
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }

  Padding movieDescription(Movie movie, {bool isTitleLarge = true}) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            movie.originalTitle,
            style: TextStyle(
                color: Colors.white70,
                fontSize: Theme.of(context).textTheme.titleSmall?.fontSize),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            movie.title,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: isTitleLarge
                    ? Theme.of(context).textTheme.titleLarge?.fontSize
                    : Theme.of(context).textTheme.titleMedium?.fontSize),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            movie.description,
            style: TextStyle(
                color: Colors.white70,
                fontSize: Theme.of(context).textTheme.titleSmall?.fontSize),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
