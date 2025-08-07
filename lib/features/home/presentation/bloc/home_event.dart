part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

final class HomeLoadEvent extends HomeEvent {}

final class HomeLoadMoreEvent extends HomeEvent {}

final class HomeRefreshEvent extends HomeEvent {}

final class HomeSearchEvent extends HomeEvent{
  final String searchQuery;

  HomeSearchEvent({required this.searchQuery});

}

final class HomeSearchStopEvent extends HomeEvent{}
