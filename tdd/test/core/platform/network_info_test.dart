import 'package:flutter_test/flutter_test.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd/core/platform/network_info.dart';

class MockConnectivityPlus extends Mock implements Connectivity {}

void main() {
  MockConnectivityPlus? mockConnectivityPlus;
  NetworkInfoImpl? networkInfoImpl;

  setUp(() {
    mockConnectivityPlus = MockConnectivityPlus();
    networkInfoImpl = NetworkInfoImpl(connectivity: mockConnectivityPlus);
  });

  group('isConnected', () {
    test('should forward the call to Connectivity.checkConnectivity', () async {
      // arrange
      when(mockConnectivityPlus!.checkConnectivity())
          .thenAnswer((_) async => );

      //act

      //verify
    });
  });
}
