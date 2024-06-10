import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:happypaws/common/services/AuthService.dart';
import 'package:happypaws/common/services/DonationsService.dart';
import 'package:happypaws/common/utilities/colors.dart';
import 'package:happypaws/common/utilities/toast.dart';
import 'package:happypaws/desktop/components/buttons/go_back_button.dart';
import 'package:happypaws/desktop/components/input_field.dart';
import 'package:happypaws/desktop/components/spinner.dart';

@RoutePage()
class DonatePage extends StatefulWidget {
  const DonatePage({super.key});

  @override
  State<DonatePage> createState() => _DonatePageState();
}

class _DonatePageState extends State<DonatePage> {
  String total = "10.00";
  bool isLoading = false;
  Map<String, dynamic> data = {};
  bool success = false;

  @override
  initState() {
    super.initState();
    getUser();
  }

  Future getUser() async {
    var user = await AuthService().getCurrentUser();
    if (user != null) {
      setState(() {
        data['userId'] = user['Id'];
      });
    }
  }

  Future<void> saveDonation(dynamic payId) async {
    try {
      setState(() {
        isLoading = true;
      });
      data['total'] = total;
      var response = await DonationsService().post('', data);
      if (response.statusCode == 200) {
        setState(() {
          isLoading = false;
          success = true;
          ToastHelper.showToastSuccess(
              context, "Your donation has been succesfully made!");
        });
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: SizedBox(
          child: isLoading
              ? const Spinner()
              : success
                  ? const Column(
                      children: [
                        GoBackButton(),
                        SizedBox(
                          height: 100,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 40),
                          child: Image(
                              image: AssetImage("assets/images/happydog.jpg")),
                        ),
                        Text(
                          'Thank you for for helping us help them!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w600),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        const GoBackButton(),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 40),
                          child: Image(
                              image: AssetImage("assets/images/donate.png")),
                        ),
                        const Text(
                          'Help save a life, donate today!',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w600),
                        ),
                        InputField(
                          label: 'Amount you wish to donate (in \$):',
                          fillColor: AppColors.dimWhite,
                          onChanged: (value) {
                            if (double.tryParse(value) != null) {
                              setState(() {
                                total = double.parse(value).toStringAsFixed(2);
                              });
                            } else {
                              setState(() {
                                total = '';
                              });
                              ToastHelper.showToastError(context,
                                  'Input must be a number! (e.g. 10 or 10.50)');
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                       
                        //TODO: figure out why paypal checkout won't work on home page but works on shop page (layout/chromium issue??)
                        GestureDetector(
                          onTap: () {
                             Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    PaypalCheckoutView(
                                  sandboxMode: true,
                                  clientId:
                                      "AZBGOkwWpWvpU0lloi3WB5D4Nh2X42Bedbjy3ZeS03aTWeg4uk3t_Y6p2-olAWkyrQm8qnhc4ZDA9liD",
                                  secretKey:
                                      "EBZdGI4rH9DVgOkpAAHHidsQ8MDof_bNgLUQpXy8xxsNY4Sz3_MRTzkqVLyZ2r2EAeO1GcnSBL5RtzCp",
                                  transactions: [
                                    {
                                      "amount": {
                                        "total": total,
                                        "currency": "USD",
                                        "details": {
                                          "subtotal": total,
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
                                            "price": double.parse(total),
                                            "currency": "USD"
                                          },
                                        ],
                                      }
                                    }
                                  ],
                                  note:
                                      "Contact us for any questions on your payment.",
                                  onSuccess: (Map params) async {
                                    Navigator.pop(context);
                                    saveDonation(params['data']['id']);

                                  },
                                  onError: (error) {
                                  
                                      ToastHelper.showToastError(context,
                                          "An error occursed. Please try again later!");
                                    
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
                                image:
                                    AssetImage('assets/images/paypallogo.png'),
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
        ),
      ),
    );
  }
}
