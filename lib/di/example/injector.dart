import 'package:get_it/get_it.dart';

final injector = GetIt.instance;

Future<void> initSingletons() async {
  /// Example of registering singletons of services
  // injector.registerLazySingleton<T>(() => Implementation());
  //

  /// Initiating service:
  ///
  /// First retreive it using getIt and next call its initializer.
  // await injector<T>().initDb();
}

void provideDataSources() {
  /// Registering factory with data source type.
  ///
  /// In example to register other dependency need to be injected, so it is firstly retreived from getIt and then passed as argument.
  // injector.registerFactory<SomeDataSource>(
  //         () => SomeDataSourceImplementation(localDb: injector.get<T>()));
}

void provideRepositories() {
  /// Registering factory with repository type.
  ///
  /// In example to register other dependency need to be injected, so it is firstly retreived from getIt and then passed as argument.
  // injector.registerFactory<SomeRepository>(
  //     () => SomeRepositoryImplementation(someDataSource: injector.get<SomeDataSource>()));
}

void provideUseCases() {
  /// Registering factory with use case type.
  ///
  /// In example to register other dependency need to be injected, so it is firstly retreived from getIt and then passed as argument.
  // injector.registerFactory<SomeUseCase>(() => SomeUseCase(homeRepository: injector.get<SomeRepository>()));
}
