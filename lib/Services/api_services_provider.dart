import 'dart:convert';
import 'dart:io';
import 'package:assignment_123/Models/movie_detail_model.dart';
import 'package:assignment_123/Models/upcomming_movies_model.dart';
import 'package:assignment_123/res/app_url.dart';
import 'package:assignment_123/res/components/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' hide Response;
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../Models/movies_url_trailer_model.dart';


class DataServices with ChangeNotifier{

  bool loading = false;
  // setData(String tokenVal){
  //   token = tokenVal;
  //   //email1 = emailVal;
  //   notifyListeners();
  // }
  Future<UpcommingMoviesModel> getUpcommingMovies() async {
    dynamic data;
    try{
      final response = await http
          .get(Uri.parse(AppUrl.upcomingMoviesUrlEndPoint))
          .timeout(Duration(seconds: 10));
      data = jsonDecode(response.body.toString());
      print(response.body.toString());
      if (response.statusCode == 200) {
        return UpcommingMoviesModel.fromJson(data);
      } else {
        return UpcommingMoviesModel.fromJson(data);
      }
    }
    on SocketException{
      Get.showSnackbar(GetSnackBar(title: 'No Internet',));
    }
    return UpcommingMoviesModel.fromJson(data);
  }

  Future<MovieDetailModel> getMovieDetail(String id) async {
    dynamic data;
    try{
      final response = await http
          .get(Uri.parse(
          '${AppUrl.detailMoviesUrlEndPoint}$id${AppConstants.apiKey}'))
          .timeout(Duration(seconds: 10));
      data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        print('successs');
        return MovieDetailModel.fromJson(data);
      } else {
        print('failed detailed api status:' +response.statusCode.toString());
        return MovieDetailModel.fromJson(data);
      }
    }
    catch(e){
     Get.showSnackbar(GetSnackBar(title: e.toString(),));
    }
    return MovieDetailModel.fromJson(data);
  }
  Future<MovieUrlTrailerModel> getMovieUrl(String id) async {
    dynamic data;
    try{
      final response = await http
          .get(Uri.parse(
          'https://api.themoviedb.org/3/movie/$id/videos?api_key=b3e6aedd825a4777047c6468f2c5d7af'))
          .timeout(Duration(seconds: 10));
      data = jsonDecode(response.body.toString());
      print(response.body.toString());
      if (response.statusCode == 200) {
        print('successs');
        return MovieUrlTrailerModel.fromJson(data);
      } else {
        print('failed detailed api status:' +response.statusCode.toString());
        return MovieUrlTrailerModel.fromJson(data);
      }
    }
    on SocketException{
    }
    return MovieUrlTrailerModel.fromJson(data);
  }
}