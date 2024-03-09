import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:happypaws/common/services/ProductCategorySubcategoriesService.dart';
import 'package:happypaws/desktop/components/spinner.dart';
import 'package:happypaws/routes/app_router.gr.dart';

@RoutePage()
class ShopCategorySubcategoriesPage extends StatefulWidget {
  const ShopCategorySubcategoriesPage(
      {super.key,
      @PathParam('id') required this.categoryId,
      required this.categoryPhoto,
      required this.categoryName});
  final int categoryId;
  final String categoryPhoto;
  final String categoryName;

  @override
  State<ShopCategorySubcategoriesPage> createState() =>
      _ShopCategorySubcategoriesPageState();
}

class _ShopCategorySubcategoriesPageState
    extends State<ShopCategorySubcategoriesPage> {
  List<Map<String, dynamic>>? productSubcategories;

  @override
  void initState() {
    super.initState();
    fetchSubcategories();
  }

  Future<void> fetchSubcategories() async {
    var responseSubcategories = await ProductCategorySubcategoriesService()
        .getSubcategories(widget.categoryId.toString(), includePhotos: true);
    if (responseSubcategories.statusCode == 200) {
      List<Map<String, dynamic>> jsonData =
          (json.decode(responseSubcategories.body) as List)
              .cast<Map<String, dynamic>>();
      setState(() {
        productSubcategories = jsonData;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if(productSubcategories==null) {
      return const Spinner();
    } else {
      return SingleChildScrollView(
      child: Column(
        children: [petCategoriesHeader(context), petCategoriesSection()],
      ),
    );
    }
  }

  Padding petCategoriesHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Column(
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
          Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Image.memory(base64.decode(widget.categoryPhoto.toString()),
                height: 55),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                widget.categoryName,
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
              ),
            ),
          ]),
        ],
      ),
    );
  }

  Padding petCategoriesSection() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        spacing: 40,
        runSpacing: 20,
        children: [
          if (productSubcategories != null)
            for (var subcategory in productSubcategories!)
              GestureDetector(
                onTap: () => context.router.push(CatalogRoute(
                    categoryId: widget.categoryId,
                    subcategoryId: subcategory['productSubcategory']['id'],
                    categoryName: widget.categoryName,
                    subcategoryName: subcategory['productSubcategory']['name'],
                    categoryPhoto: widget.categoryPhoto)),
                child: Column(
                  children: [
                    SizedBox(
                      height: 150,
                      width: 150,
                      child: ClipOval(
                        child: Image.memory(
                          base64.decode(subcategory['productSubcategory']
                                  ['photo']['data']
                              .toString()),
                          height: 128,
                          fit: BoxFit.cover, 
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        subcategory['productSubcategory']['name'],
                        style: const TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 20,
                            fontFamily: "GilroyLight"),
                      ),
                    ),
                  ],
                ),
              )
        ],
      ),
    );
  }
}
