import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd/core/platform/network_info.dart';

import 'network_info_test.mocks.dart';

@GenerateMocks([InternetConnectionChecker])
void main() {
  MockInternetConnectionChecker? mockInternetChecker;
  NetworkInfoImpl? networkInfoImpl;
  setUp(() {
    mockInternetChecker = MockInternetConnectionChecker();
    networkInfoImpl =
        NetworkInfoImpl(internetConnectionChecker: mockInternetChecker!);
  });

  group("Internet Connnection Checker", () {
    test("Should return boolean if the Internet Connection checker is called ",
        () async {
      //arrange
      when(mockInternetChecker!.hasConnection).thenAnswer((_) async => true);
      //act
      final result = await networkInfoImpl!.isConnected;
      //assert
      verify(mockInternetChecker!.hasConnection);
      expect(result, true);
    });
  });
}
