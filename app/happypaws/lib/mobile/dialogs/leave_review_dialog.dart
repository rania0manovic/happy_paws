import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:happypaws/common/services/ProductReviewsService.dart';
import 'package:happypaws/common/utilities/colors.dart';
import 'package:happypaws/common/utilities/toast.dart';
import 'package:happypaws/common/utilities/constants.dart';
import 'package:happypaws/desktop/components/buttons/primary_button.dart';

class LeaveReviewMenu extends StatefulWidget {
  final VoidCallback onClosed;
  final MyVoidCallback onAdd;
  final Map<String, dynamic> data;

  const LeaveReviewMenu({
    super.key,
    required this.onClosed,
    required this.data,
    required this.onAdd,
  });

  @override
  State<LeaveReviewMenu> createState() => _LeaveReviewMenuState();
}

class _LeaveReviewMenuState extends State<LeaveReviewMenu> {
  Map<String, dynamic> data = {};
  @override
  initState() {
    super.initState();
    data['productId'] = widget.data['id'];
  }

  Future<void> leaveReviewForProduct() async {
    try {
      var response = await ProductReviewsService().post('', data);
      if (response.statusCode == 200) {
        widget.onAdd(response.data);
        widget.onClosed();
        if (!mounted) return;
        ToastHelper.showToastSuccess(context,
            "You have successfully left review for the selected product!");
      } else {
        throw Exception('Error occured');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Leave a review",
        style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w500),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            widget.data['name'],
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RatingBar.builder(
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemCount: 5,
              itemSize: 30.0,
              itemBuilder: (context, _) => const Icon(
                Icons.star_rate_rounded,
                color: AppColors.primary,
              ),
              onRatingUpdate: (rating) {
                setState(() {
                  data['review'] = rating.toInt();
                });
              },
            ),
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Text(
                'Note (optional):',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          TextFormField(
            initialValue: data['note'],
            onChanged: (value) => setState(() {
              data['note'] = value;
            }),
            textInputAction: TextInputAction.done,
            minLines: 3,
            maxLines: 3,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
            decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xfff2f2f2),
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: const BorderSide(
                      color: AppColors.primary,
                      width: 5.0,
                    ),
                    borderRadius: BorderRadius.circular(10))),
          ),
          const SizedBox(
            height: 20,
          ),
          PrimaryButton(
            onPressed: () {
              leaveReviewForProduct();
            },
            label: "Leave review",
            width: double.infinity,
          )
        ],
      ),
    );
  }
}
