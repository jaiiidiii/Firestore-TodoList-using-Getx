import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morphosis_demo/model/imdbModel.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController {
  GetStorage box;

  // var chatsList = List<AllThreads>().obs;
  var moviesList = <Titles>[].obs;
  var searchResult = <Titles>[].obs;
  String moviesKey = 'moviesList';
  var isLoading = false.obs;
  var url =
      'https://imdb-internet-movie-database-unofficial.p.rapidapi.com/search/revenge';
  var headers = new Map<String, String>();
  TextEditingController searchTextField = TextEditingController();

  var defaultStatus = false.obs;
  @override
  void onInit() {
    box = GetStorage();
    renderMovies();
    super.onInit();
  }

  onSearchTextChanged(String text) async {
    searchResult.clear();
    if (text.isEmpty) {
      return;
    }

    moviesList.forEach((userDetail) {
      if (userDetail.title.toLowerCase().contains(text.toLowerCase())) {
        searchResult.add(userDetail);
      }
    });
  }

  fetchMovies() async {
    try {
      isLoading(true);

      headers[HttpHeaders.contentTypeHeader] = 'application/json';
      headers['Accept-Language'] = 'en';
      headers['x-rapidapi-key'] =
          '0a25ec8fe2mshe79a3bd2ace88afp1a1b58jsnc6a9fd312516';
      headers['x-rapidapi-host'] =
          'imdb-internet-movie-database-unofficial.p.rapidapi.com';
      headers['useQueryString'] = 'true';

      var response = await Dio().get(url, options: Options(headers: headers));
      if (response.statusCode == 200 && response.data != null) {
        moviesList.clear();
        var res = ImdbResponse.fromJson(response.data);
        moviesList(res.titles);
        box.erase();
        box.write(moviesKey, res.titles);
      } else
        throw (response.statusMessage);
    } catch (e) {
      print(e);
    } finally {
      isLoading(false);
    }
  }

  void renderMovies() {
    try {
      isLoading(true);
      var res = box.read(moviesKey);

      if (res == null)
        fetchMovies();
      else {
        res.forEach((e) {
          return moviesList.add(Titles.fromJson(e));
        });
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading(false);
    }
  }
}
