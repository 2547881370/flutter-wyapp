import "package:flutter/material.dart";
import "../config//servcie_url.dart";
import "../service/service_method.dart";
import 'dart:convert';
import 'dart:math';

//必须混入ChangeNotifier
class Details with ChangeNotifier {
  Map detailsData;
  String post_id;
  bool showDetails = false;
  Map<String, String> fromData = {
    'platform': '2',
    'gkey': '000000',
    'app_version': '4.0.0.1.2',
    'versioncode': '20141417',
    'market_id': 'floor_web',
    '_key': "",
    'device_code':
        '[w]00:81:0e:1b:c4:b0-[i]865166021747665-[s]89860037810647646094',
    'post_id': '44155130',
    'page_no': '1',
    'page_size': '20',
    'doc': '1'
  };

  setDetailsData() async {
    if(showDetails){
      return "加载成功";
    };
    var res = await request(servicePath["details"], fromData: fromData);
    if (res["post"] != null) {
      detailsData = res["post"];
    }
    final List images = detailsData["images"];
    var id = 0;
    var imagesArr = [];
    images.forEach((val) {
      id++;
      imagesArr.add({"image": val, "id":id.toString() });
    });
    detailsData["images"] = imagesArr;
    return "加载成功";
  }

  setPost_id(value){
    post_id = value.toString();
    fromData['post_id'] = post_id;
  }

  setShowDetails(value){
    showDetails = value;
  }
}
