import 'dart:convert';
import 'package:myhome/Controllers/login.controller.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final LoginController cLogin =
    Get.find<LoginController>(); // Obtén la instancia de LoginController

class TranslationManager {
  static late Locale _locale;
  static late Map<String, dynamic> _localizedValues;

  static List<Locale> supportedLocales = [
    const Locale('en', 'US'),
    const Locale('es', 'ES'),
    const Locale('pt', 'BR'),
  ];

  static LocalizationsDelegate<TranslationManager> delegate =
      _TranslationDelegate();

  // Cargar las traducciones por defecto al iniciar la aplicación
  static Future<void> loadDefaultTranslations() async {
    _locale = await findSystemLocale();
    await loadTranslations(_locale);
  }

  // Cargar traducciones específicas para un locale dado
  static Future<void> loadTranslations(Locale locale) async {
    String jsonContent =
        await rootBundle.loadString('lib/l10n/app_${locale.languageCode}.arb');
    _localizedValues = json.decode(jsonContent);
    _locale = locale;
  }

  // Método para traducir una clave dada
  static String translate(String key) {
    return _localizedValues[key] ?? key;
  }

  // Obtener el locale actual
  static Locale getCurrentLocale() {
    return _locale;
  }

  // Actualizar el locale actual
  static void updateLocale(Locale locale) {
    _locale = locale;
  }

  // Encontrar el locale del sistema operativo (puede ser asíncrono)
  static Future<Locale> findSystemLocale() async {
    // Implementa aquí la lógica para determinar el idioma del sistema operativo
    return const Locale('en', 'US'); // Valor por defecto
  }
}

class _TranslationDelegate extends LocalizationsDelegate<TranslationManager> {
  const _TranslationDelegate();

  @override
  bool isSupported(Locale locale) =>
      TranslationManager.supportedLocales.contains(locale);

  @override
  Future<TranslationManager> load(Locale locale) async {
    await TranslationManager.loadTranslations(locale);
    return TranslationManager();
  }

  @override
  bool shouldReload(_TranslationDelegate old) => false;
}

//
//
//

class LanguageSelector extends StatefulWidget {
  @override
  _LanguageSelectorState createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  String _selectedLanguage = 'English'; // Valor inicial seleccionado

  List<String> _languages = [
    'English',
    'Español',
    'Português'
  ]; // Lista de idiomas

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: _selectedLanguage,
      items: _languages.map((String language) {
        return DropdownMenuItem<String>(
          value: language,
          child: Text(language),
        );
      }).toList(),
      onChanged: (String? selectedLanguage) {
        if (selectedLanguage != null) {
          setState(() {
            _selectedLanguage = selectedLanguage;
          });

          // Cambia el idioma en la aplicación
          Locale newLocale;
          switch (selectedLanguage) {
            case 'English':
              newLocale = const Locale('en', 'US');
              break;
            case 'Español':
              newLocale = const Locale('es', 'ES');
              break;
            case 'Português':
              newLocale = const Locale('pt', 'BR');
              break;
            default:
              newLocale = const Locale('en', 'US'); // Idioma por defecto
          }

          // Actualiza el locale y las traducciones
          TranslationManager.loadTranslations(newLocale).then((_) {
            TranslationManager.updateLocale(newLocale);
            setState(() {
              // Puedes agregar cualquier actualización adicional aquí
            });
          });
        }
      },
      underline: Container(
        height: 0,
        color: Colors.transparent,
      ),
    );
  }
}
