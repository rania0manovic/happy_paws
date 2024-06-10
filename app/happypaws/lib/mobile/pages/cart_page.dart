import 'dart:convert';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:happypaws/common/services/AuthService.dart';
import 'package:happypaws/common/services/UserCartsService.dart';
import 'package:happypaws/common/utilities/colors.dart';
import 'package:happypaws/common/utilities/toast.dart';
import 'package:happypaws/desktop/components/buttons/go_back_button.dart';
import 'package:happypaws/desktop/components/buttons/primary_button.dart';
import 'package:happypaws/desktop/components/spinner.dart';
import 'package:happypaws/routes/app_router.gr.dart';

@RoutePage()
class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  Map<String, dynamic>? products;
  bool unableToOrder = false;
  String total = "0.00";
  @override
  initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      var user = await AuthService().getCurrentUser();
      if (user != null) {
        var response = await UserCartsService()
            .getPaged('', 1, 999, searchObject: {'userId': user['Id']});
        if (response.statusCode == 200) {
          if (response.data['items']
              .any((e) => e['quantity'] > e['product']['inStock'] as bool || e['product']['isActive']==false)) {
            setState(() {
              unableToOrder = true;
            });
            ToastHelper.showToastError(context,
                "One or more products are out of stock or not being sold anymore. You won't be able to complete your order unless you remove them from cart or wait until they're back in stock.");
          }
          setState(() {
            products = response.data;
            total = products!['items']
                .fold<double>(
                    0.0,
                    (previousValue, item) => previousValue +
                        (item['product']['price'] * item['quantity']) as double)
                .toStringAsFixed(2);
          });
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> removeProductFromCart(int id, int index) async {
    try {
      var response = await UserCartsService().delete('/$id');
      if (response.statusCode == 200) {
        if (!mounted) return;
        ToastHelper.showToastSuccess(
            context, "You have successfully removed product from the cart!");
        setState(() {
          products!['items'].removeAt(index);
          products!['totalCount']-=1;
        });
      } else {
        if (!mounted) return;
        ToastHelper.showToastError(
            context, "Something went wrong! Please try again.");
      }
    } catch (e) {
      ToastHelper.showToastError(
          context, "An error has occured! Please try again later.");
      rethrow;
    }
  }

  Future<void> updateQuantity(int id, String? quantity) async {
    try {
      var response =
          await UserCartsService().put('', {'id': id, 'quantity': quantity});
      if (response.statusCode == 200) {
        setState(() {
          products!['items']
                  .firstWhere((element) => element['id'] == id)['quantity'] =
              int.parse(quantity!);
          total = products!['items']
              .fold<double>(
                  0.0,
                  (previousValue, item) => previousValue +
                      (item['product']['price'] * item['quantity']) as double)
              .toStringAsFixed(2);
        });
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return products == null
        ? const Expanded(child: Spinner())
        : Padding(
            padding: const EdgeInsets.all(14),
            child: Stack(children: [
              const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GoBackButton(),
                    Center(
                      child: Text(
                        'CART',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(
                      height: 14,
                    ),
                  ]),
              Positioned(
                top: 100,
                left: 0,
                right: 0,
                bottom: 130,
                child: products!['items'].isEmpty
                    ? const Center(
                        child: Text(
                        "No products in the cart yet!",
                        style: TextStyle(fontSize: 20),
                      ))
                    : ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: products!['totalCount'],
                        itemBuilder: (context, index) {
                          final item = products!['items'][index];
                          return Dismissible(
                            key: Key(item['id'].toString()),
                            background: Container(
                              color: Colors.red,
                              alignment: Alignment.centerRight,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: const Icon(
                                Icons.delete_forever_outlined,
                                color: Colors.white,
                              ),
                            ),
                            direction: DismissDirection.endToStart,
                            onDismissed: (direction) {
                              removeProductFromCart(item['id'], index);
                            },
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () => context.router.push(
                                      ProductDetailsRoute(
                                          productId: item['productId'])),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 5),
                                    child: Wrap(
                                      children: [
                                        FractionallySizedBox(
                                            widthFactor: 0.3,
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Image.memory(
                                                base64.decode(item['product']
                                                            ['productImages'][0]
                                                        ['image']['data']
                                                    .toString()),
                                                height: 100,
                                              ),
                                            )),
                                        FractionallySizedBox(
                                          widthFactor: 0.48,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                item['product']['name'].length >
                                                        40
                                                    ? '${item['product']['name'].substring(0, 40)}...'
                                                    : item['product']['name'],
                                                style: const TextStyle(
                                                    fontSize: 16),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                item['product']['brand']['name']
                                                    .toUpperCase(),
                                                style: const TextStyle(
                                                    fontSize: 14),
                                              ),
                                            ],
                                          ),
                                        ),
                                        FractionallySizedBox(
                                          widthFactor: 0.22,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                "\$ ${item['product']['price']}",
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              SizedBox(
                                                  width: 60,
                                                  height: 35,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: const Color(
                                                          0xffF2F2F2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: Center(
                                                      child: DropdownButton<
                                                          String>(
                                                        value: item['quantity']
                                                            .toString(),
                                                        underline: Container(),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        icon: const Icon(
                                                            Icons
                                                                .arrow_drop_down,
                                                            color: Colors.grey),
                                                        onChanged:
                                                            (String? newValue) {
                                                          updateQuantity(
                                                              item['id'],
                                                              newValue);
                                                        },
                                                        items: <String>[
                                                          '1',
                                                          '2',
                                                          '3',
                                                          '4',
                                                        ].map<
                                                            DropdownMenuItem<
                                                                String>>((String
                                                            value) {
                                                          return DropdownMenuItem<
                                                              String>(
                                                            value: value,
                                                            child: Text(value,
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500)),
                                                          );
                                                        }).toList(),
                                                      ),
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                if (item['product']['inStock'] <
                                    item['quantity'])
                                  const Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "Out of stock",
                                        style:
                                            TextStyle(color: AppColors.error),
                                      )
                                    ],
                                  )
                                  else if (item['product']['isActive']==false )
                                  const Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "Not being sold anymore",
                                        style:
                                            TextStyle(color: AppColors.error),
                                      )
                                    ],
                                  ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey.shade300))),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
              Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 110,
                    color: Colors.white,
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total',
                              style: TextStyle(fontSize: 20),
                            ),
                            // ignore: prefer_interpolation_to_compose_strings
                            Text(
                                "\$ ${products!['items'].isNotEmpty ? total : "0.00"}",
                                style: const TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.w600))
                          ],
                        ),
                      ),
                      PrimaryButton(
                        disabledWithoutSpinner: unableToOrder,
                        onPressed: () {
                          if (unableToOrder) return;
                          if (products!['items'].isEmpty) return;
                          context.router.push(
                              CheckoutRoute(total: total, products: products!));
                        },
                        label: "Order",
                        fontSize: 22,
                        width: double.infinity,
                      )
                    ]),
                  ))
            ]),
          );
  }
}
