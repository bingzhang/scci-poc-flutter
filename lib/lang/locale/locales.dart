/*
 * Copyright (c) 2019 UIUC. All rights reserved.
 */

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:profile_demo/lang/l10n/messages_all.dart';

class AppLocalizations {
  static Future<AppLocalizations> load(Locale locale) async {
    final String name =
        (locale.countryCode == null || locale.countryCode.isEmpty)
            ? locale.languageCode
            : locale.toString();

    final String localName = Intl.canonicalizedLocale(name);

    return initializeMessages(localName).then((bool _) {
      Intl.defaultLocale = localName;
      return AppLocalizations();
    });
  }

  static AppLocalizations of(BuildContext context) {
    AppLocalizations local =
        Localizations.of<AppLocalizations>(context, AppLocalizations);
    return local;
  }

  //StudentHomePanel
  String get studentHomeGoodMorningText {
    return Intl.message('Good Morning, Alex!',
        name: 'studentHomeGoodMorningText');
  }

  String get studentHomeEventTime {
    return Intl.message('Next Event 9:30am',
        name: 'studentHomeEventTime');
  }

  String get studentHomeEventDescription {
    return Intl.message('TE 401: Intro to Design Thinking',
        name: 'studentHomeEventDescription');
  }

  String get studentHomeEventLocation {
    return Intl.message('Noble Hall, Room 211',
        name: 'studentHomeEventLocation');
  }

  String get studentHomeButtonLifeCampus {
    return Intl.message('Life on Campus',
        name: 'studentHomeButtonLifeCampus');
  }

  String get studentHomeButtonNextEvent {
    return Intl.message('News + Events',
        name: 'studentHomeButtonNextEvent');
  }

  String get studentHomeButtonAthletics {
    return Intl.message('Athletics + Campus Venues',
        name: 'studentHomeButtonAthletics');
  }

  String get studentHomeButtonMaps {
    return Intl.message('Indoor Maps',
        name: 'studentHomeButtonMaps');
  }

  //NextEventDetails
  String get nextEventTimeHint {
    return Intl.message("1 hr 20 min until the event",
        name: 'nextEventTimeHint');
  }

  String get nextEventTimeUntilLabel {
    return Intl.message('Time Until',
        name: 'nextEventTimeUntilLabel');
  }

  String get nextEventTimeLabel {
    return Intl.message('1 hr 20 min',
        name: 'nextEventTimeLabel');
  }

  String get nextEventAlarmHint {
    return Intl.message('15 minutes to alarm',
        name: 'nextEventAlarmHint');
  }

  String get nextEventBycycleHint {
    return Intl.message("7 minutes to bycycle",
        name: 'nextEventBycycleHint');
  }

  //common

  String get min {
    return Intl.message("min",
        name: 'min');
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'es', 'zh'].contains(locale.languageCode);
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
