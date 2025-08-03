import 'dart:async';

import 'package:betterloop/constants/general_icons.dart';
import 'package:betterloop/features/paywall/widgets/premium_features.dart';
import 'package:betterloop/providers/pro_user_provider.dart';
import 'package:betterloop/theme/colors.dart';
import 'package:betterloop/widgets/app_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class PaywallScreen extends ConsumerStatefulWidget {
  const PaywallScreen({super.key});

  @override
  ConsumerState<PaywallScreen> createState() => _PaywallScreenState();
}

class _PaywallScreenState extends ConsumerState<PaywallScreen> {
  final PageController _pageController = PageController();
  Package? selectedPackage;
  int _currentPage = 0;
  Package? sixMonthPackage;
  Package? monthlyPackage;
  Timer? _carouselTimer;

  @override
  void initState() {
    super.initState();

    fetchOfferings();
    // _startAutoScroll();
  }

  void _startAutoScroll() {
    _carouselTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      int nextPage = (_currentPage + 1) % 3;
      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _carouselTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() => _currentPage = index);
  }

  Widget _buildPage(String title, String subtitle) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Center(
            child: Text(
              title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 20),
          width: _currentPage == index ? 10 : 6,
          height: _currentPage == index ? 10 : 6,
          decoration: BoxDecoration(
            color: _currentPage == index ? Colors.white : Colors.grey,
            shape: BoxShape.circle,
          ),
        );
      }),
    );
  }

  String buildPrice(Package? value) {
    final package = value;
    if (package != null) {
      return package.storeProduct.priceString;
    } else {
      return "No package";
    }
  }

  Widget _buildPricingOptions() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildPlanCard("Six Month", "",
                "${buildPrice(sixMonthPackage)} / 6 mo", true, sixMonthPackage),
            const SizedBox(width: 16),
            _buildPlanCard(
              "Monthly",
              "",
              "${buildPrice(monthlyPackage)} / mo",
              false,
              monthlyPackage,
            ),
          ],
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.accent,
            foregroundColor: Colors.black,
            minimumSize: const Size(double.infinity, 50),
          ),
          onPressed: () {
            makePurchase();
          },
          child: const Text('Subscribe'),
        ),
      ],
    );
  }

  Widget _buildPlanCard(
    String label,
    String oldPrice,
    String price,
    bool highlight,
    Package? package,
  ) {
    return Expanded(
      child: AppCard(
        onTap: () {
          setState(() {
            selectedPackage = package;
          });
        },
        padding: const EdgeInsets.all(0),
        child: Container(
          height: 150,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
                color: package == selectedPackage
                    ? AppColors.accent
                    : Colors.grey),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
              if (oldPrice.isNotEmpty)
                Text(
                  oldPrice,
                  style: const TextStyle(
                    decoration: TextDecoration.lineThrough,
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              Text(
                price,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              if (highlight)
                Container(
                  margin: const EdgeInsets.only(top: 4),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.accent,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    '-39%',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }

  void fetchOfferings() async {
    try {
      Offerings offerings = await Purchases.getOfferings();
      if (offerings.current != null &&
          offerings.current!.availablePackages.isNotEmpty) {
        final packages = offerings.current!.availablePackages;
        final rc_six_month = packages
            .firstWhereOrNull((val) => val.identifier == "\$rc_six_month");
        final rc_monthly = packages
            .firstWhereOrNull((val) => val.identifier == "\$rc_monthly");

        setState(() {
          sixMonthPackage = rc_six_month;
          monthlyPackage = rc_monthly;
          selectedPackage = sixMonthPackage;
        });

        // Display packages for sale
      }
    } on PlatformException catch (e) {
      // optional error handling
    }
  }

  void makePurchase() async {
    if (selectedPackage == null) return;

    try {
      final result = await Purchases.purchasePackage(selectedPackage!);

      final isPro = result.customerInfo.entitlements.active.containsKey('pro');

      if (isPro) {
        // Show success feedback
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('Purchase successful! Pro features unlocked.')),
          );
          ref.invalidate(isProUserProvider);
          Navigator.pop(context);
        }
      } else {
        // Edge case: purchase went through but no entitlement
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('Purchase complete, but no access detected.')),
          );
        }
      }
    } on PlatformException catch (e) {
      final errorCode = PurchasesErrorHelper.getErrorCode(e);

      if (errorCode == PurchasesErrorCode.purchaseCancelledError) {
        // Optional: show cancellation feedback
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Purchase cancelled.')),
          );
        }
      } else {
        // Unexpected errors
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Purchase failed: ${e.message}')),
          );
        }
      }
    } catch (e) {
      // Any other error
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Something went wrong: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Stack(
            children: [
              Positioned(
                right: 0,
                top: 0,
                child: IconButton.filled(
                  style: IconButton.styleFrom(
                    backgroundColor: AppColors.of(context).surfaceSecondary,
                  ),
                  visualDensity: VisualDensity.compact,
                  iconSize: 15,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    GeneralIcons.close,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(height: 20),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text("Loopify",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          SizedBox(width: 10),
                          Chip(
                            label: Text("Pro",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                            backgroundColor: AppColors.accent,
                          ),
                        ],
                      ),
                      Text(
                        "Elevate your efficiency",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  PremiumFeatures(),
                  // Expanded(
                  //   child: PageView(
                  //     controller: _pageController,
                  //     onPageChanged: _onPageChanged,
                  //     children: [
                  //       _buildPage("Unlimited trains track",
                  //           "Track as many trains as you want from the home track page"),
                  //       _buildPage("Live Activities",
                  //           "Live-stream journey status on your lock & home screen"),
                  //       _buildPage("Get changes via push",
                  //           "We'll notify you about any train changes"),
                  //     ],
                  //   ),
                  // ),
                  // _buildDots(),
                  const SizedBox(height: 10),
                  _buildPricingOptions(),
                  // const SizedBox(height: 20),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
