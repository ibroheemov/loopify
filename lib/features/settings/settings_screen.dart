import 'package:betterloop/constants/general_icons.dart';
import 'package:betterloop/features/settings/providers/backup_notifier.dart';
import 'package:betterloop/features/settings/widgets/choose_themes.dart';
import 'package:betterloop/features/settings/widgets/last_backup_time.dart';
import 'package:betterloop/features/settings/widgets/reasons_to_upgrade.dart';
import 'package:betterloop/features/settings/widgets/single_setting_container.dart';
import 'package:betterloop/providers/pro_user_provider.dart';
import 'package:betterloop/routes/route_names.dart';
import 'package:betterloop/theme/spacing.dart';
import 'package:betterloop/widgets/app_card.dart';
import 'package:betterloop/widgets/bottomsheet_wrapper.dart';
import 'package:betterloop/widgets/separator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers/last_backup_time_provider.dart';
import 'providers/restore_notifier.dart';
import 'widgets/app_info_section.dart';
import 'widgets/support_section.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  void listenForNotifier() {
    ref.listen<AsyncValue<void>>(restoreNotifierProvider, (prev, next) {
      final notifier = ref.read(restoreNotifierProvider.notifier);
      if (!notifier.hasTriggeredRestore) return;

      next.whenOrNull(
        data: (_) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Restore successful ✅')),
          );
        },
        error: (error, _) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Restore failed ❌: ${error.toString()}')),
          );
        },
      );
    });
  }

  void listenForBackupNotifier() {
    ref.listen<AsyncValue<void>>(backupNotifierProvider, (prev, next) {
      final notifier = ref.read(backupNotifierProvider.notifier);
      if (!notifier.hasTriggeredRestore) return;

      next.whenOrNull(
        data: (_) {
          ref.invalidate(lastBackupTimeProvider);

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Backup successful ✅')),
          );
        },
        error: (error, _) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Backup failed ❌: ${error.toString()}')),
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    listenForNotifier();
    listenForBackupNotifier();
    final textTheme = Theme.of(context).textTheme;
    final user = FirebaseAuth.instance.currentUser;
    final backupState = ref.watch(backupNotifierProvider);
    final restoreState = ref.watch(restoreNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Settings",
        ),
        actions: [
          if (user != null)
            IconButton(onPressed: _confirmSignout, icon: Icon(Icons.logout))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Container(
                      clipBehavior: Clip.hardEdge,
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        image: user?.photoURL == null
                            ? null
                            : DecorationImage(
                                image: NetworkImage(user!.photoURL!),
                                fit: BoxFit.fill,
                              ),
                        shape: BoxShape.circle,
                        color: Theme.of(context).colorScheme.surface,
                      ),
                      child: user?.photoURL == null
                          ? Center(
                              child: Icon(GeneralIcons.user, size: 35),
                            )
                          : null,
                    ),
                    SizedBox(height: 10),
                    Text(
                      user != null
                          ? "${user?.displayName ?? user?.email}"
                          : "Anonymous",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    if (user != null) LastBackupTime(),
                  ],
                ),
              ),
              ReasonsToUpgrade(),
              SizedBox(height: AppSpacing.lg),
              Padding(
                padding: const EdgeInsets.only(left: AppSpacing.md),
                child: Text(
                  "General".toUpperCase(),
                  style: textTheme.titleMedium,
                ),
              ),
              SizedBox(height: AppSpacing.sm),
              AppCard(
                  padding: EdgeInsets.all(0),
                  child: Column(
                    children: [
                      Consumer(builder: (context, ref, _) {
                        final isProAsync = ref.watch(isProUserProvider);
                        final isPro = isProAsync.hasValue && isProAsync.value!;

                        return Column(
                          children: [
                            SingleSettingContainer(
                              onTap: () => _onTapBackup(user, isPro),
                              icondata: Icons.backup,
                              title: "Backup",
                              rightContent: backupState.isLoading
                                  ? CupertinoActivityIndicator(radius: 12)
                                  : null,
                            ),
                            Separator(),
                            SingleSettingContainer(
                              onTap: () => _onTapRestore(user, isPro),
                              icondata: Icons.restart_alt_outlined,
                              title: "Restore data",
                              rightContent: restoreState.isLoading
                                  ? CupertinoActivityIndicator(radius: 12)
                                  : null,
                            ),
                          ],
                        );
                      }),
                      Separator(),
                      SingleSettingContainer(
                        onTap: () {
                          _showThemes(context);
                        },
                        icondata: Icons.dark_mode,
                        title: "Dark mode",
                      ),
                      // SettingsTheme(),
                    ],
                  )),
              SizedBox(height: AppSpacing.lg),
              AppInfoSection(),
              SizedBox(height: AppSpacing.lg),
              SupportSection(),
              SizedBox(height: AppSpacing.lg),
            ],
          ),
        ),
      ),
    );
  }

  void _onTapBackup(User? user, bool isPro) {
    if (!isPro) {
      Navigator.pushNamed(context, RouteNames.paywall);
      return;
    }
    if (user == null) {
      Navigator.pushNamed(context, "/sign_in").then((signedIn) {
        if (signedIn == true) {
          setState(() {});
        }
      });
    } else {
      ref.read(backupNotifierProvider.notifier).backup();
    }
  }

  void _onTapRestore(User? user, bool isPro) {
    if (!isPro) {
      Navigator.pushNamed(context, RouteNames.paywall);
      return;
    }
    if (user == null) {
      Navigator.pushNamed(context, "/sign_in").then((signedIn) {
        if (signedIn == true) {
          setState(() {});
        }
      });
    } else {
      ref.read(restoreNotifierProvider.notifier).restore();
    }
  }

  void _showThemes(BuildContext context) {
    showModalBottomSheet<void>(
      // backgroundColor: Theme.of(context).colorScheme.background,
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return BottomsheetWrapper(screenHeightOf: 0.4, child: ChooseThemes());
      },
    );
  }

  void _confirmSignout() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Are you sure you want to Sign out?'),
        content: const Text(
            'When you sign out, Backup and Restore feature will be unavailable. You can still restore your backed-up data by signing again.'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pop(context);
              setState(() {});
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }
}
