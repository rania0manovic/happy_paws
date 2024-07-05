import 'package:flutter/material.dart';
import 'package:happypaws/common/utilities/colors.dart';
import 'package:happypaws/desktop/components/buttons/primary_button.dart';

// ignore: must_be_immutable
class FilterMenuOverlay extends StatefulWidget {
  final VoidCallback onClose;
  String selectedValuePrice;
  String selectedValueReview;
  final Function(String price, String review) sort;

  FilterMenuOverlay({
    Key? key,
    required this.onClose,
    required this.sort,
    required this.selectedValuePrice,
    required this.selectedValueReview,
  }) : super(key: key);

  @override
  State<FilterMenuOverlay> createState() => _FilterMenuOverlayState();
}

class _FilterMenuOverlayState extends State<FilterMenuOverlay> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: widget.onClose,
          child: Container(
            color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
          ),
        ),
        Positioned(
          top: 10,
          bottom: 10,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: [
                      const IconButton(
                        icon: Icon(Icons.filter_list),
                        onPressed: null,
                        color: Colors.grey,
                      ),
                      const Text(
                        "Filter & sort products",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: widget.onClose,
                        icon: const Icon(Icons.close),
                        color: Colors.grey,
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 16, top: 16),
                    child: Text(
                      "Price",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  priceSorting(),
                  const Padding(
                    padding: EdgeInsets.only(left: 16, top: 16),
                    child: Text(
                      "Customer review",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  reviewFilters(),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Center(
                        child: PrimaryButton(
                      onPressed: () {
                        widget.sort(widget.selectedValuePrice,
                            widget.selectedValueReview);
                      },
                      label: "Apply",
                      width: double.infinity,
                      fontSize: 16,
                    )),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Column reviewFilters() {
    return Column(
      children: [
        RadioListTile<String>(
          activeColor: AppColors.primary,
          title: const Text(
            '1 star & Up',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          value: '1',
          groupValue: widget.selectedValueReview,
          onChanged: (value) {
            setState(() {
              widget.selectedValueReview = value!;
            });
          },
        ),
        RadioListTile<String>(
          activeColor: AppColors.primary,
          title: const Text(
            '2 star & Up',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          value: '2',
          groupValue: widget.selectedValueReview,
          onChanged: (value) {
            setState(() {
              widget.selectedValueReview = value!;
            });
          },
        ),
        RadioListTile<String>(
          activeColor: AppColors.primary,
          title: const Text(
            '3 star & Up',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          value: '3',
          groupValue: widget.selectedValueReview,
          onChanged: (value) {
            setState(() {
              widget.selectedValueReview = value!;
            });
          },
        ),
        RadioListTile<String>(
          activeColor: AppColors.primary,
          title: const Text(
            '4 star & Up',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          value: '4',
          groupValue: widget.selectedValueReview,
          onChanged: (value) {
            setState(() {
              widget.selectedValueReview = value!;
            });
          },
        ),
      ],
    );
  }

  dynamic priceSorting() {
    return Column(
      children: [
        RadioListTile<String>(
          activeColor: AppColors.primary,
          title: const Text(
            'Lowest first',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          value: 'lowest',
          groupValue: widget.selectedValuePrice,
          onChanged: (value) {
            setState(() {
              widget.selectedValuePrice = value!;
            });
          },
        ),
        RadioListTile<String>(
          activeColor: AppColors.primary,
          title: const Text(
            'Highest first',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          value: 'highest',
          groupValue: widget.selectedValuePrice,
          onChanged: (value) {
            setState(() {
              widget.selectedValuePrice = value!;
            });
          },
        ),
      ],
    );
  }
}
