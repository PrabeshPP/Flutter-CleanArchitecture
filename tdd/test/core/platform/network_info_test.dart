import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd/core/platform/network_info.dart';

class InternetConnectionchecker extends Mock implements InternetConnectionChecker {}

void main() {
  InternetConnectionchecker? internetConnectionchecker;
  NetworkInfoImpl? networkInfoImpl;

  setUp(() {
    internetConnectionchecker = InternetConnectionchecker();
    networkInfoImpl = NetworkInfoImpl(internetConnectionChecker:internetConnectionchecker! );
  });


  group('isConnected', () {
    test('should forward the call to Connectivity.checkConnectivity', () async {
      // arrange
   

      //act

      //verify
    });
  });
}
