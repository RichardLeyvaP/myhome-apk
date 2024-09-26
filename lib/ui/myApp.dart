// ignore_for_file: file_names

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:myhome/ui/Routes/pages_routes.dart';
import 'package:myhome/ui/pages/rol-admin/product/productCreationPage.dart';
import 'package:myhome/ui/util/util_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myhome/ui/pages/rol-admin/Task/TaskCreationPage.dart';
import 'package:myhome/ui/pages/loginFb.dart';
import 'package:myhome/ui/util/utils_class_apk.dart';

//FUENTE POPINS
//FUENTE del LOGOTIPO Balo 2 // const Color.fromARGB(255, 218, 113, 113)--casi-rojo

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
      theme: themeDataInitialSmall(),
      // theme: ThemeData.light(),
      //darkTheme: ThemeData.dark(),
      // themeMode: cLogin.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
      routerConfig: appRouter,
    );
  }

  ThemeData themeDataInitialSmall() {
    print('themeDataProfessional');
    return ThemeData(
      // Usa la fuente global para todo el proyecto
      fontFamily: StyleGlobalApk.globalTextStyle.fontFamily,

      // Colores principales de la aplicación
      primaryColor: const Color.fromARGB(255, 67, 162, 240), // Color principal
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: Colors.blue, // Color primario
        secondary: Colors.orange, // Color secundario
        surface: Colors.white, // Este es el fondo
      ),

      // Configuración del AppBar
      appBarTheme: AppBarTheme(
        toolbarHeight: 120, // Altura del AppBar
        backgroundColor: Colors.blue, // Color de fondo del AppBar
        titleTextStyle: StyleGlobalApk.globalTextStyle.copyWith(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
          color: Colors.white, // Color del texto en el AppBar
        ),
      ),

      // Configuración global de los textos
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

        // Aquí usas una fuente diferente para `displayMedium`
        displayMedium: StyleGlobalApk.getStyleTitleApk().copyWith(
          color: StyleGlobalApk.getCindicador(),
          fontSize: 24,
          fontWeight: FontWeight.w800,
        ),
      ),

      // Configuración de los botones elevados
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

      // Configuración global de los campos de texto
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0), // Esquinas redondeadas
        ),
        hintStyle: StyleGlobalApk.globalTextStyle.copyWith(
          fontSize: 12.0,
          color: Colors.grey, // Color del hintText
          fontWeight: FontWeight.normal,
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue, // Color del borde cuando está enfocado
          ),
        ),
      ),
    );
  }
}

class AppColors {
  //declarra mas colores para utilizar en la apk
  static const Color customColor1 = Color(0xFFFFA726); // Naranja
  static const Color customColor2 = Color(0xFF66BB6A); // Verde
}

final GoRouter _appRouter1 = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      redirect: (context, state) => '/LoginFormPage',
    ),
    // GoRoute(
    //   path: '/',
    //   redirect: (context, state) => '/LoginFormPage',
    // ),
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
    //Rutas referentes a Insertar
    GoRoute(
      //insertar tareas
      path: '/TaskCreation',
      builder: (context, state) => TaskCreation(),
    ),
    GoRoute(
      //insertar productos
      path: '/ProductCreation',
      builder: (context, state) => ProductCreation(),
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

  void goHomeFb({required name, required email, required avatarUrl}) {
    print('Navegando con cubit');
    // Navega a la ruta '/HomePrincipal' pasando los datos como argumentos
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
  // void goHome() {
  //   // Emitir cualquier cambio de estado necesario
  //   emit(_appRouter1); // Emitir appRouter como nuevo estado
  // }
}
