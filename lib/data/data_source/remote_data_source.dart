import 'package:complete_advanced_project/data/request/request.dart';
import 'package:complete_advanced_project/data/responses/responses.dart';
import 'package:retrofit/http.dart';
import '../network/app_api.dart';

abstract class RemoteDataSource{
  Future<AuthenticationResponse> login(LoginRequest loginRequest);
}

class RemoteDataSourceImplementer implements RemoteDataSource{
  AppServiceClient _appServiceClient;

  RemoteDataSourceImplementer(this._appServiceClient);
  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) async{
    return await _appServiceClient.login(
        loginRequest.email,
        loginRequest.password,
        loginRequest.imei,
        loginRequest.deviceType
    );
  }
}