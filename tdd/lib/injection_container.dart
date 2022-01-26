import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdd/core/platform/network_info.dart';
import 'package:tdd/core/util/input_converter.dart';
import 'package:tdd/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:tdd/features/number_trivia/data/datasources/number_trivia_remote_sources.dart';
import 'package:tdd/features/number_trivia/data/respositories/number_trivia_repository_impl.dart';
import 'package:tdd/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:tdd/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:tdd/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:tdd/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:http/http.dart' as http;

final getit = GetIt.instance;

Future<void> init() async{
  //! Features -NumberTrivia
  //bloc
  getit.registerFactory(() => NumberTriviaBloc(
      getConcreteNumberTrivia: getit(),
      getRandomNumberTrivia: getit(),
      inputConverter: getit()));
  //Use Cases
  getit.registerLazySingleton(() => GetConcreteNumberTrivia(getit()));
  getit.registerLazySingleton(() => GetRandomNumberTrivia(repository: getit()));

  //Repository
  getit.registerLazySingleton<NumberTriviaRepository>(() =>
      NumberTriviaRepositoryImpl(
          localDataSource: getit(),
          remoteSources: getit(),
          networkInfo: getit()));

  //Data Sources

  //Local Data Source
  getit.registerLazySingleton<NumberTriviaLocalDataSource>(
      () => NumberTriviaLocalDataSourceImpl(sharedPreferences: getit()));
  

  //Remote Data Source

  getit.registerLazySingleton<NumberTriviaRemoteSources>(
      () => NumberTriviaRemoteSourcesImpl(httpClient: getit()));
  

  


  //! Core
  getit.registerLazySingleton(() => InputConverter());
  //NetworkInfo
  getit.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(internetConnectionChecker: getit()));
  

  //! External
  final sharedPreferences=await SharedPreferences.getInstance();
  getit.registerLazySingleton(() =>sharedPreferences );
  getit.registerLazySingleton(() => http.Client);
  getit.registerLazySingleton(() => InternetConnectionChecker());

}
