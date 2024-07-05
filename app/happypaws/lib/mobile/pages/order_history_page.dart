import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:happypaws/common/services/AuthService.dart';
import 'package:happypaws/common/services/OrdersService.dart';
import 'package:happypaws/common/utilities/Colors.dart';
import 'package:happypaws/desktop/components/buttons/go_back_button.dart';
import 'package:happypaws/desktop/components/spinner.dart';
import 'package:happypaws/routes/app_router.gr.dart';
import 'package:intl/intl.dart';

@RoutePage()
class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({super.key});

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  Map<String, dynamic>? orders;
  bool isLoadingOrder = false;
  bool newFirst = true;

  @override
  initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    var user = await AuthService().getCurrentUser();
    if (user == null) return;
    var response =
        await OrdersService().getPaged("endpoint", 1, 9999, searchObject: {
      'userId': user['Id'],
    });
    if (response.statusCode == 200) {
      response.data['items'].sort((a, b) => DateTime.parse(b['createdAt'])
          .compareTo(DateTime.parse(a['createdAt'])));
      setState(() {
        orders = response.data;
      });
    }
  }

  void sortData() {
    setState(() {
      if (newFirst) {
        orders!['items'].sort((a, b) => DateTime.parse(b['createdAt'])
            .compareTo(DateTime.parse(a['createdAt'])));
      } else {
        orders!['items'].sort((a, b) => DateTime.parse(a['createdAt'])
            .compareTo(DateTime.parse(b['createdAt'])));
      }
    });
  }

  Future<void> fetchOrder(int id) async {
    setState(() {
      isLoadingOrder = true;
    });
    var response = await OrdersService().get("/$id");
    if (response.statusCode == 200) {
      setState(() {
        isLoadingOrder = false;
      });
      if (!mounted) return;
      context.router.push(OrderDetailsRoute(data: response.data));
    }
  }

  @override
  Widget build(BuildContext context) {
    return orders == null || isLoadingOrder
        ? const Spinner()
        : SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      const GoBackButton(),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            newFirst = !newFirst;
                          });
                          sortData();
                        },
                        child: Row(
                          children: [
                            Text(
                              newFirst ? 'Oldest first' : 'Newest first',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 16),
                            ),
                            const Icon(
                              Icons.sort,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                for (var order in orders!['items'])
                  GestureDetector(
                    onTap: () => fetchOrder(order['id']),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                          border: Border.symmetric(
                              horizontal: BorderSide(
                                  width: 2, color: AppColors.dimWhite))),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "ID ${order['id']}",
                                style: const TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                DateFormat('dd.MM.yyyy')
                                    .format(DateTime.parse(order['createdAt'])),
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.gray),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "\$${order['total']}",
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                  order['status'][0] +
                                      order['status']
                                          .split(RegExp(r'(?=[A-Z])'))
                                          .join(' ')
                                          .toLowerCase()
                                          .substring(1),
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: (order['status'] == 'Pending' ||
                                            order['status'] == 'Processing' ||
                                            order['status'] == 'OnHold')
                                        ? AppColors.info
                                        : (order['status'] == 'ReadyToPickUp' ||
                                                order['status'] ==
                                                    'Dispatched' ||
                                                order['status'] ==
                                                    'Confirmed' ||
                                                order['status'] == 'Delivered')
                                            ? AppColors.success
                                            : AppColors.error,
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          );
  }
}
