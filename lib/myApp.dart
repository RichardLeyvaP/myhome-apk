// ignore_for_file: file_names

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:myhome/Routes/pages_routes.dart';
import 'package:myhome/util/util_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

//todo este es el que me falta optimizar
class Myapp extends StatelessWidget {
  Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = context.watch<RoutesCubit>().state;
    return MaterialApp.router(
      locale: TranslationManager.getCurrentLocale(),
      localizationsDelegates: const [
        // Agrega los delegados de localización para manejar las traducciones
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: TranslationManager.supportedLocales,
      debugShowCheckedModeBanner: false,
      theme: themeDataProfessional(),
      // theme: ThemeData.light(),
      //darkTheme: ThemeData.dark(),
      // themeMode: cLogin.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
      routerConfig: appRouter,
    );
  }

  ThemeData themeDataProfessional() {
    print('themeDataProfessional');
    return ThemeData(
      //fontFamily: 'BebasNeue',
      appBarTheme: AppBarTheme(
        toolbarHeight: 120, // Cambia este valor según tus necesidades
      ),
      textTheme: GoogleFonts.poppinsTextTheme(),
    );
  }
}

final GoRouter _appRouter1 = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      redirect: (context, state) => '/LoginFormPage',
    ),
    GoRoute(
      path: '/LoginFormPage',
      builder: (context, state) => LoginFormPage(),
    ),
    GoRoute(
      path: '/HomePrincipal',
      builder: (context, state) => HomePrincipal(),
    ),
    GoRoute(
      path: '/LoadingPage',
      builder: (context, state) => LoadingPage(),
    ),
    GoRoute(
      path: '/QRViewExample',
      builder: (context, state) => const QRViewPage(),
    ),
    GoRoute(
      path: '/AuthCheck',
      builder: (context, state) => const AuthCheck(),
    ),
    // Puedes agregar más rutas aquí
  ],
);

class RoutesCubit extends Cubit<GoRouter> {
  // Define tu router aquí como una instancia estática o variable global, según tu estructura de proyecto

  RoutesCubit() : super(_appRouter1);

  void goBack() {
    state.pop();
  }

  void goHome() {
    print('navegando con cubit');
    state.go('/HomePrincipal');
  }

  void goAuthCheck() {
    print('navegando con cubit');
    state.go('/AuthCheck');
  }
  // void goHome() {
  //   // Emitir cualquier cambio de estado necesario
  //   emit(_appRouter1); // Emitir appRouter como nuevo estado
  // }
}
