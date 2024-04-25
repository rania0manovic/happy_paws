import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:happypaws/common/services/EnumsService.dart';
import 'package:happypaws/common/services/OrdersService.dart';
import 'package:happypaws/common/utilities/toast.dart';
import 'package:happypaws/common/utilities/colors.dart';
import 'package:happypaws/desktop/components/buttons/primary_button.dart';
import 'package:happypaws/desktop/components/confirmationDialog.dart';
import 'package:happypaws/desktop/components/spinner.dart';
import 'package:happypaws/routes/app_router.gr.dart';
import 'package:intl/intl.dart';

@RoutePage()
class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  Map<String, dynamic>? orders;
  dynamic selectedOrder;
  String selectedStatus = '';
  List<dynamic>? orderStatuses;
  bool isLoadingOrder = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    var response = await OrdersService().getPaged('', 1, 9999);
    if (response.statusCode == 200) {
      setState(() {
        orders = response.data;
      });
    }
    var enumsResponse = await EnumsService().getOrderStatuses();
    if (enumsResponse.statusCode == 200) {
      setState(() {
        orderStatuses = enumsResponse.data;
      });
    }
  }

  Future<void> fetchOrder(int id) async {
    setState(() {
      isLoadingOrder = true;
    });
    var response = await OrdersService().get("/$id");
    if (response.statusCode == 200) {
      setState(() {
        selectedOrder = response.data;
        isLoadingOrder=false;
      });
    }
   
  }

  Future<void> changeStatus(String? newValue) async {
    if (newValue == null) return;
    setState(() {
      selectedOrder['status'] = newValue;
    });
    var response =
        await OrdersService().put("/${selectedOrder['id']}/$newValue/${selectedOrder['userId']}", null);
    if (response.statusCode == 200) {
      setState(() {
        selectedStatus = newValue;
      });
      ToastHelper.showToastSuccess(
          context, "You have succesfully updated order status!");
    } else {
      ToastHelper.showToastError(
          context, "An error occured! Please try again.");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (orders == null) {
      return const Spinner();
    } else {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Expanded(
                child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Card(
                      color: Colors.white,
                      surfaceTintColor: Colors.transparent,
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            width: double.infinity,
                            height: 50,
                            child: const Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "New orders",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: orders!['totalCount'],
                            itemBuilder: (context, index) {
                              var order = orders!['items'][index];
                              return Container(
                                decoration: BoxDecoration(
                                  color: order['status'] == "Pending"
                                      ? AppColors.dimWhite
                                      : Colors.transparent,
                                  border: Border(
                                    top:
                                        BorderSide(color: Colors.grey.shade300),
                                    bottom:
                                        BorderSide(color: Colors.grey.shade300),
                                  ),
                                ),
                                padding: const EdgeInsets.all(10),
                                width: double.infinity,
                                height: 80,
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          order['user']['fullName'],
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        Text(
                                          DateFormat('dd/MM/yyyy HH:mm').format(
                                            DateTime.parse(order['createdAt']),
                                          ),
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    PrimaryButton(
                                      onPressed: () {
                                        setState(() {
                                          selectedStatus = order['status'];
                                          fetchOrder(order['id']);
                                        });
                                      },
                                      label: "View details",
                                      width: 140,
                                    )
                                  ],
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    ))),
            const SizedBox(
              width: 20,
            ),
            Expanded(
                child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Card(
                      color: Colors.white,
                      surfaceTintColor: Colors.transparent,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                height: 50,
                                child: const Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Order details",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                              isLoadingOrder ? const Padding(
                                padding: EdgeInsets.only(top:100.0),
                                child: Spinner(),
                              ) :
                              selectedOrder == null
                                  ? const Padding(
                                    padding: EdgeInsets.only(top:100.0),
                                    child: Text(
                                        'Select view details to see order details.'),
                                  )
                                  : Column(
                                      children: [
                                        Row(
                                          children: [
                                            const Text("For: "),
                                            Text(
                                              selectedOrder['user']['fullName'],
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w600),
                                            )
                                          ],
                                        ),
                                        if (selectedOrder['shippingAddress'] !=
                                            null)
                                          Row(
                                            children: [
                                              const Text("Phone number: "),
                                              Text(
                                                selectedOrder["shippingAddress"]
                                                    ['phone'],
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.w600),
                                              )
                                            ],
                                          ),
                                        Row(
                                          children: [
                                            const Text("Payment method: "),
                                            Text(
                                              selectedOrder['paymentMethod']
                                                      [0] +
                                                  selectedOrder['paymentMethod']
                                                      .split(
                                                          RegExp(r'(?=[A-Z])'))
                                                      .join(' ')
                                                      .toLowerCase()
                                                      .substring(1),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w600),
                                            )
                                          ],
                                        ),
                                        const Center(
                                          child: Text(
                                            'Items',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          itemCount:
                                              selectedOrder!['orderDetails']
                                                  .length,
                                          itemBuilder: (context, index) {
                                            final item =
                                                selectedOrder!['orderDetails']
                                                    [index];
                                            return Dismissible(
                                              key: Key(item['id'].toString()),
                                              background: Container(
                                                color: Colors.red,
                                                alignment:
                                                    Alignment.centerRight,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20.0),
                                                child: const Icon(
                                                  Icons.delete_forever_outlined,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              direction:
                                                  DismissDirection.endToStart,
                                              onDismissed: (direction) {
                                                // removeProductFromCart(item['id'], index);
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(16.0),
                                                child: Column(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () => context
                                                          .router
                                                          .push(ProductDetailsRoute(
                                                              productId: item[
                                                                  'productId'])),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                top: 16,
                                                                bottom: 16),
                                                        child: Wrap(
                                                          children: [
                                                            FractionallySizedBox(
                                                                widthFactor:
                                                                    0.3,
                                                                child: Image
                                                                    .memory(
                                                                  base64.decode(item['product']['productImages'][0]
                                                                              [
                                                                              'image']
                                                                          [
                                                                          'data']
                                                                      .toString()),
                                                                  height: 100,
                                                                )),
                                                            FractionallySizedBox(
                                                              widthFactor: 0.5,
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Text(
                                                                    item['product']['name'].length >
                                                                            40
                                                                        ? '${item['product']['name'].substring(0, 40)}...'
                                                                        : item['product']
                                                                            [
                                                                            'name'],
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            16),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  Text(
                                                                    item['product']['brand']
                                                                            [
                                                                            'name']
                                                                        .toUpperCase(),
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            14),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            FractionallySizedBox(
                                                              widthFactor: 0.2,
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  Text(
                                                                    "\$ ${item['product']['price']}",
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            18,
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 20,
                                                                  ),
                                                                  SizedBox(
                                                                      width: 60,
                                                                      height:
                                                                          35,
                                                                      child:
                                                                          Container(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              const Color(0xffF2F2F2),
                                                                          borderRadius:
                                                                              BorderRadius.circular(10),
                                                                        ),
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(item['quantity'].toString()),
                                                                        ),
                                                                      )),
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
                                                              bottom: BorderSide(
                                                                  color: Colors
                                                                      .grey
                                                                      .shade300))),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              'Total: ',
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            Text("\$ ${selectedOrder['total']}",
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w600))
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const Text(
                                              'Update order status: ',
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            SizedBox(
                                                width: 160,
                                                height: 35,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xffF2F2F2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0,
                                                            right: 8),
                                                    child:
                                                        DropdownButton<String>(
                                                      isExpanded: true,
                                                      value: selectedStatus,
                                                      underline: Container(),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      icon: const Icon(
                                                          Icons.arrow_drop_down,
                                                          color: Colors.grey),
                                                      onChanged:
                                                          (String? newValue) {
                                                        if (newValue ==
                                                            "ReadyToPickUp") {
                                                          showDialog(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return ConfirmationDialog(
                                                                title:
                                                                    'Confirmation',
                                                                content:
                                                                    'Once you mark order as ready to be picked up,the buyer will be notified about it. This action can not be undone. Do you wish to proceed?',
                                                                onYesPressed:
                                                                    () {
                                                                  changeStatus(
                                                                      newValue);
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                                onNoPressed:
                                                                    () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                              );
                                                            },
                                                          );
                                                        } else {
                                                          changeStatus(
                                                              newValue);
                                                        }
                                                      },
                                                      items: [
                                                        for (var item
                                                            in orderStatuses!)
                                                          DropdownMenuItem<
                                                              String>(
                                                            value: item['value']
                                                                .toString(),
                                                            child: Text(item[
                                                                        'value']
                                                                    [0] +
                                                                item['value']
                                                                    .split(RegExp(
                                                                        r'(?=[A-Z])'))
                                                                    .join(' ')
                                                                    .toLowerCase()
                                                                    .substring(
                                                                        1)),
                                                          ),
                                                      ],
                                                    ),
                                                  ),
                                                )),
                                          ],
                                        )
                                      ],
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ))),
          ],
        ),
      );
    }
  }
}
