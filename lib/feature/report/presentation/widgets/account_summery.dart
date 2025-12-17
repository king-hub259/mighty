import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:mighty_school/feature/report/domain/model/chart_data.dart';
import 'package:mighty_school/feature/report/logic/dashboard_report_controller.dart';

class DashboardAccountChartWidget extends StatefulWidget {
  const DashboardAccountChartWidget({super.key});
  @override
  DashboardAccountChartWidgetState createState() => DashboardAccountChartWidgetState();
}

class DashboardAccountChartWidgetState extends State<DashboardAccountChartWidget> {
  late TooltipBehavior _tooltip;

  @override
  void initState() {
    Get.find<DashboardReportController>().getYearlyCashFlowData("2025", "3");
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardReportController>(builder: (reportController) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
           Text("income_and_expense_overview".tr, style: textSemiBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge,)),
          const SizedBox(height: 4),
           Text("track_the_institute".tr,
            style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color:Theme.of(context).hintColor),),
          const SizedBox(height: Dimensions.paddingSizeDefault),
          SfCartesianChart(

            primaryXAxis: CategoryAxis(
                majorGridLines: MajorGridLines(color: Theme.of(context).cardColor)
            ),
            primaryYAxis: NumericAxis(numberFormat: NumberFormat.compact(),
              majorGridLines: MajorGridLines(color: Theme.of(context).hintColor)
            ),
            tooltipBehavior: _tooltip,
            series: <CartesianSeries<ChartData, String>>[
              SplineAreaSeries<ChartData, String>(
                name: "total_income".tr,
                dataSource: reportController.incomeData,
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y,
                color: Theme.of(context).colorScheme.surfaceContainer.withValues(alpha:0.25),
                borderColor: Theme.of(context).colorScheme.surfaceContainer,
                borderWidth: 3,
                markerSettings: MarkerSettings(isVisible: true, color: Theme.of(context).colorScheme.surfaceContainer),
              ),
              SplineAreaSeries<ChartData, String>(
                name: "total_expense".tr,
                dataSource: reportController.expenseData,
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y,
                color: Theme.of(context).colorScheme.error.withValues(alpha: 0.3),
                borderColor: Theme.of(context).colorScheme.error,
                borderWidth: 3,
                markerSettings: MarkerSettings(isVisible: true, color: Theme.of(context).colorScheme.error),
              ),
            ],
            legend: const Legend(isVisible: true, position: LegendPosition.bottom),
          ),
        ],
      );
    });
  }
}
