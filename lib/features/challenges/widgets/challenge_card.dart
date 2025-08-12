import 'package:betterloop/models/challenge.dart';
import 'package:betterloop/routes/route_names.dart';
import 'package:betterloop/theme/colors.dart';
import 'package:betterloop/theme/spacing.dart';
import 'package:betterloop/widgets/app_card.dart';
import 'package:flutter/material.dart';

class ChallengeCard extends StatelessWidget {
  const ChallengeCard({super.key, required this.challenge});
  final Challenge challenge;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return AppCard(
        onTap: () {
          Navigator.pushNamed(context, RouteNames.challenge,
              arguments: challenge);
        },
        padding: EdgeInsets.all(0),
        child: Stack(
          children: [
            // Positioned(
            //     top: -70,
            //     right: -40,
            //     child: Container(
            //       height: 180,
            //       width: 180,
            //       decoration: BoxDecoration(
            //         shape: BoxShape.circle,
            //         color: AppColors.of(context).onSurfaceBg,
            //       ),
            //     )),
            Padding(
              padding: EdgeInsetsGeometry.all(AppSpacing.md_lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(challenge.title, style: textTheme.titleLarge),
                            SizedBox(height: AppSpacing.sm),
                            Text(
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              challenge.description,
                              style: textTheme.bodyMedium?.copyWith(
                                  color: AppColors.of(context).textSecondary),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: AppSpacing.lg),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text("${challenge.goal.value} / day",
                              style: textTheme.titleLarge
                                  ?.copyWith(color: AppColors.accent)),
                          SizedBox(width: AppSpacing.sm),
                          Text("${challenge.duration} days",
                              style: textTheme.titleMedium?.copyWith(
                                  color: AppColors.of(context).textSecondary)),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: AppSpacing.md),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("${challenge.participants} people joined",
                          style: textTheme.titleMedium
                              ?.copyWith(color: colorScheme.primary)),
                      IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, RouteNames.challenge);
                          },
                          icon: Icon(
                            Icons.chevron_right_rounded,
                            size: 35,
                          ))
                    ],
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
