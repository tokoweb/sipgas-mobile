import 'package:core/bloc/bloc.dart';
import 'package:core/cubit/cubit.dart';
import 'package:core/domain/repo/local_repository.dart';
import 'package:core/domain/repo/remote_repository.dart';
import 'package:core/domain/usecase/usecase.dart';
import 'package:core/network/api_service.dart';
import 'package:core/network/dio_client.dart';
import 'package:core/repository/local/local_repository_impl.dart';
import 'package:core/repository/local/shared/shared_preferences.dart';
import 'package:core/repository/local/sqlite/db_helper.dart';
import 'package:core/repository/local/sqlite/db_instance.dart';
import 'package:core/repository/remote/remote_repository_impl.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final inject = GetIt.instance;

Future<void> init(String baseUrl) async {
  // Local
  final preferences = await SharedPreferences.getInstance();
  inject.registerLazySingleton(() => preferences);
  inject.registerLazySingleton(() => SharedPref(preferences: inject()));

  final database = await DatabaseInstance().initDb();
  inject.registerLazySingleton(() => database);
  inject.registerLazySingleton(() => DBHelper(database: inject()));

  // Network
  inject.registerLazySingleton(
      () => ApiService(dio: inject(), sharedPref: inject()));
  inject.registerLazySingleton(() => inject<DioClient>().dio);
  inject.registerLazySingleton(() => DioClient(apiBaseUrl: baseUrl));

  // API Repository
  inject.registerLazySingleton<RemoteRepository>(
      () => RemoteRepositoryImpl(apiService: inject()));

  // Local Repository
  inject.registerLazySingleton<LocalRepository>(
      () => LocalRepositoryImpl(dbHelper: inject()));

  // Repository
  // inject.registerLazySingleton<Repository>(() => inject<Repository>());

  inject.registerFactory(
      () => UseCase(repository: inject(), localRepository: inject()));

  // BLoC
  inject.registerFactory(
      () => LoginCubit(useCase: inject(), sharedPref: inject()));
  inject.registerFactory(
      () => ProfileBloc(useCase: inject(), sharedPref: inject()));

  inject.registerFactory(
      () => UpdateProfileCubit(useCase: inject(), sharedPref: inject()));

  inject.registerFactory(
      () => TravelDocBloc(useCase: inject(), sharedPref: inject()));
  inject
      .registerFactory(() => TubeBloc(useCase: inject(), sharedPref: inject()));
  
  inject
      .registerFactory(() => NotifBloc(useCase: inject(), sharedPref: inject()));
}
