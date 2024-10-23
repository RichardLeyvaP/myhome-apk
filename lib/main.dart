// ignore_for_file: unused_element, depend_on_referenced_packages

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myhome/data/repository/auth_repository.dart';
import 'package:myhome/data/repository/configuration_repository.dart';
import 'package:myhome/data/repository/products_repository.dart';
import 'package:myhome/data/repository/store_repository.dart';
import 'package:myhome/data/repository/tasks_repository.dart';
import 'package:myhome/data/services/globalCallApi/apiService.dart';
import 'package:myhome/dependency_injection/app_initializer.dart';
import 'package:myhome/domain/blocs/configuration_bloc/configuration_bloc.dart';
import 'package:myhome/domain/blocs/configuration_bloc/configuration_event.dart';
import 'package:myhome/domain/blocs/login_bloc/login_bloc.dart';
import 'package:myhome/domain/blocs/product_cat_state/bloc/product_cat_state_bloc.dart';
import 'package:myhome/domain/blocs/products_bloc/products_bloc.dart';
import 'package:myhome/domain/blocs/store_bloc/store_bloc.dart';
import 'package:myhome/domain/blocs/task_cat_state_prior.dart/task_cat_state_prior_bloc.dart';
import 'package:myhome/domain/blocs/tasks/tasks_bloc.dart';
import 'package:myhome/ui/myApp.dart';
import 'package:myhome/dependency_injection/providers.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:myhome/ui/util/util_class.dart';
import 'package:provider/provider.dart';

void main() async {
  // DependencyInjection.registerDependencies();
  await AppInitializer.initializeApp();
  //initializeDateFormatting('es_ES', null).then((_) {
  initializeDateFormatting('es', null).then((_) async {
    WidgetsFlutterBinding.ensureInitialized();

    runZonedGuarded(() {
      //controlar errores
      FlutterError.onError = (details) {
        print('Controlando errores flutter');
        Zone.current.handleUncaughtError(details.exceptionAsString(), details.stack ?? StackTrace.empty);
        //  log(details.exceptionAsString(), stackTrace: details.stack);
      };
      runApp(
        MultiProvider(
          providers: providers, //esto es para la autenticacion por la huella dactilar
          child: const BlocsProviders(),
        ),
      );
    }, (error, stack) {
      if (kDebugMode) {
        print('Controlando errores flutter-ZONA');
        print('Controlando errores flutter-ZONA error:${error}');

        // log(error.toString(), stackTrace: stack);
      } else {
        //aqui mandar al backend los errores
        print('Controlando errores flutter-ZONA-SIN ESTAR EN DEBUGER');
      }
    });
    // Cargar las traducciones iniciales (en este caso, inglés)

    // Cargar las traducciones antes de iniciar la aplicación
    //await _requestPermissions();
    // await Firebase.initializeApp();
    // TranslationManager.loadDefaultTranslations('es');
  });
}

class BlocsProviders extends StatelessWidget {
  const BlocsProviders({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(
          create: (context) => RoutesCubit(),
          //por defecto es true y solo lo llama cuando lo necesita
        ),
        BlocProvider(
          create: (context) => LoginBloc(authRepository: AuthRepository(authService: ApiService())),
          //por defecto es true y solo lo llama cuando lo necesita
        ),
        BlocProvider(
          create: (context) => TasksBloc(tasksRepository: TasksRepository(authService: ApiService())),
          //por defecto es true y solo lo llama cuando lo necesita
        ),
        BlocProvider(
          create: (context) => ProductsBloc(productsRepository: ProductsRepository(authService: ApiService())),
          lazy: false,
          //por defecto es true y solo lo llama cuando lo necesita
        ),
        BlocProvider(
          create: (context) =>
              CategoriesPrioritiesBloc(productsRepository: ProductsRepository(authService: ApiService())),
          //por defecto es true y solo lo llama cuando lo necesita
        ),
        BlocProvider(
          create: (context) =>
              CategoriesStatePrioritiesBloc(taskRepository: TasksRepository(authService: ApiService())),
          //por defecto es true y solo lo llama cuando lo necesita
        ),
        BlocProvider(
          create: (context) => LoginBloc(authRepository: AuthRepository(authService: ApiService())),
          //por defecto es true y solo lo llama cuando lo necesita
        ),
        BlocProvider(
          create: (context) => StoreBloc(storesRepository: StoreRepository(authService: ApiService())),
          //por defecto es true y solo lo llama cuando lo necesita
        ),
        BlocProvider(
          create: (context) =>
              ConfigurationBloc(configurationRepository: ConfigurationRepository(authService: ApiService()))
                ..add(ConfigurationRequested(DateTime.now())), // Cargar la configuración inicial
          lazy: false,
        ),
      ],
      child: Myapp(),
    );
  }
}
