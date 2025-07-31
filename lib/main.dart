import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamasha_assignment/core/bloc_observer.dart';
import 'package:tamasha_assignment/core/bloc/theme_bloc.dart';
import 'package:tamasha_assignment/features/home/presentation/bloc/home_bloc.dart';
import 'package:tamasha_assignment/init_dependencies.dart' as di;
import 'package:tamasha_assignment/features/splash/presentation/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.initDependency();
  // Set up BlocObserver
  Bloc.observer = AppBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<HomeBloc>()),
        BlocProvider(create: (_) => ThemeBloc()),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          final isDarkMode = state is ThemeLoaded ? state.isDarkMode : false;

          return MaterialApp(
            title: 'Flutter Assignment',
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
            home: const SplashScreen(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
