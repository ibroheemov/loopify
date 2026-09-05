import 'package:betterloop/models/icon_meta.dart';
import 'package:flutter/material.dart';

class LifeStyleIcons {
  LifeStyleIcons._();

  static const String _kFontFam = 'LifeStyleIcons';
  static const IconData womanSweeping = IconData(0xe900, fontFamily: _kFontFam);
  static const IconData vacuumCleaning =
      IconData(0xe901, fontFamily: _kFontFam);
  static const IconData laundry = IconData(0xe902, fontFamily: _kFontFam);
  static const IconData trashCollector =
      IconData(0xe903, fontFamily: _kFontFam);
  static const IconData trashCan = IconData(0xe904, fontFamily: _kFontFam);
  static const IconData trademil = IconData(0xe905, fontFamily: _kFontFam);
  static const IconData stretchingExercises =
      IconData(0xe906, fontFamily: _kFontFam);
  static const IconData weightlifting = IconData(0xe907, fontFamily: _kFontFam);
  static const IconData carWash = IconData(0xe908, fontFamily: _kFontFam);
  static const IconData fitnessPictogram =
      IconData(0xe909, fontFamily: _kFontFam);
  static const IconData running = IconData(0xe90a, fontFamily: _kFontFam);
  static const IconData brushWithToothpaste =
      IconData(0xe90b, fontFamily: _kFontFam);
  static const IconData book = IconData(0xe90c, fontFamily: _kFontFam);
  static const IconData sleepEmoji = IconData(0xe90d, fontFamily: _kFontFam);
  static const IconData cleaningCleanBroomHousekeeping =
      IconData(0xe90e, fontFamily: _kFontFam);
  static const IconData clock = IconData(0xe90f, fontFamily: _kFontFam);
  static const IconData handWash = IconData(0xe910, fontFamily: _kFontFam);
  static const IconData carWash2 = IconData(0xe911, fontFamily: _kFontFam);
  static const IconData monitorWithTextSvgrepoCom =
      IconData(0xe912, fontFamily: _kFontFam);
  static const IconData bed = IconData(0xe913, fontFamily: _kFontFam);
  static const IconData dishes = IconData(0xe914, fontFamily: _kFontFam);
  static const IconData dumbbell = IconData(0xe915, fontFamily: _kFontFam);
  static const IconData garbageWithRecycleSignOverflowingWithTrash =
      IconData(0xe916, fontFamily: _kFontFam);
  static const IconData house = IconData(0xe917, fontFamily: _kFontFam);
  static const IconData images = IconData(0xe918, fontFamily: _kFontFam);
  static const IconData internetOnLaptopComputer =
      IconData(0xe919, fontFamily: _kFontFam);
  static const IconData jumpingRope = IconData(0xe91a, fontFamily: _kFontFam);
  static const IconData leaf = IconData(0xe91b, fontFamily: _kFontFam);
  static const IconData refrigerator = IconData(0xe91c, fontFamily: _kFontFam);
  static const IconData sprayBottle = IconData(0xe91d, fontFamily: _kFontFam);
  static const IconData stars2 = IconData(0xe91e, fontFamily: _kFontFam);
  static const IconData sun2 = IconData(0xe91f, fontFamily: _kFontFam);
  static const IconData target = IconData(0xe920, fontFamily: _kFontFam);
  static const IconData wind = IconData(0xe921, fontFamily: _kFontFam);

  static final List<IconMeta> iconMetaList = [
    IconMeta(womanSweeping, 'woman_sweeping',
        ['cleaning', 'chores', 'sweep', 'housework']),
    IconMeta(vacuumCleaning, 'vacuum_cleaning',
        ['cleaning', 'vacuum', 'dust', 'housekeeping']),
    IconMeta(laundry, 'laundry', ['clothes', 'wash', 'housework', 'laundry']),
    IconMeta(trashCollector, 'trash_collector',
        ['garbage', 'cleaning', 'collection', 'worker']),
    IconMeta(trashCan, 'trash_can', ['bin', 'garbage', 'waste', 'can']),
    IconMeta(
        trademil, 'trademil', ['treadmill', 'exercise', 'fitness', 'cardio']),
    // If you renamed the constant to `treadmill`, use:
    // IconMeta(treadmill, 'trademil', ['treadmill', 'exercise', 'fitness', 'cardio']),
    IconMeta(stretchingExercises, 'stretching_exercises',
        ['stretch', 'fitness', 'yoga', 'exercise']),
    IconMeta(weightlifting, 'weightlifting',
        ['weights', 'gym', 'fitness', 'strength']),
    IconMeta(carWash, 'car_wash', ['vehicle', 'cleaning', 'car', 'wash']),
    IconMeta(fitnessPictogram, 'fitness_pictogram',
        ['fitness', 'health', 'exercise', 'active']),
    IconMeta(running, 'running', ['jogging', 'fitness', 'cardio', 'health']),
    IconMeta(brushWithToothpaste, 'brush_with_toothpaste',
        ['toothbrush', 'hygiene', 'teeth', 'morning routine']),
    IconMeta(book, 'book', ['read', 'education', 'study', 'knowledge']),
    IconMeta(sleepEmoji, 'sleep_emoji', ['sleep', 'emoji', 'rest', 'tired']),
    IconMeta(
        cleaningCleanBroomHousekeeping,
        'cleaning_clean_broom_housekeeping',
        ['cleaning', 'broom', 'housekeeping', 'chores']),
    IconMeta(clock, 'clock', ['time', 'schedule', 'alarm', 'reminder']),
    IconMeta(handWash, 'hand_wash', ['hygiene', 'wash', 'clean', 'health']),
    IconMeta(carWash2, 'car_wash_2', ['car', 'wash', 'vehicle', 'clean']),
    IconMeta(monitorWithTextSvgrepoCom, 'monitor_with_text_svgrepo_com',
        ['computer', 'monitor', 'text', 'screen']),
    IconMeta(bed, 'bed', ['sleep', 'rest', 'furniture', 'bedroom']),
    IconMeta(dishes, 'dishes', ['kitchen', 'cleaning', 'plates', 'chores']),
    IconMeta(dumbbell, 'dumbbell', ['fitness', 'weights', 'gym', 'strength']),
    IconMeta(
        garbageWithRecycleSignOverflowingWithTrash,
        'garbage_with_recycle_sign_overflowing_with_trash',
        ['recycle', 'trash', 'overflowing', 'bin']),
    IconMeta(house, 'house', ['home', 'building', 'residence', 'shelter']),
    IconMeta(images, 'images', ['photos', 'gallery', 'media', 'pictures']),
    IconMeta(internetOnLaptopComputer, 'internet_on_laptop_computer',
        ['internet', 'laptop', 'online', 'technology']),
    IconMeta(
        jumpingRope, 'jumping_rope', ['fitness', 'cardio', 'rope', 'exercise']),
    IconMeta(leaf, 'leaf', ['nature', 'plant', 'eco', 'green']),
    IconMeta(refrigerator, 'refrigerator',
        ['fridge', 'kitchen', 'food', 'appliance']),
    IconMeta(sprayBottle, 'spray_bottle',
        ['cleaning', 'spray', 'liquid', 'disinfect']),
    IconMeta(stars2, 'stars2', ['stars', 'night', 'sky', 'shine']),
    IconMeta(sun2, 'sun2', ['sun', 'weather', 'daylight', 'energy']),
    IconMeta(target, 'target', ['goal', 'focus', 'objective', 'achievement']),
    IconMeta(wind, 'wind', ['air', 'breeze', 'nature', 'climate']),
  ];
}
