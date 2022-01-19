import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd/core/platform/network_info.dart';

class MockConnectivityChecker extends Mock implements Connectivity {}

void main() {
  MockConnectivityChecker? mockConnectivityChecker;
  NetworkInfoImpl? networkInfoImpl;

  setUp(() {
    mockConnectivityChecker = MockConnectivityChecker();
    networkInfoImpl = NetworkInfoImpl(connectivity: mockConnectivityChecker);
  });

  group('isConnected', () {
    test('should forward the call to Connectivity.checkConnectivity', () async {
      // arrange
      // when(mockConnectivityChecker!.checkConnectivity()).thenAnswer(
      //     (_) async => await mockConnectivityChecker!.checkConnectivity());

      //act

      //verify
    });
  });
}
