import 'dart:convert';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import "package:flutter/material.dart";
import 'package:waye/provide/details.dart';
import 'package:waye/provide/homeTop.dart';
import 'package:waye/routers/application.dart';
import "../config//servcie_url.dart";
import "../service/service_method.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart'; //引入屏幕适配组件
import "package:provide/provide.dart";
import 'package:flutter_easyrefresh/easy_refresh.dart'; //下拉上拉加载
import 'package:photo_view/photo_view.dart'; //图片放大预览
import "./PhotoGalleryPage.dart";

class DetailsPage extends StatefulWidget {
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage>
   {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("美腿"),
          elevation: 0.5,
          brightness: Brightness.light,
          backgroundColor: Colors.green,
        ),
        body: FutureBuilder(
            future: Provide.value<Details>(context).setDetailsData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final Map detailsData =
                    Provide.value<Details>(context).detailsData;
                return ListView(
                  children: <Widget>[
                    Container(
                      child: DetailsTitle(detailsData: detailsData),
                    ),
                    DetailsContent(detailsData: detailsData)
                  ],
                );
              } else {
                return Center(
                  child: Text("加载中....."),
                );
              }
            }));
  }
}

class DetailsTitle extends StatefulWidget {
  final Map detailsData;
  DetailsTitle({this.detailsData});
  @override
  _DetailsTitleState createState() => _DetailsTitleState();
}

class _DetailsTitleState extends State<DetailsTitle>
    {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(80),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(color: Colors.black12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Text(
                "${widget.detailsData['scorelist'] != null ? widget.detailsData['title'] : ''}",
                style: TextStyle(
                    color: Colors.black, fontSize: ScreenUtil().setSp(30))),
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 5),
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: 5),
                      child: Icon(
                        Icons.remove_red_eye,
                        color: Colors.black26,
                        size: ScreenUtil().setSp(20),
                      ),
                    ),
                    Text(
                      "${widget.detailsData['category'] != null ? widget.detailsData['hit'].toString() : ''}",
                      style: TextStyle(
                          color: Colors.black26,
                          fontSize: ScreenUtil().setSp(18)),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 5),
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: 5),
                      child: Icon(
                        Icons.comment,
                        color: Colors.black26,
                        size: ScreenUtil().setSp(20),
                      ),
                    ),
                    Text(
                      "${widget.detailsData['category'] != null ? widget.detailsData['commentCount'].toString() : ''}",
                      style: TextStyle(
                          color: Colors.black26,
                          fontSize: ScreenUtil().setSp(18)),
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class DetailsContent extends StatefulWidget {
  final Map detailsData;
  DetailsContent({this.detailsData});
  @override
  _DetailsContentState createState() => _DetailsContentState();
}

class _DetailsContentState extends State<DetailsContent>
     {
  

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(750),
      padding: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(width: 1, color: Color(0xffe5e5e5)))),
      child: Column(
        children: <Widget>[_detailsContent(), _meetingPhotos(context)],
      ),
    );
  }

  Widget _detailsContent() {
    return Container(
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(100),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                Container(
                  width: ScreenUtil().setWidth(60),
                  height: ScreenUtil().setHeight(60),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  child: ClipOval(
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl:
                          "${widget.detailsData["user"]["avatar"].toString()}",
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  height: ScreenUtil().setHeight(100),
                  decoration: BoxDecoration(),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          width: ScreenUtil().setWidth(200),
                          alignment: Alignment.centerLeft,
                          child: Text(
                              "${widget.detailsData["user"]["nick"].toString()}",
                              style: TextStyle(color: Colors.black54)),
                          decoration: BoxDecoration(),
                        ),
                      ),
                      Expanded(
                        child: Container(
                            decoration: BoxDecoration(),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.center,
                                  height: ScreenUtil().setHeight(30),
                                  decoration: BoxDecoration(
                                      color: Colors.cyan[300],
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  width: ScreenUtil().setWidth(60),
                                  child: Text(
                                    '${widget.detailsData["user"]["level"].toString()}级',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: ScreenUtil().setSp(18)),
                                  ), //integral
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  height: ScreenUtil().setHeight(30),
                                  margin: EdgeInsets.only(left: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  width: ScreenUtil().setWidth(120),
                                  child: Text(
                                    '秋名山车神',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: ScreenUtil().setSp(18)),
                                  ), //identityTitle
                                )
                              ],
                            )),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Text(
              "楼主",
              style: TextStyle(
                  color: Colors.green, fontSize: ScreenUtil().setSp(25)),
            ),
          )
        ],
      ),
    );
  }

  //图片预览器
  Widget _meetingPhotos(BuildContext context) {
    return widget.detailsData["images"] != null ? Container(
      padding: EdgeInsets.fromLTRB(32, 16, 32, 8),
      child: GridView.builder(
        shrinkWrap: true, //解决 listview 嵌套报错
        physics: NeverScrollableScrollPhysics(), //禁用滑动事件
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //横轴元素个数
            crossAxisCount: 2,
            //纵轴间距
            mainAxisSpacing: 10.0,
            //横轴间距
            crossAxisSpacing: 10.0,
            //子组件宽高长度比例
            childAspectRatio: 1.0),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () async {
              await Provide.value<Details>(context).setShowDetails(true);
              _jumpToGallery(index, widget.detailsData["images"], context);
            },
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: widget.detailsData["images"][index]['image'],
            ),
          );
        },
        itemCount: widget.detailsData["images"].length,
      ),
    ) : Text('');
  }

  void _jumpToGallery(index, list, context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              PhotpGalleryPage(photoList: list, index: index)),
    );
  }
}
