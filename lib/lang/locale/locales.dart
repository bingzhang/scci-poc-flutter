import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:profile_demo/lang/l10n/messages_all.dart';

class AppLocalizations{
  static Future<AppLocalizations> load(Locale locale) async{

    final String name = locale.countryCode.isEmpty ? locale.languageCode : locale.toString();

    final String localName = Intl.canonicalizedLocale(name);

    return initializeMessages(localName).then((bool _){
      Intl.defaultLocale = localName;
      return AppLocalizations();
    });

  }

  static AppLocalizations of(BuildContext context){
    AppLocalizations local= Localizations.of<AppLocalizations>(context,AppLocalizations);
    return local;
  }

  String get studentHomeGoodMorningText{
      return Intl.message('Good Morning, Alex!',name:'studentHomeGoodMorningText');
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations>{
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en','es','zh'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) {
    return AppLocalizations.load(locale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) {
    return false;
  }

}