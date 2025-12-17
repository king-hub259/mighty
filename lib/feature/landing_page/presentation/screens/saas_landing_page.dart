import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mighty_school/feature/authentication/logic/authentication_controller.dart';
import 'package:mighty_school/feature/landing_page/logic/landing_page_controller.dart';
import 'package:mighty_school/feature/landing_page/presentation/widgets/built_technology.dart';
import 'package:mighty_school/feature/landing_page/presentation/widgets/deliverable_section.dart';
import 'package:mighty_school/feature/landing_page/presentation/widgets/faq_widget.dart';
import 'package:mighty_school/feature/landing_page/presentation/widgets/footer_widget.dart';
import 'package:mighty_school/feature/landing_page/presentation/widgets/key_features_widget.dart';
import 'package:mighty_school/feature/landing_page/presentation/widgets/landing_page_appbar.dart';
import 'package:mighty_school/feature/landing_page/presentation/widgets/package_pricing_widget.dart';
import 'package:mighty_school/feature/landing_page/presentation/widgets/take_first_widget.dart';
import 'package:mighty_school/feature/landing_page/presentation/widgets/testimonial_section.dart';
import 'package:mighty_school/feature/landing_page/presentation/widgets/try_demo_section_widget.dart';
import 'package:mighty_school/feature/landing_page/presentation/widgets/what_get_sections.dart';
import 'package:mighty_school/feature/landing_page/presentation/widgets/why_chose_us_widget.dart';
import 'package:mighty_school/helper/route_helper.dart';
import 'package:mighty_school/util/app_constants.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:url_launcher/url_launcher.dart';

class SaasLandingPage extends StatefulWidget {
  const SaasLandingPage({super.key});

  @override
  State<SaasLandingPage> createState() => _SaasLandingPageState();
}

class _SaasLandingPageState extends State<SaasLandingPage> {
  final ValueNotifier<bool> _isFabVisible = ValueNotifier<bool>(false);

  final ItemScrollController itemScrollController = ItemScrollController();
  final ScrollOffsetController scrollOffsetController = ScrollOffsetController();
  final ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();
  final ScrollOffsetListener scrollOffsetListener = ScrollOffsetListener.create();

  Future<void> loadData() async {
    Future.delayed(const Duration(milliseconds: 100), () {
      if(Get.find<AuthenticationController>().isLoggedIn()){
        Get.toNamed(RouteHelper.getDashboardRoute());
      }
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
    itemPositionsListener.itemPositions.addListener(() {
      final positions = itemPositionsListener.itemPositions.value;
      final visibleItems = positions.where((position) => position.itemLeadingEdge >= 0);
      if (visibleItems.isNotEmpty) {
        final firstVisibleIndex =
        visibleItems.map((position) => position.index).reduce((a, b) => a < b ? a : b);
        _isFabVisible.value = firstVisibleIndex > 1;
      } else {
        _isFabVisible.value = false;
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LandingPageAppBar(itemScrollController: itemScrollController),
      body: GetBuilder<LandingPageController>(
        builder: (landingPageController) {
          return ScrollablePositionedList.builder(
            itemCount: landingPageController.menuList.length,
            itemScrollController: itemScrollController,
            scrollOffsetController: scrollOffsetController,
            itemPositionsListener: itemPositionsListener,
            scrollOffsetListener: scrollOffsetListener,
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemBuilder: (BuildContext context, int index) {
              switch (index) {
                case 0:
                  return const Padding(padding: EdgeInsets.only(bottom: Dimensions.homePageSpacing),
                    child: TryDemoSectionWidget());
                case 1:
                  return Padding(padding: EdgeInsets.symmetric(vertical: Dimensions.landingPagePadding),
                    child: const DeliverableSection());
                case 2:
                  return Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.homePageSpacing),
                    child: Column(
                      children: [
                        const WhyChooseUsWidget(),
                        Padding(padding: EdgeInsets.symmetric(vertical:Dimensions.landingPagePadding),
                            child: const KeyFeaturesWidget())
                      ],
                    ));
                case 3:
                  return Padding(padding: EdgeInsets.only(bottom : Dimensions.landingPagePadding),
                    child: const PackagePricingWidget());
                case 4:
                  return  Column(children: [
                    Padding(padding: EdgeInsets.symmetric(vertical: Dimensions.landingPagePadding),
                        child: const BuiltTechnologySection()),
                    const Padding(padding: EdgeInsets.only(top: Dimensions.homePagePadding),
                        child: WhatGetSections()),
                    const TestimonialSection(),
                    ]);
                case 5:
                  return Padding(padding: const EdgeInsets.only(top: Dimensions.homePagePadding),
                    child: Column(children: [
                        const FaqWidget(),
                        Padding(padding: EdgeInsets.symmetric(vertical: Dimensions.landingPagePadding),
                          child: const TakeFirstWidget()),
                      ]),
                  );
                case 6:
                  return Padding(padding: const EdgeInsets.only(top: Dimensions.homePagePadding),
                    child: FooterWidget(itemScrollController: itemScrollController),
                  );
                default:
                  return const SizedBox.shrink();
              }
            },
          );
        },
      ),
      floatingActionButton: ValueListenableBuilder<bool>(
        valueListenable: _isFabVisible,
        builder: (context, isVisible, child) {
          return Padding(
            padding: const EdgeInsets.only(left: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FloatingActionButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                  onPressed: () {
                    const url = "https://wa.me/${AppConstants.whatsAppNumber}";
                    launchUrl(Uri.parse(url));
                  },
                  backgroundColor: Colors.green,
                  child: const FaIcon(FontAwesomeIcons.whatsapp, color: Colors.white),
                ),
                isVisible
                    ? FloatingActionButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                  onPressed: () {
                    itemScrollController.scrollTo(
                      index: 0,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOutCubic,
                    );
                  },
                  backgroundColor: Theme.of(context).primaryColor,
                  child: const FaIcon(FontAwesomeIcons.arrowUp, color: Colors.white),
                )
                    : const SizedBox(),
              ],
            ),
          );
        },
      ),
    );
  }
}
