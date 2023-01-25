import 'package:complete_advanced_project/data/mapper/mapper.dart';
import 'package:complete_advanced_project/data/network/failure.dart';
import 'package:complete_advanced_project/data/request/request.dart';
import 'package:complete_advanced_project/domain/model.dart';
import 'package:complete_advanced_project/domain/repository.dart';
import 'package:dartz/dartz.dart';
import '../data_source/remote_data_source.dart';
import '../network/network_info.dart';

class RepositoryImpl extends Repository{
  final RemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  RepositoryImpl(this._remoteDataSource,this._networkInfo);
  @override
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest) async{
    if(await _networkInfo.isConnected){
      // Its safe to call the API
      final response = await _remoteDataSource.login(loginRequest);
      if(response.baseResponsesStatus == 0) // Success
      {
        // return data(success)
        // return right
        return Right(response.toDomain());
      }else{
        // return business logic error
        // return left
        return Left(Failure(409,response.message ?? 'we have business error logic from API side'));
      }
    }else{
      // return connection error
      return Left(Failure(501,'Please check your internet connection'));

    }

  }

}