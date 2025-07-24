import 'dart:math';

class HabitNotificationTemplates {
  static final List<NotificationTemplate> _templates = [
    NotificationTemplate(title: 'Stay on track!', body: 'Time to do: {title}'),
    NotificationTemplate(
        title: '{title} reminder', body: 'Keep going — you’ve got this!'),
    NotificationTemplate(
        title: 'Don’t forget {title}', body: 'Small steps = big wins'),
  ];

  static NotificationTemplate getRandomTemplate(String habitTitle) {
    final template = _templates[_random.nextInt(_templates.length)];
    return NotificationTemplate(
      title: template.title.replaceAll('{title}', habitTitle),
      body: template.body.replaceAll('{title}', habitTitle),
    );
  }

  static final _random = Random();
}

class NotificationTemplate {
  final String title;
  final String body;

  NotificationTemplate({required this.title, required this.body});
}
