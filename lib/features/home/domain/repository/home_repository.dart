import 'package:fpdart/fpdart.dart';
import 'package:tamasha_assignment/core/errors/failure.dart';
import 'package:tamasha_assignment/features/home/domain/entities/country.dart';

abstract interface class HomeRepository {
  Future<Either<Failure, List<Country>>> getCountriesData();
}
