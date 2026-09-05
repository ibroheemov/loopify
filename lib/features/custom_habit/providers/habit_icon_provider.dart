import 'package:betterloop/constants/general_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final habitIconProvider =
    StateProvider<IconData>((ref) => GeneralIcons.cameraAdd);
