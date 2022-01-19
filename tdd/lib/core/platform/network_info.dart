import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';



abstract class NetworkInfo {
  Future<bool>? get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity? connectivity;

  NetworkInfoImpl({required this.connectivity});
  @override
  Future<bool>? get isConnected => throw UnimplementedError();
}
