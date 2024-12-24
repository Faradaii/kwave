import 'dart:convert';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:kwave/data/movies.dart';
import 'package:kwave/models/Movie.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          title: Text('Recomendation for you, ${widget.name}'),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            CarouselSlider.builder(
                itemCount: movies.length,
                itemBuilder: (context, index, _) => movieCard(movies[index]),
                options: CarouselOptions(
                    height: MediaQuery.of(context).size.height * 0.6,
                    aspectRatio: 7 / 8,
                    autoPlay: true))
          ]),
        ));
  }

  Widget movieCard(Movie movie) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: Image.network(
                MediaQuery.of(context).size.width > 600
                    ? movie.backdrop : movie.poster,
                errorBuilder: (context, error, stackTrace) {
                  return Center(
                    child: Icon(Icons.error, color: Colors.red),
                  );
                },
              ).image,
              fit: BoxFit.cover),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              movieGenre(movie),
              movieDescription(movie),
            ],
          ),
        ),
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

  Padding movieDescription(Movie movie) {
    return Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Text(
                    movie.originalTitle,
                    style: TextStyle(
                        color: Colors.white70,
                        fontSize:
                            Theme.of(context).textTheme.titleSmall?.fontSize),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    movie.title,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize:
                            Theme.of(context).textTheme.titleLarge?.fontSize),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    movie.description,
                    style: TextStyle(
                        color: Colors.white70,
                        fontSize:
                            Theme.of(context).textTheme.titleSmall?.fontSize),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            );
  }
}
