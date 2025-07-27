import 'package:betterloop/models/icon_meta.dart';
import 'package:flutter/material.dart';

class HealthIcons {
  HealthIcons._();

  static const String _kFontFam = 'HealthIcons';

  static const IconData bicycle_svgrepo_com =
      IconData(0xe900, fontFamily: _kFontFam);
  static const IconData hand_and_water_drops_svgrepo_com =
      IconData(0xe901, fontFamily: _kFontFam);
  static const IconData floss_teeth = IconData(0xe902, fontFamily: _kFontFam);
  static const IconData hiking_svgrepo_com =
      IconData(0xe903, fontFamily: _kFontFam);
  static const IconData stairs_svgrepo_com =
      IconData(0xe904, fontFamily: _kFontFam);
  static const IconData football_svgrepo_com =
      IconData(0xe905, fontFamily: _kFontFam);
  static const IconData exercise_svgrepo_com =
      IconData(0xe906, fontFamily: _kFontFam);
  static const IconData person_exercise_heating_svgrepo_com =
      IconData(0xe907, fontFamily: _kFontFam);
  static const IconData weightlifting_svgrepo_com =
      IconData(0xe908, fontFamily: _kFontFam);
  static const IconData aid_svgrepo_com =
      IconData(0xe909, fontFamily: _kFontFam);
  static const IconData boxing_glove_pictogram_svgrepo_com =
      IconData(0xe90a, fontFamily: _kFontFam);
  static const IconData doctor_svgrepo_com =
      IconData(0xe90b, fontFamily: _kFontFam);
  static const IconData wash_hands_svgrepo_com =
      IconData(0xe90c, fontFamily: _kFontFam);
  static const IconData eggs_limit = IconData(0xe90d, fontFamily: _kFontFam);
  static const IconData eggs = IconData(0xe90e, fontFamily: _kFontFam);
  static const IconData heartbeat = IconData(0xe90f, fontFamily: _kFontFam);
  static const IconData two_blood_drops_svgrepo_com =
      IconData(0xe910, fontFamily: _kFontFam);

  static final List<IconMeta> iconMetaList = [
    IconMeta(bicycle_svgrepo_com, 'bicycle_svgrepo_com',
        ['bicycle', 'cycling', 'cardio', 'transport', 'exercise']),
    IconMeta(
        hand_and_water_drops_svgrepo_com,
        'hand_and_water_drops_svgrepo_com',
        ['hand wash', 'hygiene', 'water', 'clean']),
    IconMeta(floss_teeth, 'floss_teeth',
        ['floss', 'teeth', 'dental', 'hygiene', 'mouth']),
    IconMeta(hiking_svgrepo_com, 'hiking_svgrepo_com',
        ['hiking', 'trail', 'outdoors', 'exercise', 'nature']),
    IconMeta(stairs_svgrepo_com, 'stairs_svgrepo_com',
        ['stairs', 'step', 'climb', 'fitness', 'movement']),
    IconMeta(football_svgrepo_com, 'football_svgrepo_com',
        ['football', 'sports', 'team', 'soccer', 'play']),
    IconMeta(exercise_svgrepo_com, 'exercise_svgrepo_com',
        ['exercise', 'workout', 'movement', 'fitness']),
    IconMeta(
        person_exercise_heating_svgrepo_com,
        'person_exercise_heating_svgrepo_com',
        ['warmup', 'stretch', 'fitness', 'heat', 'exercise']),
    IconMeta(weightlifting_svgrepo_com, 'weightlifting_svgrepo_com',
        ['weights', 'gym', 'strength', 'lift', 'fitness']),
    IconMeta(aid_svgrepo_com, 'aid_svgrepo_com',
        ['first aid', 'medical', 'emergency', 'health', 'kit']),
    IconMeta(
        boxing_glove_pictogram_svgrepo_com,
        'boxing_glove_pictogram_svgrepo_com',
        ['boxing', 'sports', 'glove', 'fight', 'training']),
    IconMeta(doctor_svgrepo_com, 'doctor_svgrepo_com',
        ['doctor', 'medical', 'health', 'checkup', 'hospital']),
    IconMeta(wash_hands_svgrepo_com, 'wash_hands_svgrepo_com',
        ['hand wash', 'clean', 'hygiene', 'health']),
    IconMeta(eggs_limit, 'eggs_limit',
        ['diet', 'eggs', 'limit', 'cholesterol', 'nutrition']),
    IconMeta(eggs, 'eggs', ['eggs', 'food', 'protein', 'nutrition', 'meal']),
    IconMeta(heartbeat, 'heartbeat',
        ['heart', 'beat', 'health', 'pulse', 'monitor']),
    IconMeta(two_blood_drops_svgrepo_com, 'two_blood_drops_svgrepo_com',
        ['blood', 'donation', 'health', 'drop']),
  ];
}
