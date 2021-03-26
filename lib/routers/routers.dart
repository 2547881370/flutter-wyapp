import "package:flutter/material.dart";
import "./router_handler.dart";
import 'package:fluro/fluro.dart';

class Routes{
  static String root='/';
  static String detailsPage = '/detailsPage';
  static String photpGalleryPage = '/photpGalleryPage';
  static void configureRoutes(Router router){
    router.notFoundHandler= new Handler(
      handlerFunc: (BuildContext context,Map<String,List<String>> params){
        //print('如果路由匹配');
      }
    );

    router.define(detailsPage,handler:parameterHanderl);
    router.define(photpGalleryPage,handler:photpGalleryPageHanderl);
  }

}