// ignore_for_file: depend_on_referenced_packages

import 'package:myhome/Components/button_custom.dart';
import 'package:myhome/services/local_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class AuthCheck extends StatefulWidget {
  const AuthCheck({Key? key}) : super(key: key);

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  final ValueNotifier<bool> isLocalAuthFailed = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    checkLocalAuth();
  }

  checkLocalAuth() async {
    final auth = context.read<LocalAuthService>();
    final isLocalAuthAvailable = await auth.isBiometricAvailable();
    isLocalAuthFailed.value = false;

    if (isLocalAuthAvailable) {
      final authenticated = await auth.authenticate();

      if (!authenticated) {
        isLocalAuthFailed.value = true;
      } else {
        if (!mounted) return;
        Get.offAllNamed('/HomePricipal');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Theme.of(context).colorScheme.primary,
      // backgroundColor: Theme.of(context).primaryColor,
      body: ValueListenableBuilder<bool>(
        valueListenable: isLocalAuthFailed,
        builder: (context, failed, _) {
          if (failed) {
            print('aqui fallo por esto:$failed');
            return Center(
              child: CustomButton(
                onPressed: checkLocalAuth,
                text: 'Intentar autenticarse nuevamente',
              ),
            );
          }
          return const Center(
            child: SizedBox(
              width: 120,
              height: 120,
              child: Column(
                children: [
                  CircularProgressIndicator(
                    color: Colors.white,
                    backgroundColor: Color(0xFFFDAE2A),
                  ),
                  Text(
                    'Cargando...',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
