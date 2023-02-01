import 'package:dio/dio.dart';

import '../../app/constant.dart';

const String applicationJson = 'application/json';
const String contentType = 'content-type';
const String accept = 'accept';
const String authorization = 'authorization';
const String defaultLanguage = 'language';

class DioFactory{
  Future<Dio> getDio() async{
    Dio dio = Dio();
    int timeOut = 60 * 1000; // 1 min
    Map<String,String> headers = {
      'Content-Type':applicationJson,
      'accept':applicationJson,
      'Authorization': Constant.token,
      'Default_Language':'en'
    };
    dio.options = BaseOptions(
        baseUrl: Constant.baseUrl,
        connectTimeout: timeOut,
        receiveTimeout: timeOut,
        headers: headers
    );
    return dio;
  }
}