import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:mighty_school/feature/report/domain/model/chart_data.dart';
import 'package:mighty_school/feature/report/logic/dashboard_report_controller.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class DashboardEarningChartWidget extends StatefulWidget {
  const DashboardEarningChartWidget({super.key});
  @override
  DashboardEarningChartWidgetState createState() => DashboardEarningChartWidgetState();
}

class DashboardEarningChartWidgetState extends State<DashboardEarningChartWidget> {
@override
  void initState() {
    Get.find<DashboardReportController>().getYearlyCashFlowData("2025", "03");
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }
late TooltipBehavior _tooltip;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardReportController>(
      builder: (reportController) {
        return SfCartesianChart(
          title: ChartTitle(text: "earning".tr.tr, textStyle: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault)),
          legend: const Legend(isVisible: true),
          primaryXAxis: const CategoryAxis(),
          primaryYAxis: NumericAxis(numberFormat: NumberFormat.compact()),
          tooltipBehavior: _tooltip,
          series: <CartesianSeries<ChartData, String>>[
            ColumnSeries<ChartData, String>(
              dataSource: reportController.incomeData,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y,
              name: 'credit'.tr,
              color: const Color(0xFFCEE34C),
            ),

            ColumnSeries<ChartData, String>(
              dataSource: reportController.expenseData,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y,
              name: 'debit'.tr,
              color: const Color(0xFF215CDE),
            ),
          ],
        );
      }
    );
  }
}

