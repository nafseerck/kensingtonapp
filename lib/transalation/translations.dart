import 'package:shared_preferences/shared_preferences.dart';

class Translations {
  static final languages = <String>[
    'English',
    'German',
    'Spanish',
  ];

  static String getLanguageCode(String language) {
    switch (language) {
      case 'English':
        return 'en';
      case 'Spanish':
        return 'es';
      case 'German':
        return 'de';
      default:
        return 'en';
    }
  }




}
