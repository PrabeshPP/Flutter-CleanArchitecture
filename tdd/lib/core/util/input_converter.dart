import 'package:dartz/dartz.dart';
import 'package:tdd/core/error/failure.dart';

class InputConverter {
  Either<Failure, int> StringtoInt(String number1) {
    int number = int.parse(number1);
    return Right(number);
  }
}
