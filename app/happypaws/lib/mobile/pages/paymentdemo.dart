import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';


class PaypalPaymentDemo extends StatelessWidget {
  const PaypalPaymentDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
          child: TextButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => PaypalCheckoutView(
                  sandboxMode: true,
                  clientId: "AUdRuKmxdwt_O1PPfnFp1kan3Cpgo0M5L8ngrto9FnEL4qH17_YyscwRtyeqOEZS6Iks5T5p6BpgyL6r",
                  secretKey: "EIx9tBEJjPWxzG3d4PhXGfgPfkObJH79EkxCMoTWZ-xCHQmpEsiEgBz5BJVnWlqD-CpdRhn2om20O8hW",
                  transactions: const [
                    {
                      "amount": {
                        "total": '10',
                        "currency": "USD",
                        "details": {
                          "subtotal": '10',
                          "shipping": '0',
                          "shipping_discount": 0
                        }
                      },
                      "description": "The payment transaction description.",
                      "item_list": {
                        "items": [
                          {
                            "name": "Apple",
                            "quantity": 4,
                            "price": '1',
                            "currency": "USD"
                          },
                          {
                            "name": "Pineapple",
                            "quantity": 6,
                            "price": '1',
                            "currency": "USD"
                          }
                        ],
                      }
                    }
                  ],
                  note: "Contact us for any questions on your order.",
                  onSuccess: (Map params) async {
                    log("onSuccess: $params");
                    Navigator.pop(context);
                  },
                  onError: (error) {
                    log("onError: $error");
                    Navigator.pop(context);
                  },
                  onCancel: () {
                    print('cancelled:');
                    Navigator.pop(context);
                  },
                ),
              ));
            },
            child: const Text('Pay with paypal'),
          ),
        );
  }
}