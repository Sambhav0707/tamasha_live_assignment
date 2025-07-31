import 'package:fpdart/src/either.dart';
import 'package:tamasha_assignment/core/errors/exceptions.dart';
import 'package:tamasha_assignment/core/errors/failure.dart';
import 'package:tamasha_assignment/features/home/data/data_sources/remote_data_source.dart';
import 'package:tamasha_assignment/features/home/data/model/country_model.dart';
import 'package:tamasha_assignment/features/home/domain/repository/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final RemoteDataSource remoteDataSource;
  HomeRepositoryImpl({required this.remoteDataSource});
  @override
  Future<Either<Failure, List<CountryModel>>> getCountriesData() async {
    try {
      final result = await remoteDataSource.getRemoteData();
      return Right(result);
    } on ServerException catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
