import 'package:complete_advanced_project/data/mapper/mapper.dart';
import 'package:complete_advanced_project/data/network/error_handler.dart';
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
      try{
        // Its safe to call the API
        final response = await _remoteDataSource.login(loginRequest);
        if(response.baseResponsesStatus == ApiInternalStatus.success) // Success
            {
          // return data(success)
          // return right
          return Right(response.toDomain());
        }else{
          // return business logic error
          // return left
          return Left(Failure(response.baseResponsesStatus ?? ApiInternalStatus.failure,
              response.message ?? ResponseMessage.defaultError));
        }
      }catch(error){
        return(Left( ErrorHandler.handle(error).failure));
      }
    }else{
      // return connection error
      return Left(DataSource.noInternetConnection.getFailure());

    }

  }

}