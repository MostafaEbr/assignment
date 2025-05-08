import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:assignment/config/router/app_router.dart';
import 'package:assignment/config/themes/app_theme.dart';
import 'package:assignment/config/di/injection.dart';
import 'package:assignment/config/l10n/app_localizations.dart';
import 'package:assignment/features/categories/presentation/bloc/category_bloc.dart';
import 'package:assignment/features/products/presentation/bloc/product_bloc.dart';
import 'package:assignment/features/product_details/presentation/bloc/product_details_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<CategoryBloc>()),
        BlocProvider(create: (_) => getIt<ProductBloc>()),
        BlocProvider(create: (_) => getIt<ProductDetailsBloc>()),
      ],
      child: MaterialApp.router(
        title: 'Assignment',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        routerConfig: router,
        localizationsDelegates: const [
          AppLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('en', 'US'), Locale('es', 'ES')],
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
