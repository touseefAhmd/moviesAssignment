import 'package:assignment_123/res/colors.dart';
import 'package:assignment_123/res/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../res/components/round_button.dart';

class VideoView extends StatefulWidget {
  String urlKey;
  String movieName;
  VideoView({Key? key, required this.urlKey, required this.movieName})
      : super(key: key);
  @override
  State<VideoView> createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  late YoutubePlayerController _watchTrailerController;
  //bool _isPlaying = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _watchTrailerController = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(
          '${AppConstants.videoBase}${widget.urlKey}')!,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    )..addListener(() {
        setState(() {
          if (_watchTrailerController.metadata.duration.inSeconds > 0) {
            if (_watchTrailerController.value.position.inSeconds ==
                _watchTrailerController.metadata.duration.inSeconds-1) {
              Future.delayed(Duration.zero, () {
                Get.back();
              });
            }
          }
        });
      });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _watchTrailerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        height: s.height,
        child: YoutubePlayerBuilder(
            player: YoutubePlayer(controller: _watchTrailerController),
            builder: (context, player) => Scaffold(
                  appBar: AppBar(
                    leading: RoundButton(callBack: (){Get.back();},title: 'Done',color: AppColors.whiteColor),
                    leadingWidth: 100,
                    automaticallyImplyLeading: false,
                    backgroundColor: AppColors.purpleColor,
                    centerTitle: true,
                    toolbarHeight: 75,
                    title: Text(widget.movieName),
                    // shape: RoundedRectangleBorder(
                    //     borderRadius:  BorderRadius.only(
                    //         bottomRight: Radius.circular(70),
                    //         bottomLeft: Radius.circular(70))
                    //
                    // ),
                  ),
                  body: Container(
                    height: s.height,
                    color: AppColors.blackColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        player,
                      ],
                    ),

                  ),
                )),
      ),
    );
  }
}
