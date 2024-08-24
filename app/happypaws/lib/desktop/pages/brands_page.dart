import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:happypaws/common/services/BrandsService.dart';
import 'package:happypaws/common/services/ProductsService.dart';
import 'package:happypaws/common/utilities/Colors.dart';
import 'package:happypaws/common/utilities/toast.dart';
import 'package:happypaws/desktop/components/buttons/action_button.dart';
import 'package:happypaws/desktop/components/buttons/primary_icon_button.dart';
import 'package:happypaws/desktop/components/confirmationDialog.dart';
import 'package:happypaws/desktop/components/spinner.dart';
import 'package:happypaws/desktop/components/table/table_data.dart';
import 'package:happypaws/desktop/components/table/table_head.dart';
import '../dialogs/add_edit_brand_dialog.dart';

@RoutePage()
class BrandsPage extends StatefulWidget {
  const BrandsPage({super.key});

  @override
  State<BrandsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<BrandsPage> {
  Map<String, dynamic>? brands;
  late ScrollController _scrollController;
  late int currentPage = 1;
  bool isLoadingMore = false;
  Map<String, dynamic> params = {};
  Timer? _debounce;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    fetchData();
  }

  Future<void> _scrollListener() async {
    double currentPosition = _scrollController.position.pixels;
    double maxScrollExtent = _scrollController.position.maxScrollExtent;
    double distanceFromBottom = maxScrollExtent - currentPosition;
    if (distanceFromBottom <= 10 &&
        currentPage <= brands!['pageCount'] &&
        !isLoadingMore) {
      setState(() {
        isLoadingMore = true;
      });
      await fetchData();
      setState(() {
        isLoadingMore = false;
      });
    }
  }

  Future<void> fetchData() async {
    var response = await BrandsService()
        .getPaged("", currentPage, 15, searchObject: params);
    if (response.statusCode == 200) {
      setState(() {
        currentPage++;
        if (brands == null) {
          brands = response.data;
        } else {
          brands!['items'].addAll(response.data['items']);
        }
      });
    }
  }

  Future<void> deleteBrand(int id) async {
    try {
      var response = await BrandsService().delete('/$id');
      if (response.statusCode == 200) {
        if (!mounted) return;
        ToastHelper.showToastSuccess(
            context, "You have succesfully deleted the selected brand!");
        setState(() {
          brands!['items'].removeWhere((x) => x['id'] == id);
        });
      }
    } on DioException catch (e) {
      if (!mounted) return;
      if (e.response != null && e.response!.statusCode == 403) {
        ToastHelper.showToastError(
            context, "You do not have permission for this action!");
      } else {
        ToastHelper.showToastError(
            context, "An error has occured! Please try again later.");
      }
      rethrow;
    }
  }

  Future<void> showAddEditMenu(BuildContext context,
      {Map<String, dynamic>? data}) async {
    var allBrands = await BrandsService().getPaged('endpoint', 1, 99999);
    if (allBrands.statusCode == 200) {
      if (!context.mounted) return;
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              contentPadding: const EdgeInsets.all(0),
              content: AddEditBrandMenu(
                allBrands: allBrands.data,
                onClose: () {
                  Navigator.of(context).pop();
                },
                onAdd: (value) {
                  if (brands!['hasNextPage']) return;
                  setState(() {
                    brands!['items'].add(value);
                  });
                },
                onEdit: (value) {
                  setState(() {
                    brands!['items'][brands!['items']
                        .indexWhere((x) => x['id'] == value['id'])] = value;
                  });
                },
                data: data,
              ),
            );
          });
    }
  }

  onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      setState(() {
        brands = null;
        currentPage = 1;
      });
      fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 0, bottom: 0),
        child: Card(
          margin: const EdgeInsets.all(16.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Brands settings',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w600),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: 250,
                      height: 50,
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            params['name'] = value;
                          });
                          onSearchChanged(value);
                        },
                        decoration: InputDecoration(
                            labelText: "Search by brand name...",
                            labelStyle: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade400,
                                fontWeight: FontWeight.w500),
                            suffixIcon: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.search,
                                  size: 25,
                                  color: AppColors.primary,
                                ))),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    PrimaryIconButton(
                        onPressed: () => showAddEditMenu(context),
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        label: "Add new brand"),
                  ],
                ),
                const SizedBox(height: 16.0),
                if (brands != null)
                  Expanded(
                      child: SingleChildScrollView(
                          controller: _scrollController,
                          scrollDirection: Axis.vertical,
                          child: table()))
                else
                  const Expanded(
                      child: Padding(
                          padding: EdgeInsets.only(top: 36.0),
                          child: Spinner())),
                if (isLoadingMore)
                  Transform.scale(scale: 0.8, child: const Spinner())
              ],
            ),
          ),
        ));
  }

  Table table() {
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      border: TableBorder(
        horizontalInside: BorderSide(
          color: AppColors.gray.withOpacity(0.5),
          width: 1.0,
        ),
      ),
      children: [
        TableRow(
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.1),
          ),
          children: const [
            TableHead(
                header: "Brand name", alignmentGeometry: Alignment.centerLeft),
            TableHead(
                header: "Actions", alignmentGeometry: Alignment.centerRight),
          ],
        ),
        for (var brand in brands!['items'])
          TableRow(
            children: [
              TableData(
                data: brand['name'],
                alignmentGeometry: Alignment.centerLeft,
                paddingHorizontal: 25,
              ),
              tableActions(brand)
            ],
          ),
      ],
    );
  }

  TableCell tableActions(Map<String, dynamic> data) {
    return TableCell(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ActionButton(
                onPressed: () {
                  showAddEditMenu(context, data: data);
                },
                icon: Icons.edit_outlined,
                iconColor: AppColors.gray,
              ),
              ActionButton(
                onPressed: () async {
                  var response =
                      await ProductsService().hasAnyWithBrandId(data['id']);
                  if (response.data == true) {
                    if (!mounted) return;
                    ToastHelper.showToastError(context,
                        "You cannot delete this brand because it contains one or more products.");
                    return;
                  }
                  if (!mounted) return;
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return ConfirmationDialog(
                        title: 'Confirmation',
                        content: 'Are you sure you want to delete this brand?',
                        onYesPressed: () {
                          Navigator.of(context).pop();
                          deleteBrand(data['id']);
                        },
                        onNoPressed: () {
                          Navigator.of(context).pop();
                        },
                      );
                    },
                  );
                },
                icon: Icons.delete_outline_outlined,
                iconColor: AppColors.error,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
