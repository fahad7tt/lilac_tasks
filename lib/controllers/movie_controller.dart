import 'package:flutter/material.dart';
import 'package:lilac_tasks/model/movie_model.dart';
import '../services/movie_service.dart';

class MovieController extends ChangeNotifier {
  final MovieService service;

  MovieController(this.service) {
    searchMovies('Avengers'); // Default search
  }

  List<Movie> movies = [];
  int page = 1;
  bool isLoading = false;
  String currentQuery = '';

  Future<void> searchMovies(String query, {bool loadMore = false}) async {
    if (!loadMore) {
      movies.clear();
      page = 1;
      currentQuery = query;
    }

    isLoading = true;
    notifyListeners();

    final result = await service.fetchMovies(currentQuery, page);
    movies.addAll(result);

    isLoading = false;
    notifyListeners();
  }

  void loadNextPage() {
    page++;
    searchMovies(currentQuery, loadMore: true);
  }
}
