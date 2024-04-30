import 'package:auto_route/auto_route.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:happypaws/common/services/AnalyticsService.dart';
import 'package:happypaws/common/services/OrdersService.dart';
import 'package:happypaws/common/utilities/Colors.dart';
import 'package:happypaws/desktop/components/progress_bar.dart';
import 'package:happypaws/desktop/components/spinner.dart';

@RoutePage()
class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  Map<String, dynamic>? basicAnalytics;
  List<dynamic>? barChartData;
  List<dynamic>? topBuyers;
  double maxY = 0;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> fetchData() async {
    var analytics = await AnalyticsService().get('');
    var chartData = await AnalyticsService().getCountByPetType();
    var topBuyersData = await OrdersService().getTopBuyers(size: 5);

    if (analytics.statusCode == 200) {
      setState(() {
        basicAnalytics = analytics.data;
      });
    }
    if (chartData.statusCode == 200) {
      setState(() {
        maxY = chartData.data
            .map((pet) => pet["count"] as int)
            .reduce((a, b) => a > b ? a : b)
            .toDouble();
        barChartData = chartData.data;
      });
    }
    if (topBuyersData.statusCode == 200) {
      setState(() {
        topBuyers = topBuyersData.data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return basicAnalytics == null || barChartData == null
        ? const Spinner()
        : SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  mainCountSection(),
                  barChart(),
                  donationsProgressAndTopBuyers(),
                  thisMonth()
                ],
              ),
            ),
          );
  }

  Column barChart() {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        const Row(
          children: [
            Expanded(
              child: Text(
                'Patient types',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
              child: Card(
                child: SizedBox(
                  height: 250,
                  child: BarChart(
                    BarChartData(
                        barTouchData: barTouchData,
                        titlesData: titlesData,
                        borderData: borderData,
                        barGroups: barGroups,
                        gridData: const FlGridData(
                            show: true,
                            drawHorizontalLine: true,
                            drawVerticalLine: false),
                        alignment: BarChartAlignment.spaceAround,
                        maxY: maxY + 1),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Column donationsProgressAndTopBuyers() {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        const Row(
          children: [
            SizedBox(
              width: 250,
              child: Text(
                'Donations progress',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(
              width: 40,
            ),
            Expanded(
              child: Text(
                'Top buyers',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Card(
              child: SizedBox(
                width: 250,
                height: 250,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: CustomProgressIndicator(
                    targetProgress: 0.75,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 40,
            ),
            Expanded(
              child: Card(
                child: SizedBox(
                    height: 250,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          const Wrap(
                            children: [
                              FractionallySizedBox(
                                widthFactor: 0.2,
                                child: Text(
                                  'NO',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.gray),
                                ),
                              ),
                              FractionallySizedBox(
                                widthFactor: 0.2,
                                child: Text(
                                  'PROFILE PHOTO',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.gray),
                                ),
                              ),
                              FractionallySizedBox(
                                widthFactor: 0.2,
                                child: Text(
                                  'NAME',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.gray),
                                ),
                              ),
                              FractionallySizedBox(
                                widthFactor: 0.2,
                                child: Text(
                                  'GENDER',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.gray),
                                ),
                              ),
                              FractionallySizedBox(
                                widthFactor: 0.2,
                                child: Text(
                                  'TOTAL',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.gray),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List.generate(topBuyers!.length, (index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Wrap(
                                  alignment: WrapAlignment.center,
                                  children: [
                                    FractionallySizedBox(
                                      widthFactor: 0.2,
                                      child: Text(
                                        (index + 1).toString(),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    const FractionallySizedBox(
                                        widthFactor: 0.2,
                                        child: Image(
                                          image: AssetImage(
                                              "assets/images/user.png"),
                                          height: 25,
                                          width: 25,
                                        )),
                                    FractionallySizedBox(
                                      widthFactor: 0.2,
                                      child: Text(
                                        topBuyers![index]['user']['fullName'],
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    FractionallySizedBox(
                                      widthFactor: 0.2,
                                      child: Text(
                                        topBuyers![index]['user']['gender'],
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    FractionallySizedBox(
                                      widthFactor: 0.2,
                                      child: Text(
                                        "\$ ${topBuyers![index]['totalSpent'].toStringAsFixed(2)}",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                          )
                        ],
                      ),
                    )),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Column thisMonth() {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        const Row(
          children: [
            Expanded(
              child: Text(
                'This month',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
              child: Card(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  height: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        'SHOP INCOME',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black45,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "\$ ${basicAnalytics!['monthlyIncome'].toStringAsFixed(2)}",
                        style: const TextStyle(
                            fontSize: 26,
                            color: Colors.black,
                            fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 30,
            ),
            Expanded(
              child: Card(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  height: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        'DONATIONS',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black45,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "\$ ${basicAnalytics!['monthlyDonations'].toStringAsFixed(2)}",
                        style: const TextStyle(
                            fontSize: 26,
                            color: Colors.black,
                            fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Row mainCountSection() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.primary),
            height: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  'APP USERS',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white38,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  basicAnalytics!['appUsersCount'].toString(),
                  style: const TextStyle(
                      fontSize: 26,
                      color: Colors.white,
                      fontWeight: FontWeight.w700),
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 25,
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.primary),
            height: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  'PATIENTS',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white38,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  basicAnalytics!['patientsCount'].toString(),
                  style: const TextStyle(
                      fontSize: 26,
                      color: Colors.white,
                      fontWeight: FontWeight.w700),
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 25,
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.primary),
            height: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  'EMPLOYEES',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white38,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  basicAnalytics!['employeesCount'].toString(),
                  style: const TextStyle(
                      fontSize: 26,
                      color: Colors.white,
                      fontWeight: FontWeight.w700),
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 25,
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.primary),
            height: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  'DONATIONS',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white38,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  '\$ ${basicAnalytics!['donationsTotal'].toStringAsFixed(2)}',
                  style: const TextStyle(
                      fontSize: 26,
                      color: Colors.white,
                      fontWeight: FontWeight.w700),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          getTooltipColor: (group) => Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              const TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.black54,
      fontWeight: FontWeight.w600,
      fontSize: 14,
    );

    String text;
    if (value >= 0 && value < barChartData!.length) {
      text = barChartData![value.toInt()]["name"] ?? "";
    } else {
      text = "";
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: style),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: getTitles,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  LinearGradient get _barsGradient => const LinearGradient(
        colors: [
          AppColors.primaryLight,
          AppColors.primaryMediumLight,
          AppColors.primary,
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );

  List<BarChartGroupData> get barGroups =>
      List.generate(barChartData!.length, (index) {
        return BarChartGroupData(
          x: index,
          barRods: [
            BarChartRodData(
              toY: barChartData![index]['count'].toDouble(),
              width: 30,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        );
      });
}
