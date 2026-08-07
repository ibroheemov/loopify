import 'package:betterloop/models/icon_meta.dart';
import 'package:flutter/material.dart';

class DietIcons {
  DietIcons._();

  static const String _kFontFam = 'DietIcons';

  static const IconData teaCoffeeLimit =
      IconData(0xe900, fontFamily: _kFontFam);
  static const IconData breadSvgrepoCom =
      IconData(0xe901, fontFamily: _kFontFam);
  static const IconData meatPlus = IconData(0xe902, fontFamily: _kFontFam);
  static const IconData avocado = IconData(0xe903, fontFamily: _kFontFam);
  static const IconData morningDaylightMeal =
      IconData(0xe904, fontFamily: _kFontFam);
  static const IconData nightDinnerMeal =
      IconData(0xe905, fontFamily: _kFontFam);
  static const IconData mealGive = IconData(0xe906, fontFamily: _kFontFam);
  static const IconData pieChartStatsSvgrepoCom =
      IconData(0xe907, fontFamily: _kFontFam);

  static final List<IconMeta> iconMetaList = [
    IconMeta(teaCoffeeLimit, 'tea_coffee_limit',
        ['limit', 'tea', 'coffee', 'caffeine', 'diet']),
    IconMeta(breadSvgrepoCom, 'bread_svgrepo_com',
        ['bread', 'carbs', 'grains', 'food', 'diet']),
    IconMeta(
        meatPlus, 'meat_plus', ['meat', 'protein', 'food', 'diet', 'increase']),
    IconMeta(avocado, 'avocado',
        ['avocado', 'healthy fat', 'fruit', 'nutrition', 'diet']),
    IconMeta(morningDaylightMeal, 'morning_daylight_meal',
        ['breakfast', 'morning', 'meal', 'daylight', 'diet']),
    IconMeta(nightDinnerMeal, 'night_dinner_meal',
        ['dinner', 'night', 'meal', 'diet', 'nutrition']),
    IconMeta(
        mealGive, 'meal_give', ['meal', 'share', 'donation', 'food', 'giving']),
    IconMeta(pieChartStatsSvgrepoCom, 'pie_chart_stats_svgrepo_com',
        ['chart', 'stats', 'calories', 'nutrition', 'macro tracking']),
  ];
}
