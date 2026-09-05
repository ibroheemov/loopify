import 'package:betterloop/models/icon_meta.dart';
import 'package:flutter/material.dart';

class HealthIcons {
  HealthIcons._();

  static const String _kFontFam = 'HealthIcons';
  static const IconData bicycleSvgrepoCom =
      IconData(0xe900, fontFamily: _kFontFam);
  static const IconData handAndWaterDropsSvgrepoCom =
      IconData(0xe901, fontFamily: _kFontFam);
  static const IconData flossTeeth = IconData(0xe902, fontFamily: _kFontFam);
  static const IconData hikingSvgrepoCom =
      IconData(0xe903, fontFamily: _kFontFam);
  static const IconData stairsSvgrepoCom =
      IconData(0xe904, fontFamily: _kFontFam);
  static const IconData footballSvgrepoCom =
      IconData(0xe905, fontFamily: _kFontFam);
  static const IconData exerciseSvgrepoCom =
      IconData(0xe906, fontFamily: _kFontFam);
  static const IconData personExerciseHeatingSvgrepoCom =
      IconData(0xe907, fontFamily: _kFontFam);
  static const IconData weightliftingSvgrepoCom =
      IconData(0xe908, fontFamily: _kFontFam);
  static const IconData aidSvgrepoCom = IconData(0xe909, fontFamily: _kFontFam);
  static const IconData boxingGlovePictogramSvgrepoCom =
      IconData(0xe90a, fontFamily: _kFontFam);
  static const IconData doctorSvgrepoCom =
      IconData(0xe90b, fontFamily: _kFontFam);
  static const IconData washHandsSvgrepoCom =
      IconData(0xe90c, fontFamily: _kFontFam);
  static const IconData eggsLimit = IconData(0xe90d, fontFamily: _kFontFam);
  static const IconData eggs = IconData(0xe90e, fontFamily: _kFontFam);
  static const IconData heartbeat = IconData(0xe90f, fontFamily: _kFontFam);
  static const IconData twoBloodDropsSvgrepoCom =
      IconData(0xe910, fontFamily: _kFontFam);

  static final List<IconMeta> iconMetaList = [
    IconMeta(bicycleSvgrepoCom, 'bicycle_svgrepo_com',
        ['bicycle', 'cycling', 'cardio', 'transport', 'exercise']),
    IconMeta(handAndWaterDropsSvgrepoCom, 'hand_and_water_drops_svgrepo_com',
        ['hand wash', 'hygiene', 'water', 'clean']),
    IconMeta(flossTeeth, 'floss_teeth',
        ['floss', 'teeth', 'dental', 'hygiene', 'mouth']),
    IconMeta(hikingSvgrepoCom, 'hiking_svgrepo_com',
        ['hiking', 'trail', 'outdoors', 'exercise', 'nature']),
    IconMeta(stairsSvgrepoCom, 'stairs_svgrepo_com',
        ['stairs', 'step', 'climb', 'fitness', 'movement']),
    IconMeta(footballSvgrepoCom, 'football_svgrepo_com',
        ['football', 'sports', 'team', 'soccer', 'play']),
    IconMeta(exerciseSvgrepoCom, 'exercise_svgrepo_com',
        ['exercise', 'workout', 'movement', 'fitness']),
    IconMeta(
        personExerciseHeatingSvgrepoCom,
        'person_exercise_heating_svgrepo_com',
        ['warmup', 'stretch', 'fitness', 'heat', 'exercise']),
    IconMeta(weightliftingSvgrepoCom, 'weightlifting_svgrepo_com',
        ['weights', 'gym', 'strength', 'lift', 'fitness']),
    IconMeta(aidSvgrepoCom, 'aid_svgrepo_com',
        ['first aid', 'medical', 'emergency', 'health', 'kit']),
    IconMeta(
        boxingGlovePictogramSvgrepoCom,
        'boxing_glove_pictogram_svgrepo_com',
        ['boxing', 'sports', 'glove', 'fight', 'training']),
    IconMeta(doctorSvgrepoCom, 'doctor_svgrepo_com',
        ['doctor', 'medical', 'health', 'checkup', 'hospital']),
    IconMeta(washHandsSvgrepoCom, 'wash_hands_svgrepo_com',
        ['hand wash', 'clean', 'hygiene', 'health']),
    IconMeta(eggsLimit, 'eggs_limit',
        ['diet', 'eggs', 'limit', 'cholesterol', 'nutrition']),
    IconMeta(eggs, 'eggs', ['eggs', 'food', 'protein', 'nutrition', 'meal']),
    IconMeta(heartbeat, 'heartbeat',
        ['heart', 'beat', 'health', 'pulse', 'monitor']),
    IconMeta(twoBloodDropsSvgrepoCom, 'two_blood_drops_svgrepo_com',
        ['blood', 'donation', 'health', 'drop']),
  ];
}
