import 'package:flutter/material.dart';
import 'package:kwave/models/movie.dart';
import 'package:kwave/utils/date_range_util.dart';

class DetailMovieScreen extends StatefulWidget {
  final Movie movie;

  const DetailMovieScreen({super.key, required this.movie});

  @override
  State<DetailMovieScreen> createState() => _DetailMovieScreenState();
}

class _DetailMovieScreenState extends State<DetailMovieScreen> {
  @override
  Widget build(BuildContext context) {
    final Movie movie = widget.movie;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: detailAppbar(context),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
          child: Stack(
        alignment: Alignment.topCenter,
        children: [
          imageDetail(context, movie),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withAlpha(200),
                Colors.black.withAlpha(0),
                Colors.black.withAlpha(50),
                Colors.black.withAlpha(0),
              ],
            )),
            child: Column(children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
              ),
              contentDetail(movie, context),
            ]),
          ),
        ],
      )),
    );
  }

  AppBar detailAppbar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  ClipRRect imageDetail(BuildContext context, Movie movie) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Image.network(
              MediaQuery.of(context).size.width > 600
                  ? movie.backdrop
                  : movie.poster,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }
            return const Center(child: CircularProgressIndicator());
          }, errorBuilder: (context, error, stackTrace) {
            return const Center(
              child: Icon(Icons.error, color: Colors.red),
            );
          }),
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withAlpha(0),
                  Colors.black.withAlpha(200),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container contentDetail(Movie movie, BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.black.withAlpha(0),
          Colors.black,
        ],
      )),
      child: Column(
        children: [
          Text(
            movie.title,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: Theme.of(context).textTheme.titleLarge?.fontSize),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            "⭐ ${movie.averageRating}/10 | ${movie.genre.join(", ")}",
            style: TextStyle(
                color: Colors.white,
                fontSize: Theme.of(context).textTheme.titleSmall?.fontSize),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 10),
          playButton(context),
          const SizedBox(height: 10),
          Text(
            movie.description,
            style: TextStyle(
                color: Colors.white,
                fontSize: Theme.of(context).textTheme.titleSmall?.fontSize),
            textAlign: TextAlign.start,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 10),
          productionInfo(movie, context),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Cast",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: Theme.of(context).textTheme.titleMedium?.fontSize),
            ),
          ),
          const SizedBox(height: 10),
          castList(movie, context),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Official Soundtrack",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: Theme.of(context).textTheme.titleMedium?.fontSize),
            ),
          ),
          const SizedBox(height: 10),
          ostList(movie, context)
        ],
      ),
    );
  }

  FilledButton playButton(BuildContext context) {
    return FilledButton(
      onPressed: () {},
      style: FilledButton.styleFrom(
        backgroundColor: Colors.lightBlue,
        maximumSize: Size(MediaQuery.of(context).size.width * 0.3, 50),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.play_arrow_rounded,
            color: Colors.white,
            size: 24,
          ),
          Text(
            "Play",
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Row productionInfo(Movie movie, BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.calendar_month,
          color: Colors.white,
          size: 16,
        ),
        const SizedBox(width: 5),
        Text(
          "Production : ${DateRangeFormatter.formatDateRange(movie.releaseDate, movie.endDate)}",
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize),
        ),
      ],
    );
  }

  SingleChildScrollView castList(Movie movie, BuildContext context) {
    return SingleChildScrollView(
      child: Row(
        children: movie.cast
            .map((cast) => Row(
                  children: [
                    Column(
                      children: [
                        ClipOval(
                          child: Image.network(cast.photoUrl,
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover, loadingBuilder:
                                  (context, child, loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return const Center(
                                child: CircularProgressIndicator());
                          }, errorBuilder: (context, error, stackTrace) {
                            return const Center(
                              child: const Icon(Icons.error, color: Colors.red),
                            );
                          }),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          cast.characterName,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 10),
                        ),
                        Text(
                          cast.actorName,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.fontSize),
                        ),
                      ],
                    ),
                    const SizedBox(width: 10),
                  ],
                ))
            .toList(),
      ),
    );
  }

  SingleChildScrollView ostList(Movie movie, BuildContext context) {
    return SingleChildScrollView(
      child: Row(
        children: movie.ost
            .map((ost) => Row(
                  children: [
                    Column(
                      children: [
                        ClipOval(
                          child: Image.network(ost.albumPhotoUrl,
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover, loadingBuilder:
                                  (context, child, loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return const Center(
                                child: CircularProgressIndicator());
                          }, errorBuilder: (context, error, stackTrace) {
                            return const Center(
                              child: Icon(Icons.error, color: Colors.red),
                            );
                          }),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          ost.artist,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 10),
                        ),
                        Text(
                          ost.title,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.fontSize),
                        ),
                      ],
                    ),
                    const SizedBox(width: 10),
                  ],
                ))
            .toList(),
      ),
    );
  }
}
