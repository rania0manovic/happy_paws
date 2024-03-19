import 'dart:convert';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:happypaws/common/services/AuthService.dart';
import 'package:happypaws/common/services/UserCartsService.dart';
import 'package:happypaws/common/utilities/Toast.dart';
import 'package:happypaws/common/utilities/colors.dart';
import 'package:happypaws/desktop/components/buttons/GoBackButton.dart';
import 'package:happypaws/desktop/components/spinner.dart';
import 'package:happypaws/routes/app_router.gr.dart';

@RoutePage()
class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Map<String, dynamic>>? products;

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
          if (response.statusCode == 200) {
            Map<String, dynamic> jsonData = json.decode(response.body);
            setState(() {
              products = List<Map<String, dynamic>>.from(jsonData['items']);
            });
          }
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
          products!.removeAt(index);
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
          products!.firstWhere((element) => element['id'] == id)['quantity'] =
              int.parse(quantity!);
        });
      }
    } catch (e) {
      rethrow;
    }
  }

  List<String> items = List.generate(20, (index) => 'Item ${index + 1}');
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
                        style: TextStyle(fontSize: 20),
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
                bottom: 170,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: products!.length,
                  itemBuilder: (context, index) {
                    final item = products![index];
                    return Dismissible(
                      key: Key(item['id'].toString()),
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                              padding:
                                  const EdgeInsets.only(top: 16, bottom: 16),
                              child: Wrap(
                                children: [
                                  FractionallySizedBox(
                                      widthFactor: 0.3,
                                      child: Image.memory(
                                        base64.decode(item['product']
                                                    ['productImages'][0]
                                                ['image']['data']
                                            .toString()),
                                        height: 100,
                                      )),
                                  FractionallySizedBox(
                                    widthFactor: 0.5,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                        Text(
                                          item['product']['brand']['name']
                                              .toUpperCase(),
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ),
                                  FractionallySizedBox(
                                    widthFactor: 0.2,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          "\$ ${item['product']['price']}",
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        SizedBox(
                                            width: 60,
                                            height: 35,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: const Color(0xffF2F2F2),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Center(
                                                child: DropdownButton<String>(
                                                  value: item['quantity']
                                                      .toString(),
                                                  underline: Container(),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  icon: const Icon(
                                                      Icons.arrow_drop_down,
                                                      color: Colors.grey),
                                                  onChanged:
                                                      (String? newValue) {
                                                    updateQuantity(
                                                        item['id'], newValue);
                                                  },
                                                  items: <String>[
                                                    '1',
                                                    '2',
                                                    '3',
                                                    '4',
                                                  ].map<
                                                          DropdownMenuItem<
                                                              String>>(
                                                      (String value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: value,
                                                      child: Text(value,
                                                          style: const TextStyle(
                                                              fontSize: 18,
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
                    height: 160,
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
                            Text(
                                '\$ ${products!.map<double>((item) => item['product']['price'] * item['quantity']).reduce((value, element) => value + element).toStringAsFixed(2)}',
                                style: const TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.w600))
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                            child: Text(
                          'Order',
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        )),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color(0xffffc439),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Image(
                            image: AssetImage('assets/images/paypallogo.png'),
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      )
                    ]),
                  ))
            ]),
          );
  }
}
