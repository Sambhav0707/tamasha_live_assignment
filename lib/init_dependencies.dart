import 'package:get_it/get_it.dart';
import 'package:tamasha_assignment/features/home/data/data_sources/remote_data_source.dart';
import 'package:tamasha_assignment/features/home/data/repository/home_repository_impl.dart';
import 'package:tamasha_assignment/features/home/domain/repository/home_repository.dart';
import 'package:tamasha_assignment/features/home/domain/usecases/get_countries.dart';
import 'package:tamasha_assignment/features/home/presentation/bloc/home_bloc.dart';

final sl = GetIt.instance;
Future<void> initDependency() async {
  // Features : - HOME

  sl.registerFactory<RemoteDataSource>(() => RemoteDataSourceImpl());
  sl.registerFactory<HomeRepository>(
    () => HomeRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerFactory(() => GetCountries(homeRepository: sl()));
  sl.registerLazySingleton(() => HomeBloc(getCountries: sl()));
}
