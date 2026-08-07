import 'package:betterloop/models/icon_meta.dart';
import 'package:flutter/widgets.dart';

class PopularIcons {
  PopularIcons._();

  static const String _kFontFam = 'PopularIcons';

  static const IconData personWalkingSolid =
      IconData(0xe905, fontFamily: _kFontFam);
  static const IconData dogWithBeltWalkingWithAMan =
      IconData(0xe906, fontFamily: _kFontFam);
  static const IconData glassOfWaterWithDrop =
      IconData(0xe907, fontFamily: _kFontFam);
  static const IconData restingTimeOnBedForBodyRecoverAfterFitness =
      IconData(0xe908, fontFamily: _kFontFam);
  static const IconData mealKnife = IconData(0xe909, fontFamily: _kFontFam);
  static const IconData nightSleep = IconData(0xe90a, fontFamily: _kFontFam);
  static const IconData manInOfficeDeskWithComputer =
      IconData(0xe90b, fontFamily: _kFontFam);
  static const IconData wakeUpBed = IconData(0xe90c, fontFamily: _kFontFam);
  static const IconData manLyingSleepingOnBedWhileAlarmClockIsRinging =
      IconData(0xe90d, fontFamily: _kFontFam);
  static const IconData footstep = IconData(0xe90e, fontFamily: _kFontFam);
  static const IconData apple = IconData(0xe90f, fontFamily: _kFontFam);
  static const IconData armMuscles = IconData(0xe910, fontFamily: _kFontFam);
  static const IconData dollarBag = IconData(0xe911, fontFamily: _kFontFam);
  static const IconData like = IconData(0xe913, fontFamily: _kFontFam);
  static const IconData smileFace = IconData(0xe914, fontFamily: _kFontFam);
  static const IconData treeDecidious = IconData(0xe915, fontFamily: _kFontFam);
  static const IconData sleepyManSittingOnHisBed =
      IconData(0xe916, fontFamily: _kFontFam);

  static final List<IconMeta> iconMetaList = [
    IconMeta(personWalkingSolid, 'person_walking_solid',
        ['walk', 'exercise', 'movement', 'activity']),
    IconMeta(dogWithBeltWalkingWithAMan, 'dog_with_belt_walking_with_a_man',
        ['pet', 'dog', 'walk', 'leash', 'companion']),
    IconMeta(glassOfWaterWithDrop, 'glass_of_water_with_drop',
        ['drink', 'hydration', 'water', 'health']),
    IconMeta(
        restingTimeOnBedForBodyRecoverAfterFitness,
        'resting_time_on_bed_for_body_recover_after_fitness',
        ['rest', 'recovery', 'fitness', 'sleep', 'bed']),
    IconMeta(
        mealKnife, 'meal_knife', ['meal', 'food', 'eat', 'cutlery', 'dining']),
    IconMeta(nightSleep, 'night_sleep', ['sleep', 'night', 'rest', 'bedtime']),
    IconMeta(manInOfficeDeskWithComputer, 'man_in_office_desk_with_computer',
        ['work', 'office', 'computer', 'desk', 'job']),
    IconMeta(wakeUpBed, 'wake_up_bed',
        ['wake', 'morning', 'alarm', 'bed', 'routine']),
    IconMeta(
        manLyingSleepingOnBedWhileAlarmClockIsRinging,
        'man_lying_sleeping_on_bed_while_alarm_clock_is_ringing',
        ['alarm', 'sleep', 'wake', 'bed', 'late']),
    IconMeta(footstep, 'footstep', ['step', 'walk', 'movement', 'track']),
    IconMeta(apple, 'apple', ['fruit', 'food', 'health', 'snack', 'nutrition']),
    IconMeta(armMuscles, 'arm_muscles',
        ['muscle', 'strength', 'fitness', 'gym', 'training']),
    IconMeta(dollarBag, 'dollar_bag',
        ['money', 'finance', 'budget', 'cash', 'wealth']),
    IconMeta(like, 'like', ['like', 'thumbs up', 'approve', 'favorite']),
    IconMeta(smileFace, 'smile_face',
        ['happy', 'smile', 'face', 'emotion', 'positive']),
    IconMeta(treeDecidious, 'tree_decidious',
        ['tree', 'nature', 'environment', 'leaf', 'green']),
    IconMeta(sleepyManSittingOnHisBed, 'sleepy_man_sitting_on_his_bed',
        ['sleepy', 'morning', 'bed', 'tired', 'fatigue']),
  ];
}
