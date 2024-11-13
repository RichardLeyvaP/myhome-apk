// ignore_for_file: file_names

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:myhome/ui/Routes/pages_routes.dart';
import 'package:myhome/ui/pages/rol-admin/product/productCreationPage.dart';
import 'package:myhome/ui/pages/rol-admin/store/storeCreationPage.dart';
import 'package:myhome/ui/util/util_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:myhome/ui/pages/rol-admin/Task/TaskCreationPage.dart';
import 'package:myhome/ui/pages/loginFb.dart';
import 'package:myhome/ui/util/utils_class_apk.dart';

// lib/ui/myapp.dart

import 'package:myhome/domain/blocs/configuration_bloc/configuration_bloc.dart';
import 'package:myhome/domain/blocs/configuration_bloc/configuration_state.dart';

class Myapp extends StatelessWidget {
  Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConfigurationBloc, ConfigurationState>(
      builder: (context, state) {
        String languageCode = 'es'; // Valor por defecto
        print('Obteniendo configuraciones123:Entrando y el estate es :$state');
        if (state is ConfigurationSuccess) {
          print(
              'Obteniendo configuraciones123:Entrando y el estate es ConfigurationSuccess:${state.configuration.language}');
          languageCode = state.configuration.language ?? 'es';
          TranslationManager.loadDefaultTranslations(languageCode);
          //aqui actualizar la variable de SharPreferents del movil con el idioma que carga
          print('Obteniendo configuraciones123:Entrando y el estate es locale:$languageCode');
        }
        if (state is ConfigurationSubmittedUpdated) {
          languageCode = state.configurationElement.language.toString();
          TranslationManager.loadDefaultTranslations(languageCode);
        }

        return MaterialApp.router(
          locale: TranslationManager.getCurrentApi(languageCode),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate, // Para soportar los componentes Cupertino
          ],
          supportedLocales: TranslationManager.supportedLocales,
          debugShowCheckedModeBanner: false,
          theme: themeDataInitialSmall(),
          routerConfig: context.watch<RoutesCubit>().state,
        );
      },
    );
  }

  ThemeData themeDataInitialSmall() {
    print('themeDataProfessional');
    return ThemeData(
      fontFamily: StyleGlobalApk.globalTextStyle.fontFamily,
      primaryColor: const Color.fromARGB(255, 67, 162, 240),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: Colors.blue,
        secondary: Colors.orange,
        surface: Colors.white,
      ),
      appBarTheme: AppBarTheme(
        toolbarHeight: 120,
        backgroundColor: Colors.blue,
        titleTextStyle: StyleGlobalApk.globalTextStyle.copyWith(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      textTheme: TextTheme(
        bodyMedium: StyleGlobalApk.globalTextStyle.copyWith(
          fontSize: 12.0,
          fontWeight: FontWeight.normal,
          color: Colors.black,
        ),
        titleLarge: StyleGlobalApk.globalTextStyle.copyWith(
          fontSize: 46.0,
          fontWeight: FontWeight.w900,
          color: Colors.black,
        ),
        titleMedium: StyleGlobalApk.globalTextStyle.copyWith(
          fontSize: 16.0,
          fontWeight: FontWeight.w900,
          color: Colors.black,
        ),
        titleSmall: StyleGlobalApk.globalTextStyle.copyWith(
          fontSize: 10.0,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
        displayMedium: StyleGlobalApk.getStyleTitleApk().copyWith(
          color: StyleGlobalApk.getColorIndicador(),
          fontSize: 24,
          fontWeight: FontWeight.w800,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(Colors.blue),
          foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
          textStyle: WidgetStateProperty.all<TextStyle>(
            StyleGlobalApk.globalTextStyle.copyWith(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        hintStyle: StyleGlobalApk.globalTextStyle.copyWith(
          fontSize: 12.0,
          color: Colors.grey,
          fontWeight: FontWeight.normal,
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}

class AppColors {
  static const Color customColor1 = Color(0xFFFFA726); // Naranja
  static const Color customColor2 = Color(0xFF66BB6A); // Verde
}

final GoRouter _appRouter1 = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      redirect: (context, state) => '/LoginFormPage',
    ),
    GoRoute(
      path: '/LoginFbPage',
      builder: (context, state) => LoginFbPage(),
    ),
    GoRoute(
      path: '/LoginFormPage',
      builder: (context, state) => LoginFormPage(),
    ),
    GoRoute(
      path: '/HomePrincipal',
      builder: (context, state) {
        final Map<String, dynamic> extra = state.extra as Map<String, dynamic>? ?? {};
        return HomePrincipal(
          name: extra['name'] ?? '',
          email: extra['email'] ?? '',
          avatarUrl: extra['avatarUrl'] ?? '',
        );
      },
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
    GoRoute(
      path: '/TaskCreation',
      builder: (context, state) => TaskCreation(),
    ),
    GoRoute(
      path: '/ProductCreation',
      builder: (context, state) => ProductCreation(),
    ),
    GoRoute(
      path: '/StoreCreation',
      builder: (context, state) => const StoreCreation(),
    ),
    // Agrega más rutas según sea necesario
  ],
);

class RoutesCubit extends Cubit<GoRouter> {
  RoutesCubit() : super(_appRouter1);

  void goBack() {
    state.pop();
  }

  void goHome() {
    print('navegando con cubit');
    state.go('/HomePrincipal');
  }

  void goHomeFb({required String name, required String email, required String avatarUrl}) {
    print('Navegando con cubit');
    state.go('/HomePrincipal', extra: {
      'name': name,
      'email': email,
      'avatarUrl': avatarUrl,
    });
  }

  void goAuthCheck() {
    print('navegando con cubit');
    state.go('/AuthCheck');
  }
}
