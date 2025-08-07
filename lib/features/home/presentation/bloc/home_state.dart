part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoaded extends HomeState {}

final class HomeSuccess extends HomeState {
  final List<Country> countryModel;
  final List<Country> displayedCountries;
  final List<Country> filterCOuntries;
  String searchQuery = '';
  bool isSearching = false;

  final bool isLoadingMore;
  final bool hasReachedEnd;

  HomeSuccess(
    this.filterCOuntries,
     this.searchQuery, 
     this.isSearching, {
    required this.countryModel,
    required this.displayedCountries,
    required this.isLoadingMore,
    required this.hasReachedEnd,
  });
}

final class HomeFailure extends HomeState {
  final String message;
  HomeFailure({required this.message});
}
