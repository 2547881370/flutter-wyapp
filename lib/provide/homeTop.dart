import "package:flutter/material.dart";
import "../config//servcie_url.dart";
import "../service/service_method.dart";
import 'dart:convert';
import 'dart:math';

//必须混入ChangeNotifier
class HomeTop with ChangeNotifier {
  bool tagsMenuOpen = false;

  List listMap = [];
  String start = '0';
  String sort_by = "0";
  String tag_id = "0";

  bool showDetails = false;

  final tabs = ['全部', '原创美腿', '网图美腿'];
  TabController _tabController;
  List listMapArr;
  bool showListMapArr = false;

  List<Widget> listMapWidget;
  bool show = false;

  Map<String, String> fromData = {
    "platform": '1',
    "gkey": '000000',
    "app_version": "4.0.0.1.2",
    "versioncode": "20141417",
    "market_id": "floor_web",
    "_key": "",
    "device_code":
        "[w]00:81:0e:1b:c4:b0-[i]865166021747665-[s]89860037810647646094",
    "start": '0',
    "count": "20",
    "cat_id": "56",
    "tag_id": "0",
    "sort_by": "0",
  };

  setListMap() async {
    print("重新刷新");

    if (showDetails) {
      return "加载成功";
    }
    var res = await request(servicePath["getswList"], fromData: fromData);
    if (res["posts"].length > 0) {
      listMap = res["posts"];
      start = res["start"];
      fromData["start"] = start;
    }
    return "加载成功";
  }

  addListMap() async {
    var res = await request(servicePath["getswList"], fromData: fromData);
    if (res["posts"].length > 0) {
      var tempList = (res["posts"] as List).cast();
      var listMaps = listMap;
      listMapArr = tempList;
      showListMapArr = true;
      listMaps.addAll(tempList);
      listMap = listMaps;
      start = res["start"];
      fromData["start"] = start;
    }
    notifyListeners();
    return "加载成功";
  }

  initListMap() async {
    var res = await request(servicePath["getswList"], fromData: fromData);
    if (res["posts"].length > 0) {
      listMap = res["posts"];
      start = res["start"];
      fromData["start"] = start;
    }
    listMapArr = [];
    showListMapArr = false;
    notifyListeners();
    return "加载成功";
  }

  setSort_by(value) async {
    sort_by = value.toString();
    fromData["sort_by"] = sort_by;
    await initListMap();
  }

  setTag_id(value) async {
    tag_id = value.toString();
    fromData["tag_id"] = tag_id;
    var res = await request(servicePath["getswList"], fromData: fromData);
    if (res["posts"].length > 0) {
      listMap = res["posts"];
    }
    showListMapArr = false;
    notifyListeners();
    return "加载成功";
  }

  setShowDetails(value) {
    showDetails = value;
    showListMapArr = false;
  }

  setTagsMenuOpen(bool value) {
    print("刷新");
    tagsMenuOpen = value;
    notifyListeners();
    //notifyListeners的作用是通知我更新快,局部刷新状态,组件会更新
  }

  setListMapWidget(list){
    listMapWidget = list;
    notifyListeners();
  }

  setShow(value){
    show = value;
  }
}
