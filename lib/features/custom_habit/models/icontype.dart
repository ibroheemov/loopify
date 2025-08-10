import 'package:betterloop/constants/diet_icons.dart';
import 'package:betterloop/constants/efficiency_icons.dart';
import 'package:betterloop/constants/health_icons.dart';
import 'package:betterloop/constants/hobby_icons.dart';
import 'package:betterloop/constants/lifestyle_icons.dart';
import 'package:betterloop/constants/negative_icons.dart';
import 'package:betterloop/constants/popular.dart';
import 'package:betterloop/constants/random_icons.dart';
import 'package:betterloop/constants/relationship_icons.dart';
import 'package:betterloop/models/icon_meta.dart';

enum IconType {
  popular('popular'),
  lifeStyle('lifeStyle'),
  random('random'),
  health('health'),
  diet('diet'),
  negative('negative'),
  hobby('hobby'),
  efficiency('efficiency'),
  relationship('relationship');

  final String value;

  const IconType(this.value);

  static List<IconMeta> iconMetaList(String value) {
    switch (value) {
      case 'popular':
        return PopularIcons.iconMetaList;
      case 'random':
        return RandomIcons.iconMetaList;
      case 'lifeStyle':
        return LifeStyleIcons.iconMetaList;
      case 'health':
        return HealthIcons.iconMetaList;
      case 'diet':
        return DietIcons.iconMetaList;
      case 'hobby':
        return HobbyIcons.iconMetaList;
      case 'negative':
        return NegativeIcons.iconMetaList;
      case 'efficiency':
        return EffeciencyIcons.iconMetaList;
      case 'relationship':
        return RelationshipIcons.iconMetaList;
      default:
        return PopularIcons.iconMetaList;
    }
  }
}
