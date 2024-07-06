import 'package:auto_route/auto_route.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:happypaws/common/components/text/light_text.dart';
import 'package:happypaws/common/services/AnalyticsService.dart';
import 'package:happypaws/common/services/EnumsService.dart';
import 'package:happypaws/common/services/OrdersService.dart';
import 'package:happypaws/common/services/ProductsService.dart';
import 'package:happypaws/common/services/SystemConfigsService.dart';
import 'package:happypaws/common/utilities/Colors.dart';
import 'package:happypaws/common/utilities/toast.dart';
import 'package:happypaws/desktop/components/buttons/primary_button.dart';
import 'package:happypaws/desktop/components/input_field.dart';
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
  Map<String, dynamic>? configData;
  Map<String, dynamic>? products;
  List<dynamic>? barChartData;
  List<dynamic> productsToSend = [];
  List<dynamic>? topBuyers;
  List<dynamic>? newsletterTopics;
  bool isLoading = false;
  double maxY = 0;
  String? selectedOption;
  final _scrollControllerGrid = ScrollController();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> fetchData({bool refresh = false}) async {
    try {
      setState(() {
        isLoading = true;
      });
      var analytics =
          await AnalyticsService().get('', searchObject: {"refresh": refresh});
      var chartData = await AnalyticsService().getCountByPetType();
      var topBuyersData =
          await OrdersService().getTopBuyers(size: 5, refresh: refresh);
      var configData = await SystemConfigsService().get("/1");
      if (analytics.statusCode == 200) {
        setState(() {
          basicAnalytics = analytics.data;
        });
      }
      if (chartData.statusCode == 200 && chartData.data.length > 0) {
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
      if (configData.statusCode == 200) {
        setState(() {
          this.configData = configData.data;
        });
      }
    } catch (e) {
      rethrow;
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future fetchNewProducts(StateSetter setState) async {
    try {
      var response = await ProductsService().getPaged('', 1, 20, searchObject: {
        'getReviews': false,
        'onlyActive': true,
        "orderByDate": true
      });
      if (response.statusCode == 200) {
        setState(() {
          products = response.data;
        });
      }
    } catch (e) {
      rethrow;
    }
  }

  Future sendNewsLetter(BuildContext context) async {
    try {
      var response =
          await ProductsService().sendNewsLetterForNewArrivalls(productsToSend);
      if (response.statusCode == 200) {
        if (!context.mounted) return;
        Navigator.of(context).pop();
        ToastHelper.showToastSuccess(context,
            "You have succesfully sent a newsletter for new arrivals!");
      }
    } catch (e) {
      rethrow;
    }
  }

  final _formKey = GlobalKey<FormState>();
  Future updateConfigs(BuildContext context) async {
    try {
      var result = await SystemConfigsService().put('', configData);
      if (result.statusCode == 200) {
        if (!context.mounted) return;
        Navigator.of(context).pop();
        ToastHelper.showToastSuccess(
            context, "You have succesfully updated your donations goal!");
      }
    } catch (e) {
      if (!context.mounted) return;
      ToastHelper.showToastError(
          context, "An error occured, please try again later.");
      rethrow;
    }
  }

  Future<void> fetchNewsletterTopics() async {
    var response = await EnumsService().getNewsletterTopics();
    if (response.statusCode == 200) {
      setState(() {
        newsletterTopics = response.data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading || basicAnalytics == null
        ? const Spinner()
        : SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton.filled(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary),
                          onPressed: () {
                            fetchData(refresh: true);
                          },
                          icon: const Icon(Icons.refresh_outlined)),
                      const SizedBox(
                        width: 10,
                      ),
                      const Tooltip(
                          message:
                              "Dashboard data refreshes daily. If you wish to see updates now, click on the refresh button.",
                          child: Icon(
                            Icons.info_outline,
                            color: AppColors.gray,
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  mainCountSection(),
                  barChart(),
                  donationsProgressAndTopBuyers(),
                  thisMonth(),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Actions',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      PrimaryButton(
                        onPressed: () async {
                          await fetchNewsletterTopics();
                          if (!context.mounted) return;
                          showDialog(
                            context: context,
                            builder: (context) {
                              return StatefulBuilder(
                                builder: (context, setState) {
                                  return AlertDialog(
                                      content: SingleChildScrollView(
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      child: Form(
                                        key: _formKey,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Row(
                                              children: [
                                                const IconButton(
                                                  icon: Icon(Icons
                                                      .inventory_2_outlined),
                                                  onPressed: null,
                                                  color: AppColors.gray,
                                                ),
                                                const Text(
                                                  "Send new newsletter",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                const Spacer(),
                                                IconButton(
                                                  onPressed: () =>
                                                      Navigator.of(context)
                                                          .pop(),
                                                  icon: const Icon(Icons.close),
                                                  color: Colors.grey,
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const SizedBox(
                                                        height: 16,
                                                      ),
                                                      const LightText(
                                                        label: "Topic:",
                                                        fontSize: 14,
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      SizedBox(
                                                          width:
                                                              double.infinity,
                                                          height: 40,
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: AppColors
                                                                  .fill,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                            child:
                                                                DropdownButton<
                                                                    String>(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          10),
                                                              isExpanded: true,
                                                              value:
                                                                  selectedOption,
                                                              underline:
                                                                  Container(),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              icon: const Icon(
                                                                  Icons
                                                                      .arrow_drop_down,
                                                                  color: Colors
                                                                      .grey),
                                                              onChanged: (String?
                                                                  newValue) {
                                                                setState(() {
                                                                  selectedOption =
                                                                      newValue!;
                                                                });
                                                                if (newValue ==
                                                                    "NewArrivals") {
                                                                  fetchNewProducts(
                                                                      setState);
                                                                }
                                                              },
                                                              items: [
                                                                for (var item
                                                                    in newsletterTopics!)
                                                                  DropdownMenuItem<
                                                                      String>(
                                                                    value: item[
                                                                            'value']
                                                                        .toString(),
                                                                    child: Text(item['value']
                                                                            [
                                                                            0] +
                                                                        item['value']
                                                                            .split(RegExp(r'(?=[A-Z])'))
                                                                            .join(' ')
                                                                            .toLowerCase()
                                                                            .substring(1)),
                                                                  ),
                                                              ],
                                                            ),
                                                          )),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  if (products != null)
                                                    const Text(
                                                      "Select minimum of 4 products to promote (showing last 20 added active products): ",
                                                      style: TextStyle(
                                                          fontSize: 16),
                                                    ),
                                                  if (products != null)
                                                    GridView.builder(
                                                      controller:
                                                          _scrollControllerGrid,
                                                      shrinkWrap: true,
                                                      gridDelegate:
                                                          const SliverGridDelegateWithMaxCrossAxisExtent(
                                                              maxCrossAxisExtent:
                                                                  300,
                                                              crossAxisSpacing:
                                                                  20,
                                                              mainAxisSpacing:
                                                                  20,
                                                              mainAxisExtent:
                                                                  200),
                                                      itemCount:
                                                          products!['items']
                                                                  .length +
                                                              1,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        if (index <
                                                            products!['items']
                                                                .length) {
                                                          final item =
                                                              products!['items']
                                                                  [index];
                                                          return GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                if (productsToSend
                                                                    .any((e) =>
                                                                        e['id'] ==
                                                                        item[
                                                                            'id'])) {
                                                                  productsToSend
                                                                      .remove(
                                                                          item);
                                                                } else {
                                                                  productsToSend
                                                                      .add(
                                                                          item);
                                                                }
                                                              });
                                                            },
                                                            child:
                                                                SizedBox.expand(
                                                              child: Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(8),
                                                                color: productsToSend.any((e) =>
                                                                        e['id'] ==
                                                                        item[
                                                                            'id'])
                                                                    ? AppColors
                                                                        .primaryLight
                                                                        .withOpacity(
                                                                            0.2)
                                                                    : Colors
                                                                        .transparent,
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceEvenly,
                                                                  children: [
                                                                    Image
                                                                        .network(
                                                                      item['productImages'][0]
                                                                              [
                                                                              'image']
                                                                          [
                                                                          'downloadURL'],
                                                                      height:
                                                                          110,
                                                                    ),
                                                                    Text(
                                                                      item['name'].length >
                                                                              40
                                                                          ? '${item['name'].substring(0, 40)}...'
                                                                          : item[
                                                                              'name'],
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              15,
                                                                          fontWeight:
                                                                              FontWeight.w500),
                                                                    ),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceEvenly,
                                                                      children: [
                                                                        Text(
                                                                          '\$ ${item['price'].toStringAsFixed(2)}',
                                                                          style: const TextStyle(
                                                                              fontWeight: FontWeight.w700,
                                                                              fontSize: 16),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        } else {
                                                          return const SizedBox();
                                                        }
                                                      },
                                                    ),
                                                  PrimaryButton(
                                                    disabledWithoutSpinner:
                                                        productsToSend.length <
                                                            4,
                                                    onPressed: () {
                                                      sendNewsLetter(context);
                                                    },
                                                    label: "Send",
                                                    width: double.infinity,
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ));
                                },
                              );
                            },
                          );
                        },
                        label: "Send new newsletter ",
                        fontSize: 16,
                      )
                    ],
                  )
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
                        maxY: maxY + 2),
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
              child: Stack(
                children: [
                  SizedBox(
                    width: 250,
                    height: 250,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: CustomProgressIndicator(
                        targetProgress: basicAnalytics!['monthlyDonations'] /
                            configData!['donationsGoal'],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Tooltip(
                        message: "Edit goal",
                        child: IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    content: SizedBox(
                                      width: 300,
                                      height: 200,
                                      child: Form(
                                        key: _formKey,
                                        child: Column(
                                          children: [
                                            InputField(
                                              label:
                                                  'Monthly donations goal(in \$):',
                                              onChanged: (value) {
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  setState(() {
                                                    configData![
                                                            'donationsGoal'] =
                                                        double.tryParse(value);
                                                  });
                                                }
                                              },
                                              isNumber: true,
                                              value:
                                                  configData!['donationsGoal']
                                                      .toString(),
                                            ),
                                            const Spacer(),
                                            PrimaryButton(
                                              onPressed: () {
                                                updateConfigs(context);
                                              },
                                              label: 'Update data',
                                              width: double.infinity,
                                              fontSize: 18,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            icon: const Icon(Icons.more_horiz_outlined))),
                  )
                ],
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  'INCOME',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white38,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  '\$ ${basicAnalytics!['incomeTotal'].toStringAsFixed(2)}',
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
