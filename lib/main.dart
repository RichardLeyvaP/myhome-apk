// ignore_for_file: unused_element, depend_on_referenced_packages

import 'package:myhome/data/repository/configuration_repository.dart';
import 'package:myhome/data/services/globalCallApi/apiService.dart';
import 'package:myhome/domain/blocs/configuration_bloc/configuration_service.dart';
import 'package:myhome/ui/myApp.dart';
import 'package:myhome/dependency_injection/providers.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('es', null);
  await requestConfiguration();

  runApp(
    MultiProvider(
      providers: providers,
      child: const AppInitializerWidget(),
    ),
  );
}

class AppInitializerWidget extends StatefulWidget {
  const AppInitializerWidget({super.key});

  @override
  State<AppInitializerWidget> createState() => _AppInitializerWidgetState();
}

class _AppInitializerWidgetState extends State<AppInitializerWidget> {
  final ConfigurationRepository configurationRepository = ConfigurationRepository(authService: ApiService());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyApp(),
    );
  }
}
