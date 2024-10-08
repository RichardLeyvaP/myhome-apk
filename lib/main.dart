// ignore_for_file: unused_element, depend_on_referenced_packages

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myhome/app_initializer.dart';
import 'package:myhome/dependency_injection.dart';
import 'package:myhome/myApp.dart';
import 'package:myhome/providers.dart';
import 'package:myhome/util/util_class.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:myhome/views/blocs/bloc.dart';
import 'package:provider/provider.dart';

void main() async {
  DependencyInjection.registerDependencies();
  await AppInitializer.initializeApp();
  //initializeDateFormatting('es_ES', null).then((_) {
  initializeDateFormatting('pt', null).then((_) async {
    WidgetsFlutterBinding.ensureInitialized();
    // Cargar las traducciones iniciales (en este caso, inglés)
    await TranslationManager.loadDefaultTranslations();
    // Cargar las traducciones antes de iniciar la aplicación
    //await _requestPermissions();

    runApp(
      MultiProvider(
        providers:
            providers, //esto es para la autenticacion por la huella dactilar
        child: const BlocsProviders(),
      ),
    );
  });
}

class BlocsProviders extends StatelessWidget {
  const BlocsProviders({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //aqui pongo tds los Cubic que necesite
        BlocProvider(
          create: (context) => UsernameCubit(),
          lazy: false, //con esto una vez que se crea la app el lo llama
          //por defecto es true y solo lo llama cuando lo necesita
        ),
        BlocProvider(
          create: (context) => RoutesCubit(),
          //por defecto es true y solo lo llama cuando lo necesita
        ),
      ],
      child: Myapp(),
    );
  }
}
