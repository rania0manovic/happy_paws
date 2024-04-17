import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:happypaws/common/services/OrdersService.dart';
import 'package:happypaws/common/services/UserAdressesService.dart';
import 'package:happypaws/common/utilities/Toast.dart';
import 'package:happypaws/common/utilities/colors.dart';
import 'package:happypaws/desktop/components/buttons/go_back_button.dart';
import 'package:happypaws/desktop/components/buttons/primary_button.dart';
import 'package:happypaws/desktop/components/confirmationDialog.dart';
import 'package:happypaws/desktop/components/spinner.dart';
import 'package:happypaws/mobile/components/input_field.dart';
import 'package:happypaws/routes/app_router.gr.dart';

@RoutePage()
class CheckoutPage extends StatefulWidget {
  final double total;
  final  Map<String, dynamic> products;
  const CheckoutPage({super.key, required this.total, required this.products});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  bool isShipping = false;
  bool isSavedAddress = false;
  bool isLoading = false;
  bool saveAsInitialAddress = false;
  Map<String, dynamic> data = {};

  @override
  initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      var response = await UserAddressesService().getPaged('', 1, 1);
      if (response.statusCode == 200 && response.data['totalCount'] > 0) {
        setState(() {
          data = response.data['items'][0];
          isSavedAddress = true;
          data['shippingAddressId'] = data['id'];
          saveAsInitialAddress = data['isInitialUserAddress'];
        });
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> placePickAtStoreOrder() async {
    try {
      setState(() {
        isLoading = true;
      });
      data['orderDate'] = DateTime.now().toIso8601String();
      data['paymentMethod'] = "InStore";
      data['total'] = widget.total;
      data['shippingAddressId'] = null;
      var response = await OrdersService().post('', data);
      if (response.statusCode == 200) {
        setState(() {
          isLoading = false;
          ToastHelper.showToastSuccess(
              context, "Your order has been successfully created!");
        });
      }
    } catch (e) {}
  }
    Future<void> placePaypalOrder(dynamic payId) async {
    try {
      setState(() {
        isLoading = true;
      });
      data['orderDate'] = DateTime.now().toIso8601String();
      data['paymentMethod'] = "Paypal";
      data['total'] = widget.total;
      data['payId'] =payId;
      var response = await OrdersService().post('', data);
      if (response.statusCode == 200) {
        setState(() {
          isLoading = false;
          ToastHelper.showToastSuccess(
              context, "Your order has been successfully created!");
              context.router.push(OrderHistoryRoute());
        });
      }
    } catch (e) {}
  }

  Future<void> addUserAddress() async {
    try {
      if (data['id'] != null &&
          saveAsInitialAddress &&
          data['isInitialUserAddress']) {
        var response = await UserAddressesService().put('', data);
        if (response.statusCode == 200) {
          setState(() {
            data['shippingAddressId'] = data['id'];
            isSavedAddress = true;
          });
        }

        return;
      }
      var response = await UserAddressesService().post('', data);
      if (response.statusCode == 200) {
        setState(() {
          data['shippingAddressId'] = response.data['id'];
          isSavedAddress = true;
        });
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 403) {
        ToastHelper.showToastError(context,
            "Only fields marked as optional are not required! Please fill out all required fields.");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Spinner()
        : SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const GoBackButton(),
                  const SizedBox(
                    height: 10,
                  ),
                  //   Text(
                  //   "Total:${widget.total}\$",
                  //   style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                  // ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Pay method",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  PrimaryButton(
                    onPressed: () {
                      setState(() {
                        isShipping = false;
                      });
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return ConfirmationDialog(
                            title: 'Order confirmation',
                            content:
                                'You will be notified once your order is ready to be picked up at the store and you will have 7 days to pick it up before it is marked as cancelled and discarded. Do you wish to place this order?',
                            onYesPressed: () {
                              Navigator.of(context).pop();
                              placePickAtStoreOrder();
                            },
                            onNoPressed: () {
                              Navigator.of(context).pop();
                            },
                          );
                        },
                      );
                    },
                    label: "Pick up and pay at store",
                    width: double.infinity,
                    fontSize: 20,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  PrimaryButton(
                    onPressed: () {
                      setState(() {
                        isShipping = true;
                      });
                    },
                    label: "Ship at home address",
                    width: double.infinity,
                    fontSize: 20,
                    backgroundColor: AppColors.primary.withOpacity(0.9),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Visibility(
                    visible: isShipping,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Shipping Address",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w700),
                        ),
                        Visibility(
                          visible: !isSavedAddress,
                          child: Column(
                            children: [
                              InputField(
                                label: 'Full Name:',
                                onChanged: (value) => setState(
                                  () {
                                    data['fullName'] = value;
                                  },
                                ),
                                initialValue: data['fullName'],
                              ),
                              InputField(
                                label: 'Address Line 1:',
                                onChanged: (value) => setState(() {
                                  data['addressOne'] = value;
                                }),
                                initialValue: data['addressOne'],
                              ),
                              InputField(
                                label: 'Address Line 2 (optional):',
                                onChanged: (value) => setState(() {
                                  data['addressTwo'] = value;
                                }),
                                initialValue: data['addressTwo'],
                              ),
                              InputField(
                                label: 'Country:',
                                onChanged: (value) => setState(() {
                                  data['country'] = value;
                                }),
                                initialValue: data['country'],
                              ),
                              InputField(
                                label: 'City:',
                                onChanged: (value) => setState(() {
                                  data['city'] = value;
                                }),
                                initialValue: data['city'],
                              ),
                              InputField(
                                label: 'Postal Code:',
                                onChanged: (value) => setState(() {
                                  data['postalCode'] = value;
                                }),
                                initialValue: data['postalCode'],
                              ),
                              InputField(
                                label: 'Phone:',
                                onChanged: (value) => setState(() {
                                  data['phone'] = value;
                                }),
                                initialValue: data['phone'],
                              ),
                              InputField(
                                label: 'Note (optional):',
                                onChanged: (value) => setState(() {
                                  data['note'] = value;
                                }),
                                initialValue: data['note'],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Transform.scale(
                                    scale: 1.3,
                                    child: Checkbox(
                                      activeColor: AppColors.primary,
                                      value: saveAsInitialAddress,
                                      visualDensity: VisualDensity.compact,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          saveAsInitialAddress = value!;
                                        });
                                      },
                                    ),
                                  ),
                                  const Text(
                                    "Save as initial address",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                        if (data.isNotEmpty)
                          Visibility(
                            visible: isSavedAddress,
                            child: Opacity(
                              opacity: 0.7,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data['fullName'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Text(
                                    data['addressOne'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                    ),
                                  ),
                                  if (data['addressTwo'] != null &&
                                      data['addressTwo'] != "")
                                    Text(
                                      data['addressTwo'],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                      ),
                                    ),
                                  Text(
                                    data['country'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Text(
                                    data['city'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Text(
                                    data['postalCode'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Text(
                                    data['phone'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                    ),
                                  ),
                                  if (data['note'] != null &&
                                      data['note'] != "")
                                    Text(
                                      data['addressTwo'],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                      ),
                                    ),
                                  GestureDetector(
                                    onTap: () => setState(() {
                                      isSavedAddress = false;
                                    }),
                                    child: const Text(
                                      "Change address",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18,
                                          decoration: TextDecoration.underline,
                                          color: AppColors.primary),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  )
                                ],
                              ),
                            ),
                          ),
                        Visibility(
                          visible: !isSavedAddress,
                          child: PrimaryButton(
                            onPressed: () {
                              addUserAddress();
                            },
                            label: "Go pay",
                            fontSize: 22,
                            width: double.infinity,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Visibility(
                          visible: data['shippingAddressId'] != null &&
                              isSavedAddress,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    PaypalCheckoutView(
                                  sandboxMode: true,
                                  clientId:
                                      "AUdRuKmxdwt_O1PPfnFp1kan3Cpgo0M5L8ngrto9FnEL4qH17_YyscwRtyeqOEZS6Iks5T5p6BpgyL6r",
                                  secretKey:
                                      "EIx9tBEJjPWxzG3d4PhXGfgPfkObJH79EkxCMoTWZ-xCHQmpEsiEgBz5BJVnWlqD-CpdRhn2om20O8hW",
                                  transactions:  [
                                    {
                                      "amount": {
                                        "total": widget.total.toString(),
                                        "currency": "USD",
                                        "details": {
                                          "subtotal": widget.total.toString(),
                                          "shipping": '0',
                                          "shipping_discount": 0
                                        }
                                      },
                                      "description":
                                          "",
                                      "item_list": {
                                        "items": [
                                        for(var item in widget.products['items'])
                                          {
                                            "name": item['product']['name'],
                                            "quantity": item['quantity'],
                                            "price": item['product']['price'],
                                            "currency": "USD"
                                          },
                                         
                                        ],
                                      }
                                    }
                                  ],
                                  note:
                                      "Contact us for any questions on your order.",
                                  onSuccess: (Map params) async {
                                    Navigator.pop(context);
                                    placePaypalOrder(params['id']);
                                  },
                                  onError: (error) {
                                    log("onError: $error");
                                    Navigator.pop(context);
                                  },
                                  onCancel: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ));
                            },
                            child: Container(
                              width: double.infinity,
                              height: 50,
                              decoration: BoxDecoration(
                                color: const Color(0xffffc439),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Image(
                                  image: AssetImage(
                                      'assets/images/paypallogo.png'),
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
