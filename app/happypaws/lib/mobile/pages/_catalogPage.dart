import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:happypaws/common/services/ProductsService.dart';
import 'package:happypaws/desktop/components/spinner.dart';
import 'package:happypaws/routes/app_router.gr.dart';

@RoutePage()
class CatalogPage extends StatefulWidget {
  const CatalogPage(
      {super.key,
      @PathParam('categoryId') this.categoryId,
      @PathParam('subcategoryId') this.subcategoryId,
      this.categoryPhoto,
      this.categoryName,
      this.subcategoryName,
      this.searchInput});

  final int? categoryId;
  final int? subcategoryId;
  final String? categoryPhoto;
  final String? categoryName;
  final String? subcategoryName;
  final String? searchInput;

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  late String selectedValuePrice = "option0";
  late String selectedValueReview = "0";
  List<bool> selectedOptions = [false, false, false, false, false, false];
  List<Map<String, dynamic>>? products;
  Map<String, dynamic> params = {};

  @override
  void initState() {
    super.initState();
      setState(() {
        params['categoryId'] = widget.categoryId?.toString();
        params['subcategoryId'] = widget.subcategoryId?.toString();
        params['takePhotos'] = "1";
        params['productOrBrandName'] = widget.searchInput;

      });
    fetchData();
  }

  Future<void> fetchData() async {
    var response =
        await ProductsService().getPaged('', 1, 999, searchObject: params);
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(response.body);
      setState(() {
        products = List<Map<String, dynamic>>.from(jsonData['items']);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (products == null) {
      return const Spinner();
    } else {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => context.router.pop(),
                  child: const Padding(
                    padding: EdgeInsets.only(bottom: 14.0),
                    child: Text(
                      'Go back',
                      style: TextStyle(
                          fontFamily: 'GilroyLight',
                          fontWeight: FontWeight.w300,
                          fontSize: 16),
                    ),
                  ),
                ),
                if (widget.categoryName != null && widget.categoryPhoto != null)
                  header(context),
                productsSection(),
              ]),
        ),
      );
    }
  }

  void _showFilterMenu(BuildContext context) {
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => Material(
        color: Colors.transparent,
        child: FilterMenuOverlay(
          selectedValuePrice: selectedValuePrice,
          selectedValueReview: selectedValueReview,
          selectedOptions: selectedOptions,
          onClose: () {
            overlayEntry.remove();
          },
          onPriceFilterChanged: (value) {
            overlayEntry.markNeedsBuild();
            setState(() {
              selectedValuePrice = value;
            });
          },
          onReviewFilterChanged: (value) {
            overlayEntry.markNeedsBuild();
            setState(() {
              selectedValueReview = value;
            });
          },
          onBrandChanged: (option, position) {
            overlayEntry.markNeedsBuild();
            setState(() {
              selectedOptions[position] = option;
            });
          },
        ),
      ),
    );

    Overlay.of(context).insert(overlayEntry);
  }

  Wrap productsSection() {
    return Wrap(
      direction: Axis.horizontal,
      children: [
        if (products != null)
          // TODO: Add pagination
          for (var item in products!)
            GestureDetector(
              onTap: () => context.router
                  .push(ProductDetailsRoute(productId: item['id'])),
              child: FractionallySizedBox(
                widthFactor: 0.5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 250,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.memory(
                            base64.decode(
                                item['productImages'][0]['image']['data']),
                            height: 180),
                        Text(
                          item['name'].length > 40
                              ? '${item['name'].substring(0, 40)}...'
                              : item['name'],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 15,
                              fontFamily: "GilroyLight",
                              fontWeight: FontWeight.w300),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "\$ ${item['price']}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 16),
                            ),
                            // TODO: Implement stars to match product reviews
                            const Row(
                              children: [
                                Image(
                                  image: AssetImage("assets/images/star.png"),
                                  height: 14,
                                  width: 14,
                                ),
                                Image(
                                  image: AssetImage("assets/images/star.png"),
                                  height: 14,
                                  width: 14,
                                ),
                                Image(
                                  image: AssetImage("assets/images/star.png"),
                                  height: 14,
                                  width: 14,
                                ),
                                Image(
                                  image: AssetImage("assets/images/star.png"),
                                  height: 14,
                                  width: 14,
                                ),
                                Image(
                                  image: AssetImage(
                                      "assets/images/star-half-empty.png"),
                                  height: 14,
                                  width: 14,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        if (products != null && products!.isEmpty)
          const Padding(
            padding: EdgeInsets.only(top: 36.0),
            child: Center(child: Text( 'We found no products in this category')),
          )
      ],
    );
  }

  Row header(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Image.memory(base64.decode(widget.categoryPhoto.toString()), height: 55),
      Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Text(
          widget.categoryName!,
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 0),
        child: Text(
          " / ${widget.subcategoryName}",
          style: const TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 14,
              fontFamily: "GilroyLight"),
        ),
      ),
      const Spacer(),
      IconButton(
        icon: const Icon(Icons.filter_list),
        onPressed: () {
          _showFilterMenu(context);
        },
        color: Colors.grey,
      ),
    ]);
  }
}

class FilterMenuOverlay extends StatefulWidget {
  final String selectedValuePrice;
  final String selectedValueReview;
  final List<bool> selectedOptions;
  final Function(String) onPriceFilterChanged;
  final Function(String) onReviewFilterChanged;
  final Function(bool option, int position) onBrandChanged;
  final VoidCallback onClose;

  const FilterMenuOverlay({
    Key? key,
    required this.selectedValuePrice,
    required this.selectedOptions,
    required this.onPriceFilterChanged,
    required this.onBrandChanged,
    required this.onClose,
    required this.selectedValueReview,
    required this.onReviewFilterChanged,
  }) : super(key: key);

  @override
  _FilterMenuOverlayState createState() => _FilterMenuOverlayState();
}

//TODO: Implement filters
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
          top: 50,
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
                          fontFamily: 'GilroyLight',
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
                      "Brands",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  brandFilters(),
                  const Padding(
                    padding: EdgeInsets.only(left: 16, top: 16),
                    child: Text(
                      "Customer review",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  reviewFilters(),
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
          activeColor: const Color(0xff3F0D84),
          title: const Text(
            '1 star & Up',
            style: TextStyle(
              fontSize: 16,
              fontFamily: "GilroyLight",
              fontWeight: FontWeight.w400,
            ),
          ),
          value: '1',
          groupValue: widget.selectedValueReview,
          onChanged: (value) {
            widget.onReviewFilterChanged(value!);
          },
        ),
        RadioListTile<String>(
          activeColor: const Color(0xff3F0D84),
          title: const Text(
            '2 star & Up',
            style: TextStyle(
              fontSize: 16,
              fontFamily: "GilroyLight",
              fontWeight: FontWeight.w400,
            ),
          ),
          value: '2',
          groupValue: widget.selectedValueReview,
          onChanged: (value) {
            widget.onReviewFilterChanged(value!);
          },
        ),
        RadioListTile<String>(
          activeColor: const Color(0xff3F0D84),
          title: const Text(
            '3 star & Up',
            style: TextStyle(
              fontSize: 16,
              fontFamily: "GilroyLight",
              fontWeight: FontWeight.w400,
            ),
          ),
          value: '3',
          groupValue: widget.selectedValueReview,
          onChanged: (value) {
            widget.onReviewFilterChanged(value!);
          },
        ),
        RadioListTile<String>(
          activeColor: const Color(0xff3F0D84),
          title: const Text(
            '4 star & Up',
            style: TextStyle(
              fontSize: 16,
              fontFamily: "GilroyLight",
              fontWeight: FontWeight.w400,
            ),
          ),
          value: '4',
          groupValue: widget.selectedValueReview,
          onChanged: (value) {
            widget.onReviewFilterChanged(value!);
          },
        ),
      ],
    );
  }

  Column brandFilters() {
    return Column(
      children: [
        CheckboxListTile(
          activeColor: const Color(0xff3F0D84),
          title: const Text('Aquariana'),
          value: widget.selectedOptions[0],
          onChanged: (value) {
            widget.onBrandChanged(value!, 0);
          },
        ),
        CheckboxListTile(
          activeColor: const Color(0xff3F0D84),
          title: const Text('King British'),
          value: widget.selectedOptions[1],
          onChanged: (value) {
            widget.onBrandChanged(value!, 1);
          },
        ),
        CheckboxListTile(
          activeColor: const Color(0xff3F0D84),
          title: const Text('Tetra'),
          value: widget.selectedOptions[2],
          onChanged: (value) {
            widget.onBrandChanged(value!, 2);
          },
        ),
      ],
    );
  }

  Row priceSorting() {
    return Row(
      children: [
        Expanded(
          child: RadioListTile<String>(
            activeColor: const Color(0xff3F0D84),
            title: const Text(
              'Highest',
              style: TextStyle(
                fontSize: 16,
                fontFamily: "GilroyLight",
                fontWeight: FontWeight.w400,
              ),
            ),
            value: 'option1',
            groupValue: widget.selectedValuePrice,
            onChanged: (value) {
              widget.onPriceFilterChanged(value!);
            },
          ),
        ),
        Expanded(
          child: RadioListTile<String>(
            activeColor: const Color(0xff3F0D84),
            title: const Text(
              'Lowest',
              style: TextStyle(
                fontSize: 16,
                fontFamily: "GilroyLight",
                fontWeight: FontWeight.w400,
              ),
            ),
            value: 'option2',
            groupValue: widget.selectedValuePrice,
            onChanged: (value) {
              widget.onPriceFilterChanged(value!);
            },
          ),
        ),
      ],
    );
  }
}
