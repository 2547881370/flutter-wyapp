import "package:flutter/material.dart";
import "package:fluro/fluro.dart";
import 'package:provide/provide.dart';
import "../pages/details_page.dart";
import "../pages/PhotoGalleryPage.dart";

Handler parameterHanderl = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  /* 这个是单个路由的方法, 或者这个路由中的参数, 然后返回一个组件 ,也就相当于
       访问一个带参数的路由,会把参数获取下来,然后传入组件中,返回一个Widget
    */
  String list = params["list"].first;
  return DetailsPage();
});

Handler photpGalleryPageHanderl = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  /* 这个是单个路由的方法, 或者这个路由中的参数, 然后返回一个组件 ,也就相当于
       访问一个带参数的路由,会把参数获取下来,然后传入组件中,返回一个Widget
    */
  // int index =  int.parse(params["index"].first);
  // print("----------${index}");
  print("----------${params["photoList"]}");
  // return PhotpGalleryPage(photoList:photoList);
});


