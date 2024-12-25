import 'package:flutter/material.dart';

class GenreChip extends StatelessWidget {
  final dynamic genre;

  const GenreChip({
    super.key,
    required this.genre,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        genre,
        style: TextStyle(
            color: Colors.white, fontSize: 8),
      ),
      padding: EdgeInsets.symmetric(
          vertical: 0, horizontal: 4),
      color:
          WidgetStateProperty.all(Colors.black45),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)),
    );
  }
}
