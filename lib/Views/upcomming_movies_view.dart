import 'package:assignment_123/Models/upcomming_movies_model.dart';
import 'package:assignment_123/Services/api_services_provider.dart';
import 'package:assignment_123/Views/movies_detail_view.dart';
import 'package:assignment_123/res/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../res/components/constants.dart';

class UpcommingMoviesView extends StatefulWidget {
  const UpcommingMoviesView({Key? key}) : super(key: key);

  @override
  State<UpcommingMoviesView> createState() => _UpcommingMoviesViewState();
}

class _UpcommingMoviesViewState extends State<UpcommingMoviesView> {
  Future<UpcommingMoviesModel>? getUpCommingMovies;
  bool isActice = false;
  TextEditingController moviesCountroller= TextEditingController();
  DataServices dataServices = DataServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUpCommingMovies = dataServices.getUpcommingMovies();
  }

  @override
  Widget build(BuildContext context) {
    final s = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
       // backgroundColor: Colors.,
        appBar: AppBar(
          backgroundColor: AppColors.purpleColor,
          centerTitle: true,
          toolbarHeight: 75,
          shape: RoundedRectangleBorder(
              borderRadius:  BorderRadius.only(
                  bottomRight: Radius.circular(70),
                  bottomLeft: Radius.circular(70))

          ),
          title: isActice ?
          SizedBox(
            height: s.height*0.06,
            child: TextFormField(
              onFieldSubmitted: (v){setState(() {
                isActice=false;
              });},
              textInputAction: TextInputAction.search,
              style: TextStyle(color: AppColors.whiteColor),
              autofocus:true,
              controller: moviesCountroller,
              onChanged: (value) {
                setState(() {});
              },
              decoration:
              InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                  hintText:
                  'Search Movie',
                  hintStyle:
                  TextStyle(
                    color: AppColors.grayColor,
                  ),
                  border:
                  OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(
                        2),
                    borderSide: BorderSide(
                        color: AppColors.purpleColor),
                  )),
            ),
          ) : Text("Upcoming Movies"),
         actions: [Padding(
           padding: const EdgeInsets.only(right: 20),
           child: IconButton(
             icon: Icon(isActice ? Icons.done : Icons.search),
             onPressed: () {
               setState(() {
                 isActice = !isActice;
               });
             },
           ),
         ),],
        ),
        body: SingleChildScrollView(
          child: Container(
            height: s.height,
            child: SafeArea(
              child: Column(
                children: [

                  FutureBuilder<UpcommingMoviesModel>(
                      future: getUpCommingMovies,
                      builder: (context, snapshot) {
                        print(snapshot.data?.results!.length.toString() ??
                            'null' + 'length');
                        if (!snapshot.hasData) {
                          return Container(
                            height: s.height,
                            child: ListView.builder(
                                itemCount: 4,
                                itemBuilder: (BuildContext context,int index){
                                  return Shimmer.fromColors(
                                    baseColor: AppColors.grayColor,
                                    highlightColor: Colors.white30,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            color: AppColors.grayColor,
                                            height: s.height*0.16,
                                            width: s.width*0.3,
                                          ),
                                          Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets
                                                    .fromLTRB(
                                                    8, 0, 5, 5),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Container(
                                                      width: s.width*0.6,
                                                      height: 8.0,
                                                      color: AppColors.whiteColor,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets
                                                    .fromLTRB(
                                                    8, 10, 5, 10),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Container(
                                                      width: s.width*0.6,
                                                      height: 8.0,
                                                      color: AppColors.whiteColor,
                                                    ),
                                                  ],
                                                ),
                                              ),

                                              Padding(
                                                padding: const EdgeInsets
                                                    .fromLTRB(
                                                    8, 20, 5, 5),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Container(
                                                      width: s.width*0.6,
                                                      height: 8.0,
                                                      color: AppColors.whiteColor,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets
                                                    .fromLTRB(
                                                    8, 10, 5, 10),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Container(
                                                      width: s.width*0.6,
                                                      height: 8.0,
                                                      color: AppColors.whiteColor,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),

                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          );
                        } else {
                          return Expanded(
                            child: ListView.builder(
                                itemCount: snapshot.data!.results!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  String movieSearchItem = snapshot.data!.results![index].originalTitle.toString();
                                  if(moviesCountroller.text.isEmpty) {
                                    return GestureDetector(
                                    onTap: () {
                                      print(snapshot
                                          .data!.results![index].originalTitle
                                          .toString());
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => MoviesDetail(
                                                    movieId: snapshot
                                                        .data!.results![index].id
                                                        .toString(),
                                                movieName: snapshot
                                                    .data!.results![index].originalTitle.toString(),
                                                  )));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ListTile(
                                        hoverColor: AppColors.grayColor,
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(color: AppColors.blackColor, width: 1),
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        leading: Container(
                                            child: Image.network(
                                                '${AppConstants.imageBase}${snapshot.data!.results![index]?.backdropPath.toString()}')
                                            //Image.network('https://api.themoviedb.org/3/movie/upcoming${snapshot.data!.results![index]?.backdropPath.toString()}'),
                                            ),
                                        title: Text(snapshot
                                            .data!.results![index].originalTitle
                                            .toString()),
                                        subtitle: Text(
                                            'release year\n${snapshot.data!.results![index].releaseDate!.year.toString()}'),
                                        isThreeLine: true,
                                      ),
                                    ),
                                  );
                                  }
                                  else if (movieSearchItem.toLowerCase().contains(
                                      moviesCountroller.text
                                          .toLowerCase()
                                          .toString())) {
                                    return GestureDetector(
                                      onTap: (){
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => MoviesDetail(
                                                  movieId: snapshot
                                                      .data!.results![index].id
                                                      .toString(),
                                                  movieName: snapshot
                                                      .data!.results![index].originalTitle.toString(),
                                                )));
                                        setState(() {
                                          isActice=false;
                                          moviesCountroller.text='';
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ListTile(
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(color: AppColors.blackColor, width: 1),
                                              borderRadius: BorderRadius.circular(5),
                                            ),
                                            title: Text(snapshot.data!.results![index].originalTitle.toString()),
                                          subtitle: Text('Release Year'),
                                          leading: Container(
                                            width: 80,
                                            height: 60,
                                            child: Image.network(
                                                '${AppConstants.imageBase}${snapshot.data!.results![index]?.backdropPath.toString()}'),
                                          )
                                        ),
                                      ),
                                    );
                                  }
                                  else{
                                    return Center();
                                  }
                                }),
                          );
                        }
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
