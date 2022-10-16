import 'package:assignment_123/Models/movie_detail_model.dart';
import 'package:assignment_123/Models/movies_url_trailer_model.dart';
import 'package:assignment_123/Services/api_services_provider.dart';
import 'package:assignment_123/Views/seat_map_view.dart';
import 'package:assignment_123/Views/video_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:video_player/video_player.dart';

import '../Models/upcomming_movies_model.dart';
import '../res/colors.dart';
import '../res/components/round_button.dart';

class MoviesDetail extends StatefulWidget {
  String movieId;
  String movieName;
  MoviesDetail({Key? key, required this.movieId, required this.movieName})
      : super(key: key);

  @override
  State<MoviesDetail> createState() => _MoviesDetailState();
}

class _MoviesDetailState extends State<MoviesDetail> {
  Future<MovieDetailModel>? getMoviesDetail;
  DataServices dataServices = DataServices();

  //bool isPlayerOn = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMoviesDetail = dataServices.getMovieDetail(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    final s = MediaQuery.of(context).size;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.purpleColor,
          centerTitle: true,
          toolbarHeight: 75,
          title:Text('More Detail'),
          // shape: RoundedRectangleBorder(
          //     borderRadius:  BorderRadius.only(
          //         bottomRight: Radius.circular(70),
          //         bottomLeft: Radius.circular(70))
          //
          // ),

        ),
        body: Stack(
          children: [
        Container(
          color: Colors.transparent,
          child: FutureBuilder<MovieDetailModel>(
              future: getMoviesDetail,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                         Center(child: CircularProgressIndicator(),)
                        ],
                      ),
                    ),
                  );
                } else {
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: s.height*0.05,
                          right: s.width * 0.1,
                          left: s.width * 0.1,
                            ),
                        child: Container(
                          height: s.height * 0.5,
                          width: s.width,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                                'https://image.tmdb.org/t/p/w500//${snapshot.data?.posterPath ?? '/cwxOwSDwbwUfceIlaWFoo65SdzX.jpg'}',
                                fit: BoxFit.cover,


                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: s.height*0.01,),
                      Text(
                        snapshot.data?.originalTitle.toString() ?? '',
                        style:
                            TextStyle(fontSize: 18,fontWeight: FontWeight.bold,),
                      ),
                      SizedBox(
                        height: s.height * 0.02,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          FutureBuilder<MovieUrlTrailerModel>(
                              future: DataServices()
                                  .getMovieUrl(widget.movieId),
                              builder: (context, snapshot) {
                                return  RoundButton(
                                    color:AppColors.purpleColor,
                                    title: 'Watch Trailer',
                                    callBack: (){
                                  if(snapshot.data!.results!.isNotEmpty){
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => VideoView(
                                              urlKey: snapshot
                                                  .data!.results![0].key
                                                  .toString(),
                                              movieName: widget.movieName
                                            )));
                                  }else{
                                    Get.snackbar(
                                        "Trailer may have been deleted!",
                                        "Sorry!",
                                        animationDuration: Duration(milliseconds: 500),
                                        snackPosition: SnackPosition.BOTTOM,
                                        duration: Duration(seconds: 2)

                                    );
                                  }
                                });
                              }),
                          RoundButton(
                              color: AppColors.purpleColor,
                              title: 'Book Your Ticket', callBack: (){
                            Get.to(SeatMapping());
                          }),
                        ],
                      )
                    ],
                  );
                }
              }),
        ),
        // _watchTrailerController.value.isInitialized?
        //     Container(
        //       height: 300,
        //       child: VideoPlayer(_watchTrailerController),
        //     ):
        //     Center(child: CircularProgressIndicator(),)
          ],
        ),
      ),
    );
  }
}
