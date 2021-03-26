import 'package:flutter/material.dart';

import "./pages/index_page.dart";
import "package:provide/provide.dart";
import "./provide/homeTop.dart";
import "./provide/details.dart";
/**
 * 路由
 */
//路由引入这三个个文件
import "./routers/routers.dart"; //路由配置的总文件
import "./routers/application.dart"; //Router静态化,方便直接对象的方式访问,不需要new
import 'package:fluro/fluro.dart';

void main() {
  var counter = HomeTop(); //获取Counter类
  var details = Details(); //获取Counter类
  var providers = Providers(); //拿到Providers管理对象
  providers
    ..provide(Provider<HomeTop>.value(
        counter)) //给Providers对象的provide方法,导入Counter类,如果有其他的状态管理,继续使用..
    ..provide(Provider<Details>.value(
        details)); 

  runApp(ProviderNode(
    child: MyApp(),
    providers: providers,
  )); //这里是固定写法
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final router = Router();
    Routes.configureRoutes(router);
    Application.router = router;

    return MaterialApp(
      /**
         * 路由
         */
      onGenerateRoute: Application.router.generator, //注入全局路由
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false, //去掉右上标签
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: IndexPage(),
    );
  }
}
