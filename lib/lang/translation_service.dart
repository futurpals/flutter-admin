import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'en_US.dart';
import 'zh_CH.dart';

const List<Locale> languages = [
  Locale('en', 'US'),
  Locale('zh', 'CH'),
  Locale('es', 'ES'),
  Locale('de', 'DE'),
  Locale('fr', 'FR'),
  Locale('ar', 'AR'),
  Locale('ru', 'Ru'),
];

const langMap = {
  'zh': '中文',
  'en': 'English',
  'es': 'española',
  'de': 'Deutsch',
  'fr': 'Français',
};

class TranslationService extends Translations {
  static Locale? get locale => Get.deviceLocale;
  static const fallbackLocale = Locale('zh', 'CH');

  @override
  Map<String, Map<String, String>> get keys => {
        'zh_CH': zh_CH,
        'en_US': en_US,
      };
}
