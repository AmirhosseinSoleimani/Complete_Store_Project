import 'package:complete_advanced_project/app/app_prefs.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../../app/constant.dart';

const String applicationJson = 'application/json';
const String contentType = 'content-type';
const String accept = 'accept';
const String authorization = 'authorization';
const String defaultLanguage = 'language';

class DioFactory{
  AppPreferences appPreferences;
  DioFactory(this.appPreferences);

  Future<Dio> getDio() async{
    Dio dio = Dio();
    int timeOut = 60 * 1000; // 1 min
    String language = await appPreferences.getAppLanguage();
    Map<String,String> headers = {
      'Content-Type':applicationJson,
      'accept':applicationJson,
      'Authorization': Constant.token,
      'Default_Language':language // get lang from aoo prefs
    };

    dio.options = BaseOptions(
        baseUrl: Constant.baseUrl,
        connectTimeout: timeOut,
        receiveTimeout: timeOut,
        headers: headers
    );
    if(kReleaseMode){
      debugPrint('release mode no logs');
    }else{
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
      ));
    }
    return dio;
  }
}