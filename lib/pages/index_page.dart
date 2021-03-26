import "package:flutter/material.dart";
import "package:flutter/cupertino.dart"; //ios的风格组件

import 'package:flutter_screenutil/flutter_screenutil.dart'; //引入屏幕适配组件

import "home_page.dart";
import "member_page.dart";

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final List<BottomNavigationBarItem> bottoTabs = [
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.home), //使用ios风格的组件
        title: Text("首页")),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.profile_circled), //使用ios风格的组件
        title: Text("会员中心")),
  ];
  PageController _pageController;

  //这里存4个页面, 用于body切换组件
  final List<Widget> tabBodies = [HomePage(), MemberPage()];

  //存两个变量 下标和当前组件,利用底部导航栏的点击事件,来动态切换组件currentPage,
  int currentIndex = 0; //tab初始化坐标
  var currentPage; //存储当前是在那个页面类中

  @override
  void initState() {
    currentPage = tabBodies[0];
    this._pageController = PageController(initialPage: this.currentIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        width: 750, height: 1334); //如果给的设计图是750 1334,那么就按照这种设置,必须在build里面配置
    return Container(
      child: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed, //使用这个类型,很适合中国人
            currentIndex: currentIndex,
            items: bottoTabs,
            onTap: (index) {
              setState(() {
                currentIndex = index;
                currentPage = tabBodies[index];
              });
            },
          ),
          body: IndexedStack(
            index: currentIndex,
            children: tabBodies,
          )
          
          
          // PageView(
          //     controller: this._pageController,
          //     children: this.tabBodies,
          //     onPageChanged: (index) {
          //       setState(() {
          //         this.currentIndex = index;
          //       });
          //     })

          /* IndexedStack(
            index: currentIndex,
            children: tabBodies,
          ) */
          ),
    );
  }
}
