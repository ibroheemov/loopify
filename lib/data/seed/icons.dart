import 'package:betterloop/features/custom_habit/models/icontype.dart';

class IconEntity {
  final String name;
  final List<String> category;
  final int id;

  const IconEntity({
    required this.name,
    required this.category,
    required this.id,
  });
}

final icons = [
  // POPULAR
  IconEntity(
    name: "sleepy-man-sitting-on-his-bed",
    category: [
      IconType.popular.value,
      IconType.lifeStyle.value,
    ],
    id: 1,
  ),
  IconEntity(
    name: "man-in-office-desk-with-computer",
    category: [
      IconType.popular.value,
      IconType.lifeStyle.value,
    ],
    id: 1,
  ),
  IconEntity(
    name: "wake-up-bed",
    category: [
      IconType.popular.value,
      IconType.lifeStyle.value,
      IconType.health.value,
    ],
    id: 1,
  ),
  IconEntity(
    name: "man-lying-sleeping-on-bed-while-alarm-clock-is-ringing",
    category: [
      IconType.popular.value,
      IconType.lifeStyle.value,
    ],
    id: 1,
  ),
  IconEntity(
    name: "resting-time-on-bed-for-body-recover-after-fitness",
    category: [
      IconType.popular.value,
      IconType.lifeStyle.value,
      IconType.health.value,
    ],
    id: 1,
  ),

  IconEntity(
    name: "arm-muscles",
    category: [
      IconType.popular.value,
      IconType.lifeStyle.value,
    ],
    id: 3,
  ),
  IconEntity(
    name: "book",
    category: [
      IconType.popular.value,
      IconType.lifeStyle.value,
      IconType.efficiency.value,
      IconType.hobby.value,
    ],
    id: 4,
  ),
  IconEntity(
    name: "idea-bulb",
    category: [
      IconType.popular.value,
      IconType.efficiency.value,
    ],
    id: 5,
  ),
  IconEntity(
    name: "meal-knife",
    category: [
      IconType.popular.value,
      IconType.diet.value,
    ],
    id: 6,
  ),
  IconEntity(
    name: "night-sleep",
    category: [
      IconType.popular.value,
      IconType.health.value,
    ],
    id: 7,
  ),
  IconEntity(
    name: "smile-face",
    category: [
      IconType.popular.value,
      IconType.efficiency.value,
      IconType.relationship.value,
    ],
    id: 8,
  ),
  IconEntity(
    name: "tree-decidious",
    category: [
      IconType.popular.value,
      IconType.lifeStyle.value,
    ],
    id: 9,
  ),
  IconEntity(
    name: "dollar-bag",
    category: [
      IconType.popular.value,
      IconType.lifeStyle.value,
    ],
    id: 10,
  ),
  IconEntity(
    name: "like",
    category: [
      IconType.popular.value,
      IconType.relationship.value,
    ],
    id: 11,
  ),
  IconEntity(
    name: "glass-of-water-with-drop",
    category: [
      IconType.popular.value,
      IconType.diet.value,
    ],
    id: 12,
  ),
  IconEntity(
    name: "dog-with-belt-walking-with-a-man",
    category: [
      IconType.popular.value,
      IconType.hobby.value,
      IconType.relationship.value,
    ],
    id: 13,
  ),
  IconEntity(
    name: "pencil",
    category: [
      IconType.popular.value,
      IconType.relationship.value,
    ],
    id: 14,
  ),
  IconEntity(
    name: "apple",
    category: [
      IconType.popular.value,
      IconType.diet.value,
    ],
    id: 15,
  ),
  IconEntity(
    name: "footstep",
    category: [IconType.popular.value],
    id: 16,
  ),
  // LIFESTYLE
  IconEntity(
    name: "stretching-exercises",
    category: [
      IconType.lifeStyle.value,
      IconType.health.value,
    ],
    id: 16,
  ),
  IconEntity(
    name: "refrigerator",
    category: [IconType.lifeStyle.value],
    id: 16,
  ),
  IconEntity(
    name: "trademil",
    category: [
      IconType.lifeStyle.value,
      IconType.health.value,
    ],
    id: 16,
  ),
  IconEntity(
    name: "fitness-pictogram",
    category: [
      IconType.lifeStyle.value,
      IconType.health.value,
    ],
    id: 16,
  ),
  IconEntity(
    name: "weightlifting",
    category: [
      IconType.lifeStyle.value,
      IconType.health.value,
    ],
    id: 16,
  ),
  IconEntity(
    name: "man-on-yoga-postur",
    category: [
      IconType.lifeStyle.value,
      IconType.health.value,
    ],
    id: 16,
  ),
  IconEntity(
    name: "jumping-rope",
    category: [
      IconType.lifeStyle.value,
      IconType.health.value,
    ],
    id: 16,
  ),
  IconEntity(
    name: "brush-with-toothpaste",
    category: [IconType.lifeStyle.value],
    id: 16,
  ),
  IconEntity(
    name: "swim",
    category: [
      IconType.lifeStyle.value,
      IconType.health.value,
    ],
    id: 16,
  ),
  IconEntity(
    name: "sun2",
    category: [IconType.lifeStyle.value],
    id: 16,
  ),
  IconEntity(
    name: "stars2",
    category: [IconType.lifeStyle.value],
    id: 16,
  ),
  IconEntity(
    name: "house",
    category: [IconType.lifeStyle.value],
    id: 16,
  ),
  IconEntity(
    name: "bed",
    category: [IconType.lifeStyle.value],
    id: 16,
  ),
  IconEntity(
    name: "images",
    category: [
      IconType.lifeStyle.value,
      IconType.efficiency.value,
    ],
    id: 16,
  ),
  IconEntity(
    name: "dishes",
    category: [
      IconType.lifeStyle.value,
      IconType.diet.value,
    ],
    id: 16,
  ),
  IconEntity(
    name: "running",
    category: [
      IconType.lifeStyle.value,
      IconType.negative.value,
      IconType.health.value,
    ],
    id: 16,
  ),
  IconEntity(
    name: "spray-bottle",
    category: [IconType.lifeStyle.value],
    id: 16,
  ),
  IconEntity(
    name: "leaf",
    category: [
      IconType.lifeStyle.value,
      IconType.hobby.value,
    ],
    id: 16,
  ),
  IconEntity(
    name: "trash-can",
    category: [
      IconType.lifeStyle.value,
      IconType.efficiency.value,
    ],
    id: 16,
  ),
  IconEntity(
    name: "wind",
    category: [
      IconType.lifeStyle.value,
      IconType.health.value,
    ],
    id: 16,
  ),
  IconEntity(
    name: "target",
    category: [
      IconType.lifeStyle.value,
      IconType.efficiency.value,
    ],
    id: 16,
  ),
  IconEntity(
    name: "sound",
    category: [IconType.lifeStyle.value],
    id: 16,
  ),
  IconEntity(
    name: "signal",
    category: [IconType.lifeStyle.value, IconType.hobby.value],
    id: 16,
  ),
  IconEntity(
    name: "internet-on-laptop-computer",
    category: [
      IconType.lifeStyle.value,
      IconType.efficiency.value,
    ],
    id: 16,
  ),
  IconEntity(
    name: "woman-sweeping",
    category: [IconType.lifeStyle.value],
    id: 16,
  ),
  IconEntity(
    name: "vacuum-cleaning",
    category: [IconType.lifeStyle.value],
    id: 16,
  ),
  IconEntity(
    name: "cleaning-clean-broom-housekeeping",
    category: [IconType.lifeStyle.value],
    id: 16,
  ),
  IconEntity(
    name: "monitor-with-text-svgrepo-com",
    category: [
      IconType.lifeStyle.value,
      IconType.efficiency.value,
    ],
    id: 16,
  ),
  IconEntity(
    name: "sleep-emoji",
    category: [IconType.lifeStyle.value],
    id: 16,
  ),
  IconEntity(
    name: "clock",
    category: [IconType.lifeStyle.value],
    id: 16,
  ),

  IconEntity(
    name: "dumbbell",
    category: [
      IconType.lifeStyle.value,
      IconType.health.value,
    ],
    id: 16,
  ),
  IconEntity(
    name: "car-wash",
    category: [IconType.lifeStyle.value],
    id: 16,
  ),
  IconEntity(
    name: "hand-wash",
    category: [IconType.lifeStyle.value],
    id: 16,
  ),
  IconEntity(
    name: "laundry",
    category: [IconType.lifeStyle.value],
    id: 16,
  ),
  IconEntity(
    name: "trash-collector",
    category: [IconType.lifeStyle.value],
    id: 16,
  ),
  IconEntity(
    name: "garbage-with-recycle-sign-overflowing-with-trash",
    category: [IconType.lifeStyle.value],
    id: 16,
  ),
  IconEntity(
    name: "car-wash-2",
    category: [IconType.lifeStyle.value],
    id: 16,
  ),
  // Negative
  IconEntity(
    name: "candy",
    category: [
      IconType.negative.value,
      IconType.health.value,
    ],
    id: 16,
  ),
  IconEntity(
    name: "smartphone-block",
    category: [IconType.negative.value],
    id: 16,
  ),
  IconEntity(
    name: "beer-stop",
    category: [
      IconType.negative.value,
      IconType.health.value,
    ],
    id: 16,
  ),
  IconEntity(
    name: "beer-limit",
    category: [
      IconType.negative.value,
      IconType.health.value,
    ],
    id: 16,
  ),
  IconEntity(
    name: "cake-stop",
    category: [
      IconType.negative.value,
      IconType.health.value,
    ],
    id: 16,
  ),
  IconEntity(
    name: "cake-limit",
    category: [
      IconType.negative.value,
      IconType.health.value,
    ],
    id: 16,
  ),
  IconEntity(
    name: "cigarette-stop",
    category: [
      IconType.negative.value,
      IconType.health.value,
    ],
    id: 16,
  ),
  IconEntity(
    name: "cigarette-limit",
    category: [
      IconType.negative.value,
      IconType.health.value,
    ],
    id: 16,
  ),
  IconEntity(
    name: "drink-can-soda",
    category: [
      IconType.negative.value,
      IconType.health.value,
      IconType.diet.value,
    ],
    id: 16,
  ),
  IconEntity(
    name: "eggs-limit",
    category: [
      IconType.negative.value,
      IconType.health.value,
    ],
    id: 16,
  ),
  IconEntity(
    name: "meat-slice",
    category: [
      IconType.negative.value,
      IconType.health.value,
      IconType.diet.value,
    ],
    id: 16,
  ),
  IconEntity(
    name: "id-card",
    category: [
      IconType.negative.value,
      IconType.relationship.value,
    ],
    id: 16,
  ),
  IconEntity(
    name: "close",
    category: [IconType.negative.value],
    id: 16,
  ),
  IconEntity(
    name: "moon-stop",
    category: [IconType.negative.value],
    id: 16,
  ),
  IconEntity(
    name: "heartbeat-stop",
    category: [IconType.negative.value],
    id: 16,
  ),
  IconEntity(
    name: "sad-suffering-crying-emoticon-stop",
    category: [
      IconType.negative.value,
      IconType.relationship.value,
    ],
    id: 16,
  ),
  IconEntity(
    name: "sad-emoticon-stop",
    category: [
      IconType.negative.value,
      IconType.relationship.value,
    ],
    id: 16,
  ),
  IconEntity(
    name: "meal-limit",
    category: [
      IconType.negative.value,
      IconType.health.value,
      IconType.diet.value,
    ],
    id: 16,
  ),
  IconEntity(
    name: "meal-give",
    category: [
      IconType.negative.value,
      IconType.diet.value,
    ],
    id: 16,
  ),
  IconEntity(
    name: "tea-coffee-limit",
    category: [
      IconType.negative.value,
      IconType.diet.value,
    ],
    id: 16,
  ),
  IconEntity(
    name: "candy-limit",
    category: [IconType.negative.value],
    id: 16,
  ),
  IconEntity(
    name: "milk-shake-drink-stop",
    category: [
      IconType.negative.value,
      IconType.diet.value,
    ],
    id: 16,
  ),
  IconEntity(
    name: "pacman-eat-stop",
    category: [
      IconType.negative.value,
      IconType.diet.value,
    ],
    id: 16,
  ),
  IconEntity(
    name: "gossip-stop-question",
    category: [
      IconType.negative.value,
      IconType.relationship.value,
    ],
    id: 16,
  ),
  IconEntity(
    name: "angry-man",
    category: [IconType.negative.value],
    id: 16,
  ),
  IconEntity(
    name: "angry-emoticon",
    category: [IconType.negative.value],
    id: 16,
  ),
  IconEntity(
    name: "trash-stop",
    category: [IconType.negative.value],
    id: 16,
  ),
  IconEntity(
    name: "scream-stop",
    category: [IconType.negative.value],
    id: 16,
  ),
  IconEntity(
    name: "scream-2-stop",
    category: [
      IconType.negative.value,
      IconType.relationship.value,
    ],
    id: 16,
  ),
  // Health--
  IconEntity(
    name: "person-exercise-heating-svgrepo-com",
    category: [IconType.health.value],
    id: 16,
  ),
  IconEntity(
    name: "exercise-svgrepo-com",
    category: [IconType.health.value],
    id: 16,
  ),
  IconEntity(
    name: "hiking-svgrepo-com",
    category: [IconType.health.value],
    id: 16,
  ),
  IconEntity(
    name: "weightlifting-svgrepo-com",
    category: [IconType.health.value],
    id: 16,
  ),
  IconEntity(
    name: "wash-hands-svgrepo-com",
    category: [IconType.health.value],
    id: 16,
  ),
  IconEntity(
    name: "stairs-svgrepo-com",
    category: [IconType.health.value],
    id: 16,
  ),
  IconEntity(
    name: "football-svgrepo-com",
    category: [
      IconType.health.value,
      IconType.hobby.value,
    ],
    id: 16,
  ),
  IconEntity(
    name: "doctor-svgrepo-com",
    category: [IconType.health.value],
    id: 16,
  ),
  IconEntity(
    name: "bicycle-svgrepo-com",
    category: [IconType.health.value],
    id: 16,
  ),
  IconEntity(
    name: "pill-solution-drug-pharmaceutical-svgrepo-com",
    category: [
      IconType.health.value,
      IconType.diet.value,
    ],
    id: 16,
  ),
  IconEntity(
    name: "temperature-list-svgrepo-com",
    category: [IconType.health.value],
    id: 16,
  ),
  IconEntity(
    name: "two-blood-drops-svgrepo-com",
    category: [
      IconType.health.value,
      IconType.diet.value,
    ],
    id: 16,
  ),
  IconEntity(
    name: "aid-svgrepo-com",
    category: [IconType.health.value],
    id: 16,
  ),
  IconEntity(
    name: "hand-and-water-drops-svgrepo-com",
    category: [IconType.health.value],
    id: 16,
  ),
  IconEntity(
    name: "heartbeat",
    category: [IconType.health.value],
    id: 16,
  ),
  IconEntity(
    name: "boxing-glove-pictogram-svgrepo-com",
    category: [IconType.health.value, IconType.hobby.value],
    id: 16,
  ),
  IconEntity(
    name: "floss-teeth",
    category: [IconType.health.value],
    id: 16,
  ),
  // Diet--
  IconEntity(
    name: "morning-daylight-meal",
    category: [IconType.diet.value],
    id: 16,
  ),
  IconEntity(
    name: "night-dinner-meal",
    category: [IconType.diet.value],
    id: 16,
  ),
  IconEntity(
    name: "pie-chart-stats-svgrepo-com",
    category: [IconType.diet.value],
    id: 16,
  ),
  IconEntity(
    name: "bread-svgrepo-com",
    category: [IconType.diet.value],
    id: 16,
  ),
  IconEntity(
    name: "meat-plus",
    category: [IconType.diet.value],
    id: 16,
  ),
  IconEntity(
    name: "avocado",
    category: [IconType.diet.value],
    id: 16,
  ),
  IconEntity(
    name: "eggs",
    category: [IconType.diet.value],
    id: 16,
  ),
  IconEntity(
    name: "salt-limit",
    category: [IconType.diet.value],
    id: 16,
  ),
  // Hobby--
  IconEntity(
    name: "camera-svgrepo-com",
    category: [IconType.hobby.value],
    id: 16,
  ),
  IconEntity(
    name: "video-play-button-svgrepo-com",
    category: [IconType.hobby.value],
    id: 16,
  ),
  IconEntity(
    name: "board-game",
    category: [IconType.hobby.value],
    id: 16,
  ),
  IconEntity(
    name: "cube-box-svgrepo-com",
    category: [IconType.hobby.value],
    id: 16,
  ),
  IconEntity(
    name: "luggage-svgrepo-com",
    category: [IconType.hobby.value],
    id: 16,
  ),

  IconEntity(
    name: "document-add-svgrepo-com",
    category: [
      IconType.hobby.value,
      IconType.efficiency.value,
    ],
    id: 16,
  ),
  IconEntity(
    name: "cat-svgrepo-com",
    category: [IconType.hobby.value],
    id: 16,
  ),
  IconEntity(
    name: "shirt-svgrepo-com",
    category: [IconType.hobby.value],
    id: 16,
  ),
  IconEntity(
    name: "plant-fill-svgrepo-com",
    category: [IconType.hobby.value],
    id: 16,
  ),
  IconEntity(
    name: "king-svgrepo-com",
    category: [
      IconType.hobby.value,
      IconType.efficiency.value,
    ],
    id: 16,
  ),
  IconEntity(
    name: "picture-image-svgrepo-com",
    category: [IconType.hobby.value],
    id: 16,
  ),
  IconEntity(
    name: "chemistry-lab-instrument-svgrepo-com",
    category: [IconType.hobby.value],
    id: 16,
  ),
  IconEntity(
    name: "shopping-card-svgrepo-com",
    category: [IconType.hobby.value],
    id: 16,
  ),
  IconEntity(
    name: "paint-brush-svgrepo-com",
    category: [
      IconType.hobby.value,
      IconType.efficiency.value,
    ],
    id: 16,
  ),
  IconEntity(
    name: "kitchen-pack-cook-svgrepo-com",
    category: [IconType.hobby.value],
    id: 16,
  ),
  IconEntity(
    name: "bath-1-svgrepo-com",
    category: [IconType.hobby.value],
    id: 16,
  ),
  IconEntity(
    name: "soccer-field-of-stadium-from-top-view-svgrepo-com",
    category: [IconType.hobby.value],
    id: 16,
  ),
  IconEntity(
    name: "chef-cooking-on-stove-svgrepo-com",
    category: [IconType.hobby.value],
    id: 16,
  ),
  IconEntity(
    name: "tasks-list-on-clipboard-svgrepo-com",
    category: [IconType.hobby.value],
    id: 16,
  ),
  // Efficiency--
  IconEntity(
    name: "calendar-time-near-deadline",
    category: [IconType.efficiency.value],
    id: 16,
  ),
  IconEntity(
    name: "calendar-time-one-third",
    category: [IconType.efficiency.value],
    id: 16,
  ),
  IconEntity(
    name: "calendar-edit-svgrepo-com",
    category: [IconType.efficiency.value],
    id: 16,
  ),
  IconEntity(
    name: "notebook-of-contacts-svgrepo-com",
    category: [
      IconType.efficiency.value,
      IconType.hobby.value,
    ],
    id: 16,
  ),
  IconEntity(
    name: "document-deadline-time",
    category: [IconType.efficiency.value],
    id: 16,
  ),
  IconEntity(
    name: "square-blocks",
    category: [IconType.efficiency.value],
    id: 16,
  ),
  IconEntity(
    name: "book-bookmark-minimalistic-svgrepo-com-edit",
    category: [IconType.efficiency.value],
    id: 16,
  ),
  IconEntity(
    name: "book-bookmark-svgrepo-com",
    category: [IconType.efficiency.value],
    id: 16,
  ),
  IconEntity(
    name: "lock-svgrepo-com",
    category: [IconType.efficiency.value],
    id: 16,
  ),
  IconEntity(
    name: "ring-bell-notifcation-off",
    category: [IconType.efficiency.value],
    id: 16,
  ),
  IconEntity(
    name: "complete-tasks",
    category: [IconType.efficiency.value],
    id: 16,
  ),
  IconEntity(
    name: "person-brain-network",
    category: [IconType.efficiency.value],
    id: 16,
  ),
  IconEntity(
    name: "brain-idea-generator",
    category: [IconType.efficiency.value],
    id: 16,
  ),
  IconEntity(
    name: "trash-svgrepo-com",
    category: [IconType.efficiency.value],
    id: 16,
  ),
  IconEntity(
    name: "folder-open-svgrepo-com",
    category: [IconType.efficiency.value],
    id: 16,
  ),
  IconEntity(
    name: "statistics-svgrepo-com",
    category: [IconType.efficiency.value],
    id: 16,
  ),
  IconEntity(
    name: "envelope-on-time",
    category: [IconType.efficiency.value],
    id: 16,
  ),
  IconEntity(
    name: "truck-fast-svgrepo-com",
    category: [IconType.efficiency.value],
    id: 16,
  ),
  IconEntity(
    name: "tshirt-t-shirt-recycle",
    category: [IconType.efficiency.value],
    id: 16,
  ),
  IconEntity(
    name: "conversation",
    category: [IconType.efficiency.value],
    id: 16,
  ),
  IconEntity(
    name: "shopping-cart-list",
    category: [IconType.efficiency.value],
    id: 16,
  ),
  IconEntity(
    name: "tasks-app-svgrepo-com",
    category: [IconType.efficiency.value],
    id: 16,
  ),
  IconEntity(
    name: "tasks-cog",
    category: [IconType.efficiency.value],
    id: 16,
  ),
  IconEntity(
    name: "answer-student-svgrepo-com",
    category: [IconType.efficiency.value],
    id: 16,
  ),
  // Relationship--
  IconEntity(
    name: "smile-to-people",
    category: [IconType.relationship.value],
    id: 16,
  ),
  IconEntity(
    name: "family-network",
    category: [IconType.relationship.value],
    id: 16,
  ),
  IconEntity(
    name: "meeting-consider-deliberate-about-meet",
    category: [IconType.relationship.value],
    id: 16,
  ),
  IconEntity(
    name: "person-speaking",
    category: [IconType.relationship.value],
    id: 16,
  ),
  IconEntity(
    name: "talk-success",
    category: [IconType.relationship.value],
    id: 16,
  ),
  IconEntity(
    name: "talk-conversation",
    category: [IconType.relationship.value],
    id: 16,
  ),
  IconEntity(
    name: "person-saying-i-love",
    category: [IconType.relationship.value],
    id: 16,
  ),
  IconEntity(
    name: "no-bug",
    category: [IconType.relationship.value],
    id: 16,
  ),
  IconEntity(
    name: "t-shirt-tshirt-relationship",
    category: [IconType.relationship.value],
    id: 16,
  ),
  IconEntity(
    name: "illustration-of-handshake-svgrepo-com",
    category: [IconType.relationship.value],
    id: 16,
  ),

  IconEntity(
    name: "write-envelope-letter",
    category: [IconType.relationship.value],
    id: 16,
  ),
  IconEntity(
    name: "gift-svgrepo-com",
    category: [IconType.relationship.value],
    id: 16,
  ),
  IconEntity(
    name: "small-duck-svgrepo-com",
    category: [IconType.relationship.value],
    id: 16,
  ),
  IconEntity(
    name: "syringe-svgrepo-com",
    category: [IconType.relationship.value],
    id: 16,
  ),
  IconEntity(
    name: "salt-pot-svgrepo-com",
    category: [IconType.relationship.value],
    id: 16,
  ),
  IconEntity(
    name: "document-svgrepo-com",
    category: [IconType.relationship.value],
    id: 16,
  ),
  IconEntity(
    name: "conversation-talk-typing-chat",
    category: [IconType.relationship.value],
    id: 16,
  ),

  IconEntity(
    name: "arrow-left-right-exchange",
    category: [IconType.relationship.value],
    id: 16,
  ),
  IconEntity(
    name: "hug-svgrepo-com",
    category: [IconType.relationship.value],
    id: 16,
  ),
  IconEntity(
    name: "no-chat-stop",
    category: [IconType.relationship.value],
    id: 16,
  ),
];
