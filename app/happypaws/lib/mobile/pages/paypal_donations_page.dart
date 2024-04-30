import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:happypaws/common/utilities/constants.dart';
import 'package:happypaws/common/utilities/toast.dart';
import 'package:happypaws/desktop/components/spinner.dart';

@RoutePage()
class PaypalDonationsPage extends StatefulWidget {
  final String total;
  final MyVoidCallback onSuccess;
  const PaypalDonationsPage(
      {super.key, required this.total, required this.onSuccess});

  @override
  State<PaypalDonationsPage> createState() => _PaypalDonationsPageState();
}

class _PaypalDonationsPageState extends State<PaypalDonationsPage> {
  @override
  Widget build(BuildContext context) {
    return PaypalCheckoutView(
      loadingIndicator: const Spinner(),
      sandboxMode: true,
      clientId:
          "AZBGOkwWpWvpU0lloi3WB5D4Nh2X42Bedbjy3ZeS03aTWeg4uk3t_Y6p2-olAWkyrQm8qnhc4ZDA9liD",
      secretKey:
          "EBZdGI4rH9DVgOkpAAHHidsQ8MDof_bNgLUQpXy8xxsNY4Sz3_MRTzkqVLyZ2r2EAeO1GcnSBL5RtzCp",
      transactions: [
        {
          "amount": {
            "total": widget.total,
            "currency": "USD",
            "details": {
              "subtotal": widget.total,
              "shipping": '0',
              "shipping_discount": 0
            }
          },
          "description": "",
          "item_list": {
            "items": [
              {
                "name": "Donation",
                "quantity": 1,
                "price": widget.total,
                "currency": "USD"
              },
            ],
          }
        }
      ],
      note: "Contact us for any questions on your payment.",
      onSuccess: (Map params) async {
        Navigator.pop(context);
        widget.onSuccess(params);
      },
      onError: (error) {
        if (error['data']['name'] == "VALIDATION_ERROR") {
          ToastHelper.showToastError(
              context, 'Input must be a number! (e.g. 10 or 10.50)');
        } else {
          ToastHelper.showToastError(
              context, "An error occursed. Please try again later!");
        }
        Navigator.pop(context);
      },
      onCancel: () {
        Navigator.pop(context);
      },
    );
  }
}
