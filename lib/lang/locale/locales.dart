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

  String get studentHomeButtonNewsEvent {
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

  //ProfileEditPanel
  String get profileEditTitle {
    return Intl.message("My Profile",
        name: 'profileEditTitle');
  }

  String get profileEditNameHint {
    return Intl.message('Please, type your name',
        name: 'profileEditNameHint');
  }

  String get profileEditNameLabel {
    return Intl.message('Name:',
        name: 'profileEditNameLabel');
  }

  String get profileEditNameValidation {
    return Intl.message('Please, type name and family.',
        name: 'profileEditNameValidation');
  }

  String get profileEditPhoneHint {
    return Intl.message('Please, type your phone number',
        name: 'profileEditPhoneHint');
  }

  String get profileEditPhoneLabel {
    return Intl.message('Phone:',
        name: 'profileEditPhoneLabel');
  }

  String get profileEditPhoneValidation {
    return Intl.message('Please, type valid phone number. Ex: (111) 111-1111',
        name: 'profileEditPhoneValidation');
  }

  String get profileEditBirthDateHint {
    return Intl.message('Please, type your date of birth',
        name: 'profileEditBirthDateHint');
  }

  String get profileEditBirthDateLabel {
    return Intl.message('Date of Birth:',
        name: 'profileEditBirthDateLabel');
  }

  String get profileEditBirthDateValidation {
    return Intl.message('Please, type valid date in format: yyyy/MM/dd',
        name: 'profileEditBirthDateValidation');
  }

  String get profileEditRoleStudent {
    return Intl.message('Student',
        name: 'profileEditRoleStudent');
  }

  String get profileEditRoleStaff {
    return Intl.message('Staff',
        name: 'profileEditRoleStaff');
  }

  String get profileEditRoleOther {
    return Intl.message('Other',
        name: 'profileEditRoleOther');
  }

  String get profileEditRoleLabel {
    return Intl.message('Role:',
        name: 'profileEditRoleLabel');
  }

  String get profileEditRoleValidation {
    return Intl.message('Please, select role.',
        name: 'profileEditRoleValidation');
  }

  String get profileEditButtonSave {
    return Intl.message('Save',
        name: 'profileEditButtonSave');
  }

  String get profileEditStateSaveMessage {
    return Intl.message(' to save user profile',
        name: 'profileEditStateSaveMessage');
  }

  String get profileEditButtonDelete {
    return Intl.message('Delete',
        name: 'profileEditButtonDelete');
  }

  String get profileEditStateDeleteMessage {
    return Intl.message(' to delete user profile',
        name: 'profileEditStateDeleteMessage');
  }

  String get profileEditStateDeleteError {
    return Intl.message('There is no saved profile to delete.',
        name: 'profileEditStateDeleteError');
  }

  //StudentLifeInCampus

  String get studentLifeCampusTitle {
    return Intl.message('Life on Campus',
        name: 'studentLifeCampusTitle');
  }

  //StudentEventsPanel

  String get studentEventTitle {
    return Intl.message('ILLINI Women\'s Basketball',
        name: 'studentEventTitle');
  }

  String get studentEventReadMore {
    return Intl.message('read more',
        name: 'studentEventReadMore');
  }

  String get studentEventContentMessage {
    return Intl.message('The fighting ILLINI are off to a good start this season! Come join us for their home game of the season this Friday at 9pm!',
        name: 'studentEventContentMessage');
  }

  //StudentSchedulePanel
  String get studentScheduleEventHeader {
    return Intl.message('Ready for Lunch?',
        name: 'studentScheduleEventHeader');
  }

  String get studentScheduleEventTime {
    return Intl.message('Next Event 1:00pm',
        name: 'studentScheduleEventTime');
  }

  String get studentScheduleEventDescription {
    return Intl.message('ARTD 202: ID Studio II',
        name: 'studentScheduleEventDescription');
  }

  String get studentScheduleEventLocation {
    return Intl.message('Ready for Lunch?',
        name: 'studentScheduleEventLocation');
  }

  //StudentUpToDate
  String get studentUpToDateWalkDistance {
    return Intl.message('5min from you',
        name: 'studentUpToDateWalkDistance');
  }

  String get studentUpToDateEventHeader {
    return Intl.message('Beckman Institute Cafe',
        name: 'studentUpToDateEventHeader');
  }
  String get studentUpToDateEventContent {
    return Intl.message('Today launch special is Red Chicken Curry! The menu also features a made to order sandwich, hot soups, and fresh salds.',
        name: 'studentUpToDateEventContent');
  }

  String get studentUpToDateDrivingOptions {
    return Intl.message("Driving Options Nearby",
        name: 'studentUpToDateDrivingOptions');
  }

  String get studentUpToDateAssignedNext {
    return Intl.message('Assignments Due Next',
        name: 'studentUpToDateAssignedNext');
  }

  String get studentUpToDateButtonTodaySchedule {
    return Intl.message('Today\'s Schedule',
        name: 'studentUpToDateButtonTodaySchedule');
  }
  //common

  String get min {
    return Intl.message("min",
        name: 'min');
  }

  String get stateSucceeded {
    return Intl.message("Succeeded",
        name: 'stateSucceeded');
  }
  String get stateFailed {
    return Intl.message("Succeeded",
        name: 'stateFailed');
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
