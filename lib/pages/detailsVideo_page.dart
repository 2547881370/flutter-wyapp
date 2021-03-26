import 'dart:convert';
import 'dart:math';

import "package:flutter/material.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waye/provide/details.dart';
import 'package:waye/provide/homeTop.dart';
import 'package:waye/routers/application.dart';
import "../config//servcie_url.dart";
import "../service/service_method.dart";
import 'package:chewie/chewie.dart'; //导入视频组件
import 'package:video_player/video_player.dart'; //导入视频组件

class DetailsVideoPage extends StatefulWidget {
  @override
  _DetailsVideoPageState createState() => _DetailsVideoPageState();
}

class _DetailsVideoPageState extends State<DetailsVideoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: ScreenUtil().setWidth(750),
      child: ListView(
        children: <Widget>[
          VideoPlayerPage(),
        ],
      ),
    ));
  }
}

class VideoPlayerPage extends StatefulWidget {
  VideoPlayerPage({Key key}) : super(key: key);

  _VideoPlayerPageState createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  VideoPlayerController videoPlayerController;
  ChewieController chewieController;

  @override
  Widget build(BuildContext context) {
    _initViode(context);
    return Container(
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(750),
      child: Chewie(
          controller: chewieController,
      ),
    );
  }

  _initViode(context) {
    //配置视频地址
    // String videoUrl = Provide.value<Details>(context).videoUrl;
    String videoUrl =
        'http://video.ksyun.huluxia.net/qiniu/17286600/1582796186230/32363938303434373137363739383035363838313236363237343134352e6d7034';
    videoPlayerController = VideoPlayerController.network(videoUrl);
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      aspectRatio: 1 / 1, //宽高比
      autoPlay: true, //自动播放
      looping: true, //循环播放
    );
  }

  @override
  void dispose() {
    /**
     * 当页面销毁的时候，将视频播放器也销毁
     * 否则，当页面销毁后会继续播放视频！
     */
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }
}
