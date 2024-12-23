import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final String name;

  const HomeScreen({super.key, required this.name});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.2,
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text(widget.name),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return GridView.builder(
              // itemCount: hackathons.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: constraints.maxWidth <= 600 ? 2 : 4),
              itemBuilder: (context, index) {
                return null;

                // final hackathonItem = hackathons[index];
                // return CustomCard(hackathonItem: hackathonItem);
              });
        },
      ),
    );
  }
}
