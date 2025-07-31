import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:tamasha_assignment/core/errors/failure.dart';

abstract class UseCase<SuccessType, Params> {
  FutureOr<Either<Failure, SuccessType>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
