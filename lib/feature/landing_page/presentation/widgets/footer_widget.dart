import 'package:flutter/material.dart';
import 'package:mighty_school/feature/landing_page/presentation/widgets/footer/copyright_widget.dart';
import 'package:mighty_school/feature/landing_page/presentation/widgets/footer/footer_left_portion.dart';
import 'package:mighty_school/feature/landing_page/presentation/widgets/footer/footer_quick_link_widget.dart';
import 'package:mighty_school/feature/landing_page/presentation/widgets/footer/news_letter_widget.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';


class FooterWidget extends StatelessWidget {
  final ItemScrollController itemScrollController;
  const FooterWidget({super.key, required this.itemScrollController});

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveHelper.isDesktop(context);

    return isDesktop? Column(children: [
      Container(color: Theme.of(context).cardColor,
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 50),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          const Expanded(child: FooterLeftPortion()),

          Expanded(child: FooterQuickLinkWidget(itemScrollController: itemScrollController)),

          const Expanded(child: NewsLetterWidget()),
        ],
        ),
      ),
      const CopyrightWidget()
    ],
    ):

    Column(children: [
      Container(color: Theme.of(context).colorScheme.onSurface,
        padding: const EdgeInsets.symmetric(vertical: 50),
        child: Column(spacing: Dimensions.paddingSizeOverLarge, children: [
          const FooterLeftPortion(),

          FooterQuickLinkWidget(itemScrollController: itemScrollController),

          const NewsLetterWidget(),
        ],
        ),
      ),
      const CopyrightWidget()
    ],
    );
  }
}