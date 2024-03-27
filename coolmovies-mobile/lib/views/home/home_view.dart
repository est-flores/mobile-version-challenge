import 'package:coolmovies/widgets/custom_app_bar.dart';
import 'package:coolmovies/widgets/movie_list.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [const MovieList(), CustomAppBar(title: widget.title)],
        ),
      ),
    );
  }
}
