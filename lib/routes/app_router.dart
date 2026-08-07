import 'package:betterloop/constants/general_icons.dart';
import 'package:betterloop/features/challenges/pages/challenge_details_screen.dart';
import 'package:betterloop/features/counter/counter_screen.dart';
import 'package:betterloop/features/custom_habit/custom_habit_screen.dart';
import 'package:betterloop/features/custom_habit/providers/goal_provider.dart';
import 'package:betterloop/features/custom_habit/providers/habit_icon_provider.dart';
import 'package:betterloop/features/custom_habit/providers/reminder_provider.dart';
import 'package:betterloop/features/custom_habit/providers/weekdays_provider.dart';
import 'package:betterloop/features/navigation_screen.dart';
import 'package:betterloop/features/onboarding/welcome_screen.dart';
import 'package:betterloop/features/paywall/paywall_screen.dart';
import 'package:betterloop/features/settings/pages/faqs_screen.dart';
import 'package:betterloop/features/settings/pages/policy_screen.dart';
import 'package:betterloop/features/settings/settings_screen.dart';
import 'package:betterloop/features/statistics/providers/current_habit_provider.dart';
import 'package:betterloop/features/statistics/statistics_screen.dart';
import 'package:betterloop/models/challenge.dart';
import 'package:betterloop/models/goal.dart';
import 'package:betterloop/models/habit.dart';
import 'package:betterloop/models/reminder.dart';
import 'package:betterloop/models/weekdays.dart';
import 'package:betterloop/routes/route_names.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../features/onboarding/onboarding_screen.dart';
import '../features/dashboard/dashboard_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;

    switch (settings.name) {
      case RouteNames.welcome:
        return MaterialPageRoute(builder: (_) => const WelcomeScreen());
      case RouteNames.onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case RouteNames.home:
        return MaterialPageRoute(
            builder: (_) => NavigationScreen(
                  fromOnboarding: arguments != null ? arguments as bool : false,
                ));
      case RouteNames.dashboard:
        return MaterialPageRoute(builder: (_) => const DashboardScreen());
      case RouteNames.policy:
        return MaterialPageRoute(builder: (_) => PolicyScreen());
      case RouteNames.faqs:
        return MaterialPageRoute(builder: (_) => FaqsScreen());
      case RouteNames.counter:
        return _createAnimatedRoute(CounterScreen(habit: arguments as Habit));
      case RouteNames.challenge:
        return _createAnimatedRoute(
            ChallengeDetailsScreen(challenge: arguments as Challenge));
      case RouteNames.customHabit:
        return _createAnimatedRoute(ProviderScope(
          overrides: [
            goalProvider.overrideWith((ref) => Goal.defaultGoal()),
            habitIconProvider.overrideWith((ref) => GeneralIcons.cameraAdd),
            reminderProvider.overrideWith((ref) => Reminder.defaultReminder()),
            weekdaysProvider.overrideWith((ref) => Weekdays.defaultWeekdays())
          ],
          child: CustomHabitScreen(habit: arguments as Habit?),
        ));
      case RouteNames.statistics:
        return _createAnimatedRoute(ProviderScope(
          overrides: [
            currentHabitProvider.overrideWith((ref) => null),
          ],
          child: StatisticsScreen(),
        ));
      case RouteNames.paywall:
        return _createAnimatedRoute(PaywallScreen());
      case RouteNames.settings:
        return _createAnimatedRoute(ProviderScope(
          child: SettingsScreen(),
        ));
      case "/sign_in":
        return MaterialPageRoute(
          builder: (context) {
            return SignInScreen(
              // providers: providers,
              actions: [
                AuthStateChangeAction<UserCreated>((context, state) {
                  // Put any new user logic here
                  // onSignedIn();
                }),
                AuthStateChangeAction<SignedIn>((context, state) {
                  // onSignedIn();
                  Navigator.pop(context, true);
                }),
              ],
            );
          },
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Page not found')),
          ),
        );
    }
  }
}

Route _createAnimatedRoute(Widget child) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(position: animation.drive(tween), child: child);
    },
  );
}
