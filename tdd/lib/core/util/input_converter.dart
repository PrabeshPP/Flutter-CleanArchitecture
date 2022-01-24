import 'package:dartz/dartz.dart';
import 'package:tdd/core/error/failure.dart';

class InputConverter {
  Either<Failure, int>? stringToInt(String number1) {
    try {
      int number = int.parse(number1);
      return Right(number);
    } on Exception {
      return Left(InvalidInputFailure());
    }
  }
}

class InvalidInputFailure extends Failure {}
