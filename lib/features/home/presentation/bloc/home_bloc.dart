import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tamasha_assignment/core/usecase/usecase.dart';
import 'package:tamasha_assignment/features/home/data/model/country_model.dart';
import 'package:tamasha_assignment/features/home/domain/entities/country.dart';
import 'package:tamasha_assignment/features/home/domain/usecases/get_countries.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetCountries _getCountries;
  List<Country> allCountries = [];
  List<Country> displayedCountries = [];
  bool isLoadingMore = false;
  int currentPage = 1;
  final int pageSize = 10;

  HomeBloc({required GetCountries getCountries})
    : _getCountries = getCountries,
      super(HomeInitial()) {
    on<HomeLoadEvent>(_onLoad);
    on<HomeLoadMoreEvent>(_onLoadMore);
    on<HomeRefreshEvent>(_onRefresh);
  }

  _onLoad(HomeLoadEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    final result = await _getCountries.call(NoParams());

    result.fold(
      (failure) {
        emit(HomeFailure(message: failure.message));
      },
      (success) {
        allCountries = success;
        displayedCountries = allCountries.take(pageSize).toList();
        currentPage = 1;
        isLoadingMore = false;
        emit(
          HomeSuccess(
            countryModel: success,
            displayedCountries: displayedCountries,
            isLoadingMore: isLoadingMore,
            hasReachedEnd: displayedCountries.length >= allCountries.length,
          ),
        );
      },
    );
  }

  _onLoadMore(HomeLoadMoreEvent event, Emitter<HomeState> emit) async {
    if (displayedCountries.length >= allCountries.length || isLoadingMore) {
      return;
    }

    isLoadingMore = true;
    emit(
      HomeSuccess(
        countryModel: allCountries,
        displayedCountries: displayedCountries,
        isLoadingMore: isLoadingMore,
        hasReachedEnd: displayedCountries.length >= allCountries.length,
      ),
    );

    await Future.delayed(const Duration(seconds: 1));

    final nextPage = currentPage + 1;
    final nextItems =
        allCountries.skip(currentPage * pageSize).take(pageSize).toList();
    displayedCountries.addAll(nextItems);
    currentPage = nextPage;
    isLoadingMore = false;

    emit(
      HomeSuccess(
        countryModel: allCountries,
        displayedCountries: displayedCountries,
        isLoadingMore: isLoadingMore,
        hasReachedEnd: displayedCountries.length >= allCountries.length,
      ),
    );
  }

  _onRefresh(HomeRefreshEvent event, Emitter<HomeState> emit) {
    displayedCountries = allCountries.take(pageSize).toList();
    currentPage = 1;
    isLoadingMore = false;

    emit(
      HomeSuccess(
        countryModel: allCountries,
        displayedCountries: displayedCountries,
        isLoadingMore: isLoadingMore,
        hasReachedEnd: displayedCountries.length >= allCountries.length,
      ),
    );
  }
}
