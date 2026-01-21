import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lilac_tasks/model/movie_model.dart';

class MovieService {
  Future<List<Movie>> fetchMovies(String query, int page) async {
    final search = query.isEmpty ? 'avengers' : query;
    final response = await http.get(
      Uri.parse('https://omdbapi.com/?apikey=8a3dbd17&s=$search&page=$page'),
    );

    final data = jsonDecode(response.body);

    if (data['Response'] == 'True') {
      return (data['Search'] as List).map((e) => Movie.fromJson(e)).toList();
    }
    return [];
  }

  Future<Map<String, dynamic>> fetchMovieDetails(String imdbId) async {
    final response = await http.get(
      Uri.parse('https://www.omdbapi.com/?apikey=8a3dbd17&i=$imdbId&plot=full'),
    );
    return jsonDecode(response.body);
  }
}
