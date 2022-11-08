import '../data/network/failure.dart';
import '../data/request/request.dart';
import 'model.dart';
import 'package:dartz/dartz.dart';


abstract class Repository{
  Future<Either<Failure,Authentication>> login(LoginRequest loginRequest);
}