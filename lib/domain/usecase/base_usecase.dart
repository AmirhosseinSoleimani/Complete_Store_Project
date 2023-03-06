import 'package:complete_advanced_project/data/network/failure.dart';
import 'package:dartz/dartz.dart';

abstract class BaseUseCase<In,Out>{
  Future<Either<Failure,Out>> execute(In input);
}