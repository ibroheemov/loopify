import 'package:betterloop/models/icon_meta.dart';
import 'package:flutter/material.dart';

class DietIcons {
  DietIcons._();

  static const String _kFontFam = 'DietIcons';

  static const IconData tea_coffee_limit =
      IconData(0xe900, fontFamily: _kFontFam);
  static const IconData bread_svgrepo_com =
      IconData(0xe901, fontFamily: _kFontFam);
  static const IconData meat_plus = IconData(0xe902, fontFamily: _kFontFam);
  static const IconData avocado = IconData(0xe903, fontFamily: _kFontFam);
  static const IconData morning_daylight_meal =
      IconData(0xe904, fontFamily: _kFontFam);
  static const IconData night_dinner_meal =
      IconData(0xe905, fontFamily: _kFontFam);
  static const IconData meal_give = IconData(0xe906, fontFamily: _kFontFam);
  static const IconData pie_chart_stats_svgrepo_com =
      IconData(0xe907, fontFamily: _kFontFam);

  static final List<IconMeta> iconMetaList = [
    IconMeta(tea_coffee_limit, 'tea_coffee_limit',
        ['limit', 'tea', 'coffee', 'caffeine', 'diet']),
    IconMeta(bread_svgrepo_com, 'bread_svgrepo_com',
        ['bread', 'carbs', 'grains', 'food', 'diet']),
    IconMeta(meat_plus, 'meat_plus',
        ['meat', 'protein', 'food', 'diet', 'increase']),
    IconMeta(avocado, 'avocado',
        ['avocado', 'healthy fat', 'fruit', 'nutrition', 'diet']),
    IconMeta(morning_daylight_meal, 'morning_daylight_meal',
        ['breakfast', 'morning', 'meal', 'daylight', 'diet']),
    IconMeta(night_dinner_meal, 'night_dinner_meal',
        ['dinner', 'night', 'meal', 'diet', 'nutrition']),
    IconMeta(meal_give, 'meal_give',
        ['meal', 'share', 'donation', 'food', 'giving']),
    IconMeta(pie_chart_stats_svgrepo_com, 'pie_chart_stats_svgrepo_com',
        ['chart', 'stats', 'calories', 'nutrition', 'macro tracking']),
  ];
}
