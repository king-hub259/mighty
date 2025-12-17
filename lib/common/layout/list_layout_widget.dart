import 'package:flutter/material.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_divider.dart';
import 'package:mighty_school/common/widget/heading_menu_widget.dart';
import 'package:mighty_school/common/widget/no_data_found.dart';
import 'package:mighty_school/common/widget/paginated_list_widget.dart';
import 'package:mighty_school/common/widget/section_header_with_path_widget.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class GenericListSection<T> extends StatelessWidget {
  final bool showRouteSection;
  final String sectionTitle;
  final List<String>? pathItems;
  final String? addNewTitle;
  final VoidCallback? onAddNewTap;
  final List<String> headings;

  final ScrollController scrollController;
  final bool isLoading;
  final int totalSize;
  final int offset;
  final Future<void> Function(int? offset) onPaginate;
  final List<T>? items;
  final Widget Function(T item, int index) itemBuilder;

  const GenericListSection({
    super.key,
      this.showRouteSection = true,
    required this.sectionTitle,
     this.pathItems,
     this.addNewTitle,
     this.onAddNewTap,
    required this.headings,
    required this.scrollController,
    required this.isLoading,
    required this.totalSize,
    required this.offset,
    required this.onPaginate,
    required this.items,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [

      if(showRouteSection)
        SectionHeaderWithPath(
          sectionTitle: sectionTitle,
          pathItems: pathItems,
          addNewTitle: addNewTitle,
          onAddNewTap: onAddNewTap),

        Padding(padding: EdgeInsets.symmetric(horizontal: ResponsiveHelper.isDesktop(context)? Dimensions.paddingSizeDefault : Dimensions.paddingSizeExtraSmall),
          child: CustomContainer(showShadow: ResponsiveHelper.isDesktop(context),
            color: ResponsiveHelper.isDesktop(context)? Theme.of(context).cardColor : Colors.transparent,
            child: Column(children: [
              if(ResponsiveHelper.isDesktop(context))
                HeadingMenu(headings: headings),

                if (isLoading)
                  Padding(padding: ThemeShadow.getPadding(), child:  Center(child: CircularProgressIndicator(color : Theme.of(context).primaryColor)))

                else if (items == null || items!.isEmpty)
                  Padding(padding: ThemeShadow.getPadding(), child: const Center(child: NoDataFound()))

                else
                  PaginatedListWidget(
                    scrollController: scrollController,
                    onPaginate: onPaginate,
                    totalSize: totalSize,
                    offset: offset,
                    itemView: ListView.separated(
                      itemCount: items?.length ?? 0,
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final item = items![index];
                        return itemBuilder(item, index);
                      }, separatorBuilder: (BuildContext context, int index) {
                        return ResponsiveHelper.isDesktop(context) ?  Padding(
                          padding: const EdgeInsets.symmetric(vertical: 3.0),
                          child: Container(color: Theme.of(context).hintColor,height: .25,width: double.infinity,),
                        ) : const SizedBox(height: Dimensions.paddingSizeSmall);
                    },
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}