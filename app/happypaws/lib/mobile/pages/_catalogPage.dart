import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class CatalogPage extends StatefulWidget {
  const CatalogPage({super.key});
  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  late String selectedValuePrice = "option0";
  late String selectedValueReview= "0";
  List<bool> selectedOptions = [false, false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        header(context),
        productsSection(),
      ]),
    );
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
            overlayEntry
                .markNeedsBuild(); 
            setState(() {
              selectedValuePrice = value;
            });
          },
          onReviewFilterChanged: (value) {
            overlayEntry
                .markNeedsBuild(); 
            setState(() {
              selectedValueReview = value;
            });
          },
          onBrandChanged: (option,position) {
            overlayEntry
                .markNeedsBuild(); 
            setState(() {
              selectedOptions[position] = option;
            });
          }, 
        ),
      ),
    );

    Overlay.of(context)?.insert(overlayEntry);
  }

  Wrap productsSection() {
    return const Wrap(
      direction: Axis.horizontal,
      children: [
        FractionallySizedBox(
          widthFactor: 0.5,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: SizedBox(
              height: 250,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image(
                    image: AssetImage(
                      "assets/images/fishfood1.jpg",
                    ),
                    height: 180,
                  ),
                  Text(
                    "Aquariana tropical & temperate flake food",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: "GilroyLight",
                        fontWeight: FontWeight.w300),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "\$ 6.55",
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 16),
                      ),
                      Row(
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
                            image:
                                AssetImage("assets/images/star-half-empty.png"),
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
        FractionallySizedBox(
          widthFactor: 0.5,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: SizedBox(
              height: 250,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image(
                    image: AssetImage(
                      "assets/images/food fish1.jpg",
                    ),
                    height: 180,
                  ),
                  Text(
                    "Aquariana goldfish & coldwater flake food",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: "GilroyLight",
                        fontWeight: FontWeight.w300),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "\$ 6.25",
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 16),
                      ),
                      Row(
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
                            image:
                                AssetImage("assets/images/star-half-empty.png"),
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
        FractionallySizedBox(
          widthFactor: 0.5,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: SizedBox(
              height: 250,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image(
                    image: AssetImage(
                      "assets/images/food fish2.jpg",
                    ),
                    height: 180,
                  ),
                  Text(
                    "Extra SELECT tropical flakes",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: "GilroyLight",
                        fontWeight: FontWeight.w300),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "\$ 7.40",
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 16),
                      ),
                      Row(
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
                            image:
                                AssetImage("assets/images/star-half-empty.png"),
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
        FractionallySizedBox(
          widthFactor: 0.5,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: SizedBox(
              height: 250,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image(
                    image: AssetImage(
                      "assets/images/food fish3.jpg",
                    ),
                    height: 180,
                  ),
                  Text(
                    "King British bloodworm treats",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: "GilroyLight",
                        fontWeight: FontWeight.w300),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "\$ 4.99",
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 16),
                      ),
                      Row(
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
                            image:
                                AssetImage("assets/images/star-half-empty.png"),
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
      ],
    );
  }

  Padding header(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        const Image(
          image: AssetImage("assets/images/category_fish.png"),
          width: 55,
        ),
        const Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            "Fish",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 0),
          child: Text(
            " / Food",
            style: TextStyle(
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
      ]),
    );
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
          top: 150,
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
                        widget.onBrandChanged(value!,0);
                      },
                    ),
                     CheckboxListTile(
                      activeColor: const Color(0xff3F0D84),
                      title: const Text('King British'),
                      value: widget.selectedOptions[1],
                      onChanged: (value) {
                        widget.onBrandChanged(value!,1);
                      },
                    ),
                     CheckboxListTile(
                      activeColor: const Color(0xff3F0D84),
                      title: const Text('Tetra'),
                      value: widget.selectedOptions[2],
                      onChanged: (value) {
                        widget.onBrandChanged(value!,2);
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
