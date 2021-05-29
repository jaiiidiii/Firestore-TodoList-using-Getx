import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:morphosis_demo/model/imdbModel.dart';

class HomeController extends GetxController {
  // var chatsList = List<AllThreads>().obs;
  var moviesList = <Titles>[].obs;
  var isLoading = false.obs;
  var url =
      'https://imdb-internet-movie-database-unofficial.p.rapidapi.com/search/revenge';
  var headers = new Map<String, String>();

  var defaultStatus = false.obs;
  @override
  void onInit() {
    fetchMovies();
    super.onInit();
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
      } else
        throw (response.statusMessage);
    } catch (e) {
      print(e);
    } finally {
      isLoading(false);
    }
  }
}
