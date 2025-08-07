import 'dart:async';

import 'package:fpdart/fpdart.dart';
import 'package:tamasha_assignment/core/errors/failure.dart';
import 'package:tamasha_assignment/core/usecase/usecase.dart';
import 'package:tamasha_assignment/features/home/domain/entities/country.dart';
import 'package:tamasha_assignment/features/home/domain/repository/home_repository.dart';

class GetCountries extends UseCase<List<Country>, NoParams> {
  final HomeRepository homeRepository ;
  GetCountries({required this.homeRepository});

  @override
  FutureOr<Either<Failure, List<Country>>> call(NoParams params) async {
    return await homeRepository.getCountriesData();
  }
}
