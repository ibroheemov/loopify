import 'package:betterloop/constants/general_icons.dart';
import 'package:betterloop/features/custom_habit/models/icontype.dart';
import 'package:betterloop/features/custom_habit/providers/habit_icon_provider.dart';
import 'package:betterloop/features/custom_habit/widgets/icon_box.dart';
import 'package:betterloop/models/icon_meta.dart';
import 'package:betterloop/routes/route_names.dart';
import 'package:betterloop/theme/colors.dart';
import 'package:betterloop/theme/spacing.dart';
import 'package:betterloop/utils/extensions.dart';
import 'package:betterloop/widgets/app_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AllIcons extends StatefulWidget {
  const AllIcons({super.key, required this.ref});
  final WidgetRef ref;

  @override
  State<AllIcons> createState() => _AllIconsState();
}

class _AllIconsState extends State<AllIcons> with TickerProviderStateMixin {
  late final TabController _tabController;
  IconData selectedIcon = GeneralIcons.cameraAdd;
  late Color currentColor;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: IconType.values.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AppContainer(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTabBar(),
            SizedBox(height: AppSpacing.vertical),
            _buildTabBarContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBarContent() {
    return Expanded(
      child: TabBarView(
        controller: _tabController,
        children: [
          ...IconType.values.map((tab) {
            List<IconMeta> tabicons = IconType.iconMetaList(tab.value);

            return GridView.builder(
              padding:
                  const EdgeInsets.symmetric(vertical: AppSpacing.vertical),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: tabicons.length,
              itemBuilder: (context, index) {
                final iconmeta = tabicons[index];
                final isSelected = selectedIcon == iconmeta.icon;
                return IconBox(
                  onTap: (isPremium, isPro) => _onTapIcon(
                    icon: iconmeta.icon,
                    isPremium: isPremium,
                    isPro: isPro,
                  ),
                  icon: iconmeta.icon,
                  isSelected: isSelected,
                );
              },
            );
          }),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return TabBar(
      dividerHeight: 0,
      tabAlignment: TabAlignment.start,
      isScrollable: true,
      labelStyle: Theme.of(context).textTheme.titleMedium,
      unselectedLabelColor: AppColors.of(context).textSecondary,
      splashBorderRadius: BorderRadius.all(Radius.circular(10)),
      controller: _tabController,
      indicatorWeight: 2,
      tabs: IconType.values
          .map((e) => Tab(height: 40, child: Text(e.name.capitalize())))
          .toList(),
    );
  }

  void _onTapIcon({
    required IconData icon,
    required bool isPremium,
    required bool isPro,
  }) async {
    setState(() => selectedIcon = icon);
    widget.ref.read(habitIconProvider.notifier).state = selectedIcon;

    if (isPremium && !isPro) {
      await Future.delayed(Duration(milliseconds: 500));
      setState(() => selectedIcon = GeneralIcons.cameraAdd);
      widget.ref.read(habitIconProvider.notifier).state = selectedIcon;
      if (!mounted) return;
      Navigator.pushNamed(context, RouteNames.paywall);
    }
  }
}
