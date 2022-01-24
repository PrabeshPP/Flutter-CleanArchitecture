import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd/core/util/input_converter.dart';

class MockInputConverter extends Mock implements InputConverter {}

void main() {
  MockInputConverter? mockInputConverter;

  setUp(() {
    mockInputConverter = MockInputConverter();
  });
  String tNumberString = "5";

  test("Should convert the given String number to integer ", () {
    // arrange
   
    // act
   
    // verify
  
  });
}
