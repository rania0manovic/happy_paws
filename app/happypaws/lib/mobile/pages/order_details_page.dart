import 'dart:convert';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:happypaws/common/utilities/Colors.dart';
import 'package:happypaws/desktop/components/buttons/go_back_button.dart';
import 'package:happypaws/routes/app_router.gr.dart';
import 'package:intl/intl.dart';

@RoutePage()
class OrderDetailsPage extends StatefulWidget {
  final Map<String, dynamic> data;
  const OrderDetailsPage({super.key, required this.data});

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const GoBackButton(),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Order details",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 20,
            ),
            for (var item in widget.data['orderDetails'])
              Column(
                children: [
                  GestureDetector(
                    onTap: () => context.router.push(
                        ProductDetailsRoute(productId: item['productId'])),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 16),
                      child: Wrap(
                        children: [
                          FractionallySizedBox(
                              widthFactor: 0.4,
                              child: Image.memory(
                                base64.decode(item['product']['productImages']
                                        [0]['image']['data']
                                    .toString()),
                                height: 100,
                              )),
                          FractionallySizedBox(
                            widthFactor: 0.6,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  item['product']['name'].length > 40
                                      ? '${item['product']['name'].substring(0, 40)}...'
                                      : item['product']['name'],
                                  style: const TextStyle(fontSize: 16),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "\$ ${item['unitPrice']}",
                                      style: const TextStyle(
                                          color: AppColors.gray,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const Spacer(),
                                    Text(
                                      "x${item['quantity']}",
                                      style: const TextStyle(
                                          color: AppColors.gray,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const Spacer(),
                                    Text(
                                      // ignore: prefer_interpolation_to_compose_strings
                                      "\$ " +
                                          (item['unitPrice'] * item['quantity'])
                                              .toStringAsFixed(2),
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Colors.grey.shade300))),
                  ),
                ],
              ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const Text(
                      "Order ID: ",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    const Spacer(),
                    Text(
                      "${widget.data['id']}",
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    const Text(
                      "Created at: ",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    const Spacer(),
                    Text(
                      DateFormat('dd.MM.yyyy, HH:mm').format(DateTime.parse(widget.data['orderDate'])),
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                 const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    const Text(
                      "Payment method:",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    const Spacer(),
                    Text(
                      " ${widget.data['paymentMethod']}",
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                 const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      "Order status: ",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    const Spacer(),
                    Text(widget.data['status'],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: (widget.data['status'] == 'Pending' ||
                                  widget.data['status'] == 'Processing' ||
                                  widget.data['status'] == 'OnHold')
                              ? AppColors.info
                              : (widget.data['status'] == 'ReadyToPickUp' ||
                                      widget.data['status'] == 'Dispatched' ||
                                      widget.data['status'] == 'Confirmed' ||
                                      widget.data['status'] == 'Delivered')
                                  ? AppColors.success
                                  : AppColors.error,
                        )),
                  ],
                ),
                 const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      "Total: ",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    const Spacer(),
                    Text("\$ ${widget.data['total']}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        )),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
