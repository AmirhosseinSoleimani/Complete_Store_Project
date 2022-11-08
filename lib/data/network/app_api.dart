import 'package:complete_advanced_project/app/constant.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';

import '../responses/responses.dart';
part 'app_api.g.dart';

@RestApi(baseUrl: Constant.baseUrl)
abstract class AppServiceClient{
  factory AppServiceClient(
      Dio dio,{String baseUrl}) = _AppServiceClient;

  @POST("/customers/login")
  Future<AuthenticationResponse>login();

}