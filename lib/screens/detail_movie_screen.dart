import 'package:flutter/material.dart';
import 'package:kwave/models/movie.dart';

class DetailMovieScreen extends StatefulWidget {
  final Movie movie;

  const DetailMovieScreen({super.key, required this.movie});

  @override
  State<DetailMovieScreen> createState() => _DetailMovieScreenState();
}

class _DetailMovieScreenState extends State<DetailMovieScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}