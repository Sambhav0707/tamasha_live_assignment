import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:tamasha_assignment/core/bloc/theme_bloc.dart';
import 'package:tamasha_assignment/core/constants/app_colors.dart';
import 'package:tamasha_assignment/features/home/data/model/country_model.dart';
import 'package:tamasha_assignment/features/home/domain/entities/country.dart';
import 'package:tamasha_assignment/features/home/presentation/bloc/home_bloc.dart';
import 'package:tamasha_assignment/features/home/presentation/screens/detail_screen.dart';
import 'package:tamasha_assignment/features/home/presentation/widgets/country_countainer_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ScrollController _scrollController;
  late TextEditingController _searchController;
  late Timer debounceTimer;

  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(HomeLoadEvent());
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    _searchController = TextEditingController();

    debounceTimer = Timer(const Duration(milliseconds: 500), () {
      context.read<HomeBloc>().add(
        HomeSearchEvent(searchQuery: _searchController.text),
      );
    });
  }

  void _onScroll() {
    final homeState = context.read<HomeBloc>().state;
    if (homeState is HomeSuccess) {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 300 &&
          !homeState.isLoadingMore &&
          !homeState.hasReachedEnd) {
        context.read<HomeBloc>().add(HomeLoadMoreEvent());
      }
    }
  }

  void _onSearched(String query) {
    query = _searchController.text.toString();

    debounceTimer.cancel();
    debounceTimer = Timer(const Duration(milliseconds: 300), () {
      print(query);
      context.read<HomeBloc>().add(HomeSearchEvent(searchQuery: query));
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDark =
            themeState is ThemeLoaded ? themeState.isDarkMode : false;

        return Scaffold(
          backgroundColor: AppColors.getBackgroundColor(isDark),
          body: RefreshIndicator(
            onRefresh: () async {
              context.read<HomeBloc>().add(HomeRefreshEvent());
            },
            child: Column(
              children: [
                // Minimal AppBar with Theme Toggle
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 20.0,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.getSurfaceColor(isDark),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.getShadowColorWithOpacity(
                          isDark,
                          isDark ? 0.3 : 0.05,
                        ),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: SafeArea(
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColors.getPrimaryContainerColor(isDark),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            Icons.public,
                            color: AppColors.getPrimaryColor(isDark),
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Countries',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.getOnSurfaceColor(isDark),
                                ),
                              ),
                              BlocBuilder<HomeBloc, HomeState>(
                                builder: (context, state) {
                                  final count =
                                      state is HomeSuccess
                                          ? state.displayedCountries.length
                                          : 0;
                                  return Text(
                                    '$count countries',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.getOnSurfaceVariantColor(
                                        isDark,
                                      ),
                                    ),
                                  );
                                },
                              ),

                              TextFormField(
                                controller: _searchController,
                                onChanged: _onSearched,
                              ),
                            ],
                          ),
                        ),
                        // Theme Toggle Switch
                        Row(
                          children: [
                            Icon(
                              Icons.light_mode,
                              size: 20,
                              color: AppColors.getOnSurfaceVariantColor(isDark),
                            ),
                            const SizedBox(width: 8),
                            Switch(
                              value: isDark,
                              onChanged: (value) {
                                context.read<ThemeBloc>().add(
                                  const ToggleThemeEvent(),
                                );
                              },
                              activeColor: AppColors.getPrimaryColor(isDark),
                              activeTrackColor: AppColors.getPrimaryColor(
                                isDark,
                              ).withOpacity(0.3),
                              inactiveThumbColor:
                                  AppColors.getOnSurfaceVariantColor(isDark),
                              inactiveTrackColor: AppColors.getOutlineColor(
                                isDark,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Icon(
                              Icons.dark_mode,
                              size: 20,
                              color: AppColors.getOnSurfaceVariantColor(isDark),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                // Expanded ListView
                Expanded(
                  child: BlocConsumer<HomeBloc, HomeState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      if (state is HomeLoading) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: AppColors.getPrimaryColor(isDark),
                          ),
                        );
                      }
                      if (state is HomeFailure) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.error_outline,
                                size: 64,
                                color: AppColors.getOnSurfaceVariantColor(
                                  isDark,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Failed to load data',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.getOnSurfaceVariantColor(
                                    isDark,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      if (state is HomeSuccess) {
                        if (state.filterCOuntries.isEmpty &&
                            state.isSearching == true) {
                          return Center(child: Text("No data found"));
                        }
                        return Scrollbar(
                          thickness: 6,
                          radius: const Radius.circular(3),
                          interactive: true,
                          controller: _scrollController,
                          child: ListView.builder(
                            padding: const EdgeInsets.all(16),
                            controller: _scrollController,
                            itemCount:
                                state.displayedCountries.length +
                                (state.isLoadingMore ? 1 : 0),
                            itemBuilder: (context, index) {
                              if (index == state.displayedCountries.length &&
                                  state.isLoadingMore) {
                                return Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: AppColors.getPrimaryColor(isDark),
                                    ),
                                  ),
                                );
                              }
                              if (index >= state.displayedCountries.length) {
                                return const SizedBox.shrink();
                              }
                              final country = state.displayedCountries[index];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) => DetailScreen(
                                              country: country as CountryModel,
                                            ),
                                      ),
                                    );
                                  },
                                  child: CountryCountainerWidget(
                                    officialName: country.name.official,
                                    commonName: country.name.common,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search_off,
                              size: 64,
                              color: AppColors.getOnSurfaceVariantColor(isDark),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'No data found',
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.getOnSurfaceVariantColor(
                                  isDark,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
