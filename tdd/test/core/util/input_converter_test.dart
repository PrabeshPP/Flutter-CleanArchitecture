import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd/core/util/input_converter.dart';

void main() {
  InputConverter? inputConverter;
  setUp(() {
    inputConverter = InputConverter();
  });

  group("StringToUnsignedInteger", () {
    test("Should return an integer when the string is Unsigned Integer",
        () async {
      // arrange
      String tNUmberString = "10";
      // act
      final result = inputConverter!.stringToInt(tNUmberString);
      // assert
      expect(result, const Right(10));
    });

    test("Should throw an error when the String is not an Unsigned Integer",
        () async {
      //arrange
      String tNumberString = "Prabesh";

      //act
      final result = inputConverter!.stringToInt(tNumberString);

      //assert
      expect(result, Left(InvalidInputFailure()));
    });
  });
}
