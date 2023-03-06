import 'package:complete_advanced_project/data/network/failure.dart';
import 'package:complete_advanced_project/data/request/request.dart';
import 'package:complete_advanced_project/domain/model/model.dart';
import 'package:complete_advanced_project/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';
import 'base_useCase.dart';

class LoginUseCase implements BaseUseCase<LoginUseCaseInput,Authentication>{
  Repository _repository;
  LoginUseCase(this._repository);
  @override
  Future<Either<Failure, Authentication>> execute(LoginUseCaseInput input) async{
    await _repository.login(
        LoginRequest(
            input.email,
            input.password,
            "imei",
            "deviceType",
        ),
    );
  }

}

class LoginUseCaseInput{
  String email;
  String password;
  LoginUseCaseInput(this.email,this.password);
}