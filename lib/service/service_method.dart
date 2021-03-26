import "package:dio/dio.dart";
import "dart:async";
import "dart:io";
import "../config//servcie_url.dart";
import "../config/headers.dart";

Future request(url, {fromData}) async {
  try {
    Response response;
    Dio dio = new Dio();
    dio.options.headers = headers;
    //使用表单的形势提交,这里使用到了上面的io库
    // var fromData = fromData;
    //http://search.m.dangdang.com/ddcategory.php?action=get_content&title=%E5%9B%BE%E4%B9%A6&pageid=712231
    if (fromData != null) {
      response = await dio.get(url, queryParameters: fromData);
    } else {
      response = await dio.get(url);
    }
    //print(response);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception("后端接口出现异常");
    }
  } catch (e) {
    return print("异常============>${e}");
  }
}