import 'package:betterloop/constants/negative_icons.dart';
import 'package:betterloop/features/custom_habit/models/icontype.dart';
import 'package:betterloop/features/custom_habit/providers/habit_icon_provider.dart';
import 'package:betterloop/features/custom_habit/widgets/icon_box.dart';
import 'package:betterloop/models/icon_meta.dart';
import 'package:betterloop/theme/colors.dart';
import 'package:betterloop/theme/spacing.dart';
import 'package:betterloop/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AllIcons extends ConsumerStatefulWidget {
  const AllIcons({super.key});

  @override
  ConsumerState<AllIcons> createState() => _AllIconsState();
}

class _AllIconsState extends ConsumerState<AllIcons>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  IconData? selectedIcon;
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
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: AppSpacing.vertical),
          _buildTabBar(),
          SizedBox(height: AppSpacing.vertical),
          _buildTabBarContent(),
        ],
      ),
    );
  }

  Widget _buildTabBarContent() {
    return Expanded(
      child: TabBarView(
        controller: _tabController,
        children: [
          ...IconType.values.map((tab) {
            List<IconMeta> tabicons = NegativeIcons.iconMetaList;

            return GridView.builder(
              padding: const EdgeInsets.only(top: 10),
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
                  onTap: () => _onTapIcon(iconmeta.icon),
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

  void _onTapIcon(IconData icon) {
    setState(() {
      selectedIcon = icon;
    });
    ref.read(habitIconProvider.notifier).state = icon;
  }
}
