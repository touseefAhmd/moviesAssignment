import 'package:assignment_123/res/components/constants.dart';

class AppUrl{

  static var baseUrl = 'https://api.themoviedb.org/3';
  static var upcomingMoviesUrlEndPoint =  baseUrl+'/movie/upcoming'+AppConstants.apiKey;
  static var detailMoviesUrlEndPoint =  baseUrl+'/movie/';


}