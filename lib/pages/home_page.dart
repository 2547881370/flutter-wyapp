import 'dart:convert';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import "package:flutter/material.dart";
// import 'package:get/get.dart';
import 'package:waye/provide/details.dart';
import 'package:waye/provide/homeTop.dart';
import 'package:waye/routers/application.dart';
import "../config//servcie_url.dart";
import "../service/service_method.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart'; //引入屏幕适配组件
// import "package:provide/provide.dart";
import 'package:flutter_easyrefresh/easy_refresh.dart'; //下拉上拉加载
import "./detailsVideo_page.dart";
import 'details_page.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //页面保存状态  需要混入AutomaticKeepAliveClientMixin,且需要重新发放

  var _futureBuilderFuture;
  List<Widget> listMapWidget;
  GlobalKey<RefreshIndicatorState> _footerkey =
      new GlobalKey<RefreshIndicatorState>();
  List<Widget> list;
  int age = 0;
  @override
  void initState() {
    // TODO: implement initState
    _futureBuilderFuture = _gerData();

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Future _gerData() async {
    // Provide.value<HomeTop>(context).setListMap();
    return '1';
  }

  _init(context) async {
    if (age <= 1) {
      await Provide.value<HomeTop>(context).addListMap();
      print("=_____");
    }
    age += 1;
  }

  @override
  Widget build(BuildContext context) {
    _init(context);
    print("build");
    return Scaffold(
        appBar: PreferredSize(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                  gradient:
                      LinearGradient(colors: [Colors.green, Colors.green])),
              child: SafeArea(
                  child: Column(
                children: <Widget>[
                  Container(
                    width: ScreenUtil().setWidth(750),
                    height: ScreenUtil().setHeight(100),
                    padding: EdgeInsets.only(left: 20, right: 14),
                    // decoration: BoxDecoration(color: Colors.white),
                    child: Row(
                      children: <Widget>[TopComponent()],
                    ),
                  ),
                  Container(
                    child: CustomTabBar(),
                    decoration: BoxDecoration(color: Colors.white),
                  )
                ],
              )),
            ),
            preferredSize: Size(double.infinity, 105.5)),
        body: FutureBuilder(
            future: _futureBuilderFuture,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Provide<HomeTop>(builder: (context, child, data) {
                  var listMapArr =
                      Provide.value<HomeTop>(context).listMap.map((val) {
                    if (val["images"].length > 2) {
                      return ListPage(products: val);
                    } else if (val["images"].length == 2) {
                      return ListPageMini(products: val);
                    } else {
                      return Container(
                        child: Text(''),
                      );
                      // return listPageVideo(context, val);
                    }
                  }).toList();
                  return EasyRefresh(
                      key: _footerkey,
                      header: ClassicalHeader(
                        enableInfiniteRefresh: false,
                        infoColor: true ? Colors.black87 : Colors.black87,
                        float: false,
                        enableHapticFeedback: true,
                        refreshText: "下拉刷新",
                        refreshingText: "重新加载中....",
                        refreshedText: "加载完成",
                        refreshFailedText: "加载失败,请重新下拉刷新",
                      ),
                      footer: ClassicalFooter(
                        enableInfiniteLoad: true,
                        enableHapticFeedback: true,
                        loadText: "下拉刷新",
                        loadingText: "重新加载中....",
                        loadedText: "加载完成",
                        loadFailedText: "加载失败,请重新下拉刷新",
                      ),
                      //上拉下拉刷新组件
                      child: ListView(
                        children: listMapArr,
                        shrinkWrap: true,
                      ),
                      onLoad: () async {
                        // _getHotGoods();
                        //上拉加载更多
                        await Provide.value<HomeTop>(context).addListMap();
                        await Provide.value<HomeTop>(context).setShow(false);
                      },
                      onRefresh: () async {
                        //下拉刷新
                        await Provide.value<HomeTop>(context).initListMap();
                        await Provide.value<HomeTop>(context).setShow(false);
                        print("刷新");
                      });
                });
              }
            }));
  }
}

class TopComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Container(
              width: ScreenUtil().setWidth(200),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  InkWell(
                    child: Icon(
                      Icons.chevron_left,
                      color: Colors.white,
                      size: ScreenUtil().setSp(30),
                    ),
                  ),
                  InkWell(
                    child: Row(
                      children: <Widget>[
                        CustomPoupMenuButton(),
                      ],
                    ),
                  )
                ],
              )),
          Container(),
        ],
      ),
    );
  }
}

//下拉菜单组件
class CustomPoupMenuButton extends StatefulWidget {
  @override
  _CustomPoupMenuButtonState createState() => _CustomPoupMenuButtonState();
}

class _CustomPoupMenuButtonState extends State<CustomPoupMenuButton>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;
  double angle = 0;
  bool tagsMenuOpen = false;

  String name = '按时间回复';

  @override
  void initState() {
    _controller = AnimationController(
        duration: const Duration(milliseconds: 400), vsync: this);
    _animation = Tween(begin: 0.0, end: pi).animate(_controller)
      ..addListener(() {
        setState(() {
          angle = _animation.value;
        });
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final map = {
    "按时间回复": Icons.info_outline,
    "按发布时间": Icons.help_outline,
    "按版本精华": Icons.add_comment,
  };

  void init(context, value) {
    Provide.value<HomeTop>(context).setTagsMenuOpen(value);
    final bool tagsMenuOpen = Provide.value<HomeTop>(context).tagsMenuOpen;
    if (!tagsMenuOpen) {
      print("刷新");
      _controller.reverse();
    } else {
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Provide<HomeTop>(builder: (context, child, data) {
      return InkWell(
          child: PopupMenuButton<String>(
        color: Color.fromRGBO(1, 1, 1, 0.8),
        itemBuilder: (context) => buildItems(),
        offset: Offset(0, 50),
        elevation: 1,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
          topRight: Radius.circular(5),
          bottomLeft: Radius.circular(5),
        )),
        onSelected: (e) {
          print(e);
          init(context, true);
          setState(() {
            name = e.toString();
          });
          if (e == '按时间回复') {
            Provide.value<HomeTop>(context).setSort_by('0');
          } else if (e == "按发布时间") {
            Provide.value<HomeTop>(context).setSort_by('1');
          } else if (e == "按版本精华") {
            Provide.value<HomeTop>(context).setSort_by('2');
          }
        },
        onCanceled: () {
          init(context, true);
        },
        child: Container(
          width: ScreenUtil().setWidth(170),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(name.toString(),
                  style: TextStyle(
                      color: Colors.white, fontSize: ScreenUtil().setSp(28))),
              Transform.rotate(
                  angle: angle,
                  child: CustomPaint(
                    //自己画个三角形，当然也可以使用Icon
                    painter: TrianglePainter(Colors.white),
                    child: SizedBox(
                      width: 12,
                      height: 12,
                    ),
                  ))
            ],
          ),
        ),
      ));
    });
  }

  List<PopupMenuItem<String>> buildItems() {
    return map.keys
        .toList()
        .map((e) => PopupMenuItem<String>(
            value: e,
            child: Wrap(
              spacing: 10,
              children: <Widget>[
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Icon(map[e],
                          color: e.toString() == name
                              ? Colors.green
                              : Colors.white),
                      Text(
                        e,
                        style: TextStyle(
                            color: e.toString() == name
                                ? Colors.green
                                : Colors.white),
                      ),
                    ],
                  ),
                )
              ],
            )))
        .toList();
  }
}

/*
* 画个三角形
* */
class TrianglePainter extends CustomPainter {
  Color color;
  Paint _paint;
  Path _path;
  double angle;

  TrianglePainter(this.color) {
    _paint = Paint()
      ..strokeWidth = 1.0
      ..color = color
      ..isAntiAlias = true;

    _path = Path();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

  @override
  void paint(Canvas canvas, Size size) {
    final baseX = size.width * 0.5;
    final baseY = size.height * 0.5;
    //三角形
    _path.moveTo(baseX - 0.86 * baseX, 0.5 * baseY);
    _path.lineTo(baseX, 1.5 * baseY);
    _path.lineTo(baseX + 0.86 * baseX, 0.5 * baseY);
    canvas.drawPath(_path, _paint);
  }
}

//顶部菜单
class CustomTabBar extends StatefulWidget {
  @override
  _CustomTabBarState createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  final tabs = ['全部', '原创美腿', '网图美腿'];
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: tabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(750),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 1, color: Color(0xffe5e5e5))),
      ),
      child: TabBar(
        onTap: (tab) {
          if (tab.toString() == '0') {
            Provide.value<HomeTop>(context).setTag_id('0');
          } else if (tab.toString() == '1') {
            // Get.to(DetailsPage());
            Provide.value<HomeTop>(context).setTag_id('5601');
          } else if (tab.toString() == '2') {
            Provide.value<HomeTop>(context).setTag_id('5602');
          }
        },
        labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        unselectedLabelStyle: TextStyle(fontSize: 16),
        isScrollable: true,
        controller: _tabController,
        labelColor: Colors.green,
        indicatorWeight: 3,
        indicatorPadding: EdgeInsets.symmetric(horizontal: 10),
        unselectedLabelColor: Colors.grey,
        indicatorColor: Colors.green,
        tabs: tabs.map((e) => Tab(text: e)).toList(),
      ),
    );
  }
}

//大于三张图片
class ListPage extends StatefulWidget {
  Map products;
  ListPage({this.products});
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  void initState() {
    // TODO: implement initState
    // print(".........重新");
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    print("销毁");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: ScreenUtil().setWidth(750),
        padding: EdgeInsets.only(left: 10, right: 10),
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          border:
              Border(bottom: BorderSide(width: 1, color: Color(0xffe5e5e5))),
        ),
        child: Column(
          children: <Widget>[
            _title(),
            _titleBottom(),
            _centerImgList(),
            _bottom()
          ],
        ),
      ),
      onTap: () async {
        await Provide.value<HomeTop>(context).setShowDetails(true);
        await Provide.value<HomeTop>(context).setShow(true);
        await Provide.value<Details>(context).setShowDetails(false);
        await Provide.value<Details>(context)
            .setPost_id(widget.products['postID'].toString());
        // Application.router.navigateTo(context, "/detailsPage?list=65623123");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailsPage()),
        );
        // Get.to(DetailsPage());
      },
    );
  }

  Widget _title() {
    return Container(
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(50),
      decoration: BoxDecoration(color: Colors.white),
      child: Row(
        children: <Widget>[
          Container(
            width: ScreenUtil().setWidth(30),
            height: ScreenUtil().setHeight(30),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                color: Colors.green),
            child: Text("新", style: TextStyle(color: Colors.white)),
          ),
          Expanded(
            child: Container(
              child: Text(
                '${widget.products['title']}',
                style: TextStyle(
                    color: Colors.black, fontSize: ScreenUtil().setSp(20)),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _titleBottom() {
    return Container(
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(30),
      decoration: BoxDecoration(color: Colors.white),
      child: Text("${widget.products['detail']}",
          style: TextStyle(
              color: Colors.black54, fontSize: ScreenUtil().setSp(20))),
    );
  }

  Widget _centerImgList() {
    return Stack(
      children: <Widget>[
        Container(
          width: ScreenUtil().setWidth(750),
          height: ScreenUtil().setHeight(230),
          decoration: BoxDecoration(color: Colors.white),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Container(
                  height: ScreenUtil().setHeight(230),
                  decoration: BoxDecoration(color: Colors.black),
                  child: CachedNetworkImageConponent(
                    imageUrl:
                        "${widget.products['images'].length >= 1 ? widget.products['images'][0] : ''}",
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 10),
                  height: ScreenUtil().setHeight(230),
                  decoration: BoxDecoration(color: Colors.black),
                  child: CachedNetworkImageConponent(
                    imageUrl:
                        "${widget.products['images'].length > 1 ? widget.products['images'][1] : ''}",
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 10),
                  height: ScreenUtil().setHeight(230),
                  decoration: BoxDecoration(color: Colors.black),
                  child: CachedNetworkImageConponent(
                    imageUrl:
                        "${widget.products['images'].length > 2 ? widget.products['images'][2] : ''}",
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 5,
          right: 5,
          child: Container(
            decoration: BoxDecoration(color: Color.fromRGBO(1, 1, 1, 0.5)),
            padding: EdgeInsets.only(left: 10, right: 10, top: 3, bottom: 3),
            alignment: Alignment.center,
            child: Text("6图", style: TextStyle(color: Colors.white)),
          ),
        )
      ],
    );
  }

  Widget _bottom() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 10, bottom: 10),
      width: ScreenUtil().setWidth(750),
      decoration: BoxDecoration(color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Text(
                      "${widget.products['user']['nick']}",
                      style: TextStyle(color: Colors.black26),
                    )),
                Text("30分钟前", style: TextStyle(color: Colors.black26)),
              ],
            ),
          ),
          Container(
            child: Row(
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
                        "${widget.products['hit']}",
                        style: TextStyle(
                            color: Colors.black26,
                            fontSize: ScreenUtil().setSp(18)),
                      )
                    ],
                  ),
                ),
                Container(
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
                        "${widget.products['commentCount']}",
                        style: TextStyle(
                            color: Colors.black26,
                            fontSize: ScreenUtil().setSp(18)),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//小于三张图片
class ListPageMini extends StatefulWidget {
  Map products;
  ListPageMini({this.products});
  @override
  _ListPageMiniState createState() => _ListPageMiniState();
}

class _ListPageMiniState extends State<ListPageMini> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: ScreenUtil().setWidth(750),
        padding: EdgeInsets.only(left: 10, right: 10),
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          border:
              Border(bottom: BorderSide(width: 1, color: Color(0xffe5e5e5))),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _leftImg(),
            Expanded(
              child: _rightTitle(),
            )
          ],
        ),
      ),
      onTap: () async {
        await Provide.value<HomeTop>(context).setShowDetails(true);
        await Provide.value<HomeTop>(context).setShow(true);
        await Provide.value<Details>(context).setShowDetails(false);
        await Provide.value<Details>(context)
            .setPost_id(widget.products['postID'].toString());
        // Application.router.navigateTo(context, "/detailsPage?list=65623123");
        // Get.to(DetailsPage());
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailsPage()),
        );
      },
    );
  }

  Widget _leftImg() {
    return Stack(
      children: <Widget>[
        Container(
            width: ScreenUtil().setWidth(200),
            height: ScreenUtil().setHeight(200),
            decoration: BoxDecoration(color: Colors.black),
            child: CachedNetworkImageConponent(
              imageUrl:
                  "${widget.products['images'].length >= 1 ? widget.products['images'][0] : ''}",
            )),
        Positioned(
          bottom: 5,
          right: 5,
          child: Container(
            decoration: BoxDecoration(color: Color.fromRGBO(1, 1, 1, 0.5)),
            padding: EdgeInsets.only(left: 10, right: 10, top: 3, bottom: 3),
            alignment: Alignment.center,
            child: Text("2图", style: TextStyle(color: Colors.white)),
          ),
        )
      ],
    );
  }

  Widget _title() {
    return Container(
      height: ScreenUtil().setHeight(50),
      alignment: Alignment.topLeft,
      child: Row(
        children: <Widget>[
          Container(
            width: ScreenUtil().setWidth(30),
            height: ScreenUtil().setHeight(30),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                color: Colors.green),
            child: Text("新", style: TextStyle(color: Colors.white)),
          ),
          Container(
            child: Text(
              '${widget.products['title']}',
              style: TextStyle(
                  color: Colors.black, fontSize: ScreenUtil().setSp(20)),
            ),
          )
        ],
      ),
    );
  }

  Widget _titleBottom() {
    return Container(
      height: ScreenUtil().setHeight(75),
      decoration: BoxDecoration(color: Colors.white),
      alignment: Alignment.topLeft,
      child: Text("${widget.products['detail']}",
          style: TextStyle(
              color: Colors.black54, fontSize: ScreenUtil().setSp(20))),
    );
  }

  Widget _bottom() {
    return Container(
      alignment: Alignment.bottomLeft,
      padding: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Text(
                      "${widget.products['user']['nick']}",
                      style: TextStyle(color: Colors.black26),
                    )),
                Text("10分钟前", style: TextStyle(color: Colors.black26)),
              ],
            ),
          ),
          Container(
            child: Row(
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
                        "${widget.products['hit']}",
                        style: TextStyle(
                            color: Colors.black26,
                            fontSize: ScreenUtil().setSp(18)),
                      )
                    ],
                  ),
                ),
                Container(
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
                        "${widget.products['commentCount']}",
                        style: TextStyle(
                            color: Colors.black26,
                            fontSize: ScreenUtil().setSp(18)),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _rightTitle() {
    return Container(
      padding: EdgeInsets.all(10),
      height: ScreenUtil().setHeight(200),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[_title(), _bottom()],
      ),
    );
  }
}

//视频
Widget listPageVideo(context, products) {
  Widget _leftImg() {
    return Stack(
      children: <Widget>[
        Container(
          width: ScreenUtil().setWidth(200),
          height: ScreenUtil().setHeight(200),
          decoration: BoxDecoration(color: Colors.black),
          child: Image.network(
            "${products['images'].length > 0 ? products['images'][0] : ''}",
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          left: 0,
          top: 0,
          width: 160,
          height: 180,
          child: Center(
            child: Container(
              width: ScreenUtil().setWidth(50),
              child: Image.network(
                  "https://www.easyicon.net/api/resizeApi.php?id=562159&size=48"),
            ),
          ),
        )
      ],
    );
  }

  Widget _title() {
    return Container(
      height: ScreenUtil().setHeight(50),
      alignment: Alignment.topLeft,
      child: Row(
        children: <Widget>[
          Container(
            width: ScreenUtil().setWidth(30),
            height: ScreenUtil().setHeight(30),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                color: Colors.green),
            child: Text("新", style: TextStyle(color: Colors.white)),
          ),
          Expanded(
            child: Container(
              child: Text(
                '${products['title']}',
                style: TextStyle(
                    color: Colors.black, fontSize: ScreenUtil().setSp(20)),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _titleBottom() {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      alignment: Alignment.topLeft,
      child: Text("", //"${products['detail']}"
          style: TextStyle(
              color: Colors.black54, fontSize: ScreenUtil().setSp(20))),
    );
  }

  Widget _bottom() {
    return Container(
      alignment: Alignment.bottomLeft,
      padding: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Text(
                      "${products['user']['nick']}",
                      style: TextStyle(color: Colors.black26),
                    )),
                Text("10分钟前", style: TextStyle(color: Colors.black26)),
              ],
            ),
          ),
          Container(
            child: Row(
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
                        "${products['hit']}",
                        style: TextStyle(
                            color: Colors.black26,
                            fontSize: ScreenUtil().setSp(18)),
                      )
                    ],
                  ),
                ),
                Container(
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
                        "${products['commentCount']}",
                        style: TextStyle(
                            color: Colors.black26,
                            fontSize: ScreenUtil().setSp(18)),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _rightTitle() {
    return Container(
      padding: EdgeInsets.all(10),
      height: ScreenUtil().setHeight(200),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: _title(),
          ),
          _titleBottom(),
          _bottom()
        ],
      ),
    );
  }

  return InkWell(
    child: Container(
      width: ScreenUtil().setWidth(750),
      padding: EdgeInsets.only(left: 10, right: 10),
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(width: 1, color: Color(0xffe5e5e5))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _leftImg(),
          Expanded(
            child: _rightTitle(),
          )
        ],
      ),
    ),
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DetailsVideoPage()),
      );
    },
  );
}

class ListCompoent extends StatefulWidget {
  List listMap;
  ListCompoent({this.listMap});
  @override
  _ListCompoentState createState() => _ListCompoentState();
}

class _ListCompoentState extends State<ListCompoent> {
  //页面保存状态  需要混入AutomaticKeepAliveClientMixin,且需要重新发放

  List<Widget> listMapWidget;
  @override
  void initState() {
    // TODO: implement initState
    _init();
    super.initState();
  }

  _init() {
    listMapWidget = widget.listMap.map((val) {
      if (val["images"].length > 2) {
        return ListPage(products: val);
      } else if (val["images"].length == 2) {
        return ListPageMini(products: val);
      } else {
        return Container(
          child: Text(''),
        );
        // return listPageVideo(context, val);
      }
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Provide<HomeTop>(builder: (context, child, data) {
      print("重绘");

      if (data.show) {
        listMapWidget = data.listMapWidget;
      } else {
        if (data.showListMapArr) {
          var list = data.listMapArr?.map((val) {
            if (val["images"].length > 2) {
              return ListPage(products: val);
            } else if (val["images"].length == 2) {
              return ListPageMini(products: val);
            } else {
              return Container(
                child: Text(''),
              );
              // return listPageVideo(context, val);
            }
          })?.toList();
          if (list != null) {
            listMapWidget.addAll(list);
          }
          Provide.value<HomeTop>(context).setListMapWidget(listMapWidget);
        } else {
          listMapWidget = widget.listMap.map((val) {
            if (val["images"].length > 2) {
              return ListPage(products: val);
            } else if (val["images"].length == 2) {
              return ListPageMini(products: val);
            } else {
              return Container(
                child: Text(''),
              );
              // return listPageVideo(context, val);
            }
          }).toList();
          Provide.value<HomeTop>(context).setListMapWidget(listMapWidget);
        }
      }
      print("使用保存的Widget");

      return Column(children: listMapWidget);
    });
  }
}

/*  */
class CachedNetworkImageConponent extends StatefulWidget {
  String imageUrl;
  CachedNetworkImageConponent({this.imageUrl});
  @override
  _CachedNetworkImageConponentState createState() =>
      _CachedNetworkImageConponentState();
}

class _CachedNetworkImageConponentState
    extends State<CachedNetworkImageConponent> {
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: BoxFit.cover,
      imageUrl: widget.imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.white, BlendMode.colorBurn)),
        ),
      ),
      placeholder: (context, url) => CircularProgressIndicator(),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}
