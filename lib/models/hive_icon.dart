import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'hive_icon.g.dart';

@HiveType(typeId: 5)
class HiveIcon {
  @HiveField(0)
  final int code;

  @HiveField(1)
  final String? family;

  HiveIcon({required this.code, required this.family});

  // Icons are chosen dynamically by the user at runtime, so this can't be
  // const; that's also why the release build passes --no-tree-shake-icons.
  // ignore: non_const_argument_for_const_parameter
  IconData get toIconData => IconData(code, fontFamily: family);

  Map<String, dynamic> toJson() => {
        'code': code,
        'family': family,
      };

  factory HiveIcon.fromJson(Map<String, dynamic> json) {
    return HiveIcon(
      code: json['code'],
      family: json['family'],
    );
  }
}
