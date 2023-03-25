import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'model/movie_model.dart';

class HttpHelper {
  late List<MovieModel> movieData = [];

  Future<void> getData(movieName) async {
    var url = Uri.parse(
        "https://www.omdbapi.com/?s=$movieName&page=2&apikey=604c7d75");
    http.Response jsonData = await http.get(url);
    var data = jsonDecode(jsonData.body);
    if (data["Response"] != "False") {
      data["Search"].forEach((e) {
        if (e["Title"] != null && e["Poster"] != null && e["Year"] != null) {
          MovieModel newData = MovieModel(
              title: e["Title"], urlToImage: e["Poster"], year: e["Year"]);
          movieData.add(newData);
        }
      });
    }
  }
}
