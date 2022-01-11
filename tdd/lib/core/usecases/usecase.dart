import 'package:dartz/dartz.dart';
import 'package:tdd/core/error/failure.dart';


//
// the child classes for the Usecase has to use the call() method to make the code more clearner.
abstract class Usecase<Type, Params> {
  Future<Either<Failure,Type>?> call(Params param);
}
