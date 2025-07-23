import 'package:betterloop/models/goal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final goalProvider = StateProvider<Goal>((ref) => Goal.defaultGoal());
