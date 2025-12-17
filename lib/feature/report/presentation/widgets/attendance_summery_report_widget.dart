import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mighty_school/common/widget/custom_dropdown.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:mighty_school/feature/report/domain/model/chart_data.dart';
import 'package:mighty_school/feature/report/logic/dashboard_report_controller.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class AttendanceSummaryReportWidget extends StatefulWidget {
  const AttendanceSummaryReportWidget({super.key});

  @override
  AttendanceSummaryReportWidgetState createState() => AttendanceSummaryReportWidgetState();
}

class AttendanceSummaryReportWidgetState extends State<AttendanceSummaryReportWidget> {
  late TooltipBehavior _tooltip;

  @override
  void initState() {
    super.initState();
    _tooltip = TooltipBehavior(enable: true, header: '', canShowMarker: false);
    Get.find<DashboardReportController>().getAttendanceSummaryData(Get.find<DashboardReportController>().selectedAttendanceType);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardReportController>(
      builder: (reportController) {
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text("attendance_summary".tr, style: textBold.copyWith(fontSize: Dimensions.fontSizeLarge)),
                    const SizedBox(height: 4),
                    Text("More than 400 new members", style: textRegular.copyWith(color: Colors.grey))]),

                SizedBox(width: 150, child: Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: CustomDropdown(width: Get.width, title: "select".tr,
                    items: reportController.attendanceTypeList,
                    selectedValue: reportController.selectedAttendanceType,
                    onChanged: (val){
                      reportController.setSelectedAttendanceType(val!);
                    },
                  ))),
              ]),
            const SizedBox(height: 16),

            SizedBox(height: 250,
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(borderColor: Theme.of(context).primaryColor,
                    majorGridLines: MajorGridLines(color: Theme.of(context).cardColor)),
                primaryYAxis: NumericAxis(numberFormat: NumberFormat.compact(),
                    majorGridLines:  MajorGridLines(color: Theme.of(context).hintColor)),
                tooltipBehavior: _tooltip,
                legend: const Legend(isVisible: true, position: LegendPosition.bottom),
                series: <CartesianSeries<ChartData, String>>[
                  ColumnSeries<ChartData, String>(
                    name: "present".tr,
                    width: 0.3,
                    dataSource: reportController.presentData,
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.y,
                    color: Theme.of(context).primaryColor,
                    dataLabelSettings: const DataLabelSettings(isVisible: false),
                    enableTooltip: true,),

                  ColumnSeries<ChartData, String>(
                    name: "absent".tr,
                    width: 0.3,
                    dataSource: reportController.absentData,
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.y,
                    color: Theme.of(context).colorScheme.secondary,
                    dataLabelSettings: const DataLabelSettings(isVisible: false),
                    enableTooltip: true),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

}
