import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:open_weather_app/constants/style.dart';
import 'package:open_weather_app/cubits/temperature/temp_settings_cubit.dart';
import 'package:open_weather_app/cubits/theme/theme_cubit.dart';
import 'package:open_weather_app/repository/weather_repository.dart';
import 'package:open_weather_app/routes/app_routes.dart';
import 'package:open_weather_app/services/weather_api_services.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import 'cubits/weather/weather_cubit.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env');
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );
  runApp(MyApp(
    appRouter: AppRouter(),
  ));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  const MyApp({
    Key? key,
    required this.appRouter,
  }) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => WeatherRepository(
        weatherApiServices: WeatherApiServices(
          httpClient: http.Client(),
        ),
      ),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<WeatherCubit>(
            create: (context) => WeatherCubit(
              weatherRepository: context.read<WeatherRepository>(),
            ),
          ),
          BlocProvider<TempSettingsCubit>(
            create: (context) => TempSettingsCubit(),
          ),
          BlocProvider<ThemeCubit>(
            create: (context) => ThemeCubit(),
          ),
        ],
        child: BlocListener<WeatherCubit, WeatherState>(
          listener: (context, state) {
            context.read<ThemeCubit>().setTheme(state.weather.temp);
          },
          child: BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, state) {
              return MaterialApp.router(
                debugShowCheckedModeBanner: false,
                title: appName,
                theme: state.appTheme == AppTheme.light
                    ? ThemeData.light()
                    : ThemeData.dark(),
                routerDelegate: appRouter.goRouter.routerDelegate,
                routeInformationParser:
                    appRouter.goRouter.routeInformationParser,
                routeInformationProvider:
                    appRouter.goRouter.routeInformationProvider,
              );
            },
          ),
        ),
      ),
    );
  }
}
