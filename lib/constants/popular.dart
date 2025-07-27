import 'package:betterloop/models/icon_meta.dart';
import 'package:flutter/widgets.dart';

class PopularIcons {
  PopularIcons._();

  static const String _kFontFam = 'PopularIcons';

  static const IconData person_walking_solid =
      IconData(0xe905, fontFamily: _kFontFam);
  static const IconData dog_with_belt_walking_with_a_man =
      IconData(0xe906, fontFamily: _kFontFam);
  static const IconData glass_of_water_with_drop =
      IconData(0xe907, fontFamily: _kFontFam);
  static const IconData resting_time_on_bed_for_body_recover_after_fitness =
      IconData(0xe908, fontFamily: _kFontFam);
  static const IconData meal_knife = IconData(0xe909, fontFamily: _kFontFam);
  static const IconData night_sleep = IconData(0xe90a, fontFamily: _kFontFam);
  static const IconData man_in_office_desk_with_computer =
      IconData(0xe90b, fontFamily: _kFontFam);
  static const IconData wake_up_bed = IconData(0xe90c, fontFamily: _kFontFam);
  static const IconData man_lying_sleeping_on_bed_while_alarm_clock_is_ringing =
      IconData(0xe90d, fontFamily: _kFontFam);
  static const IconData footstep = IconData(0xe90e, fontFamily: _kFontFam);
  static const IconData apple = IconData(0xe90f, fontFamily: _kFontFam);
  static const IconData arm_muscles = IconData(0xe910, fontFamily: _kFontFam);
  static const IconData dollar_bag = IconData(0xe911, fontFamily: _kFontFam);
  static const IconData like = IconData(0xe913, fontFamily: _kFontFam);
  static const IconData smile_face = IconData(0xe914, fontFamily: _kFontFam);
  static const IconData tree_decidious =
      IconData(0xe915, fontFamily: _kFontFam);
  static const IconData sleepy_man_sitting_on_his_bed =
      IconData(0xe916, fontFamily: _kFontFam);

  static final List<IconMeta> iconMetaList = [
    IconMeta(person_walking_solid, 'person_walking_solid',
        ['walk', 'exercise', 'movement', 'activity']),
    IconMeta(
        dog_with_belt_walking_with_a_man,
        'dog_with_belt_walking_with_a_man',
        ['pet', 'dog', 'walk', 'leash', 'companion']),
    IconMeta(glass_of_water_with_drop, 'glass_of_water_with_drop',
        ['drink', 'hydration', 'water', 'health']),
    IconMeta(
        resting_time_on_bed_for_body_recover_after_fitness,
        'resting_time_on_bed_for_body_recover_after_fitness',
        ['rest', 'recovery', 'fitness', 'sleep', 'bed']),
    IconMeta(
        meal_knife, 'meal_knife', ['meal', 'food', 'eat', 'cutlery', 'dining']),
    IconMeta(night_sleep, 'night_sleep', ['sleep', 'night', 'rest', 'bedtime']),
    IconMeta(
        man_in_office_desk_with_computer,
        'man_in_office_desk_with_computer',
        ['work', 'office', 'computer', 'desk', 'job']),
    IconMeta(wake_up_bed, 'wake_up_bed',
        ['wake', 'morning', 'alarm', 'bed', 'routine']),
    IconMeta(
        man_lying_sleeping_on_bed_while_alarm_clock_is_ringing,
        'man_lying_sleeping_on_bed_while_alarm_clock_is_ringing',
        ['alarm', 'sleep', 'wake', 'bed', 'late']),
    IconMeta(footstep, 'footstep', ['step', 'walk', 'movement', 'track']),
    IconMeta(apple, 'apple', ['fruit', 'food', 'health', 'snack', 'nutrition']),
    IconMeta(arm_muscles, 'arm_muscles',
        ['muscle', 'strength', 'fitness', 'gym', 'training']),
    IconMeta(dollar_bag, 'dollar_bag',
        ['money', 'finance', 'budget', 'cash', 'wealth']),
    IconMeta(like, 'like', ['like', 'thumbs up', 'approve', 'favorite']),
    IconMeta(smile_face, 'smile_face',
        ['happy', 'smile', 'face', 'emotion', 'positive']),
    IconMeta(tree_decidious, 'tree_decidious',
        ['tree', 'nature', 'environment', 'leaf', 'green']),
    IconMeta(sleepy_man_sitting_on_his_bed, 'sleepy_man_sitting_on_his_bed',
        ['sleepy', 'morning', 'bed', 'tired', 'fatigue']),
  ];
}
