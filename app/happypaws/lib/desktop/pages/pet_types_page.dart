import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:happypaws/common/services/PetTypesService.dart';
import 'package:happypaws/common/services/PetsService.dart';
import 'package:happypaws/common/utilities/Colors.dart';
import 'package:happypaws/common/utilities/toast.dart';
import 'package:happypaws/desktop/components/buttons/action_button.dart';
import 'package:happypaws/desktop/components/buttons/primary_icon_button.dart';
import 'package:happypaws/desktop/components/confirmationDialog.dart';
import 'package:happypaws/desktop/components/spinner.dart';
import 'package:happypaws/desktop/components/table/table_data.dart';
import 'package:happypaws/desktop/components/table/table_head.dart';
import '../dialogs/add_edit_pet_type_dialog.dart';

@RoutePage()
class PetTypesPage extends StatefulWidget {
  const PetTypesPage({super.key});

  @override
  State<PetTypesPage> createState() => _PetTypesPageState();
}

class _PetTypesPageState extends State<PetTypesPage> {
  Map<String, dynamic>? petTypes;
  Map<String, dynamic> params={};
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
   try {
      var response = await PetTypesService().getPaged("", 1, 999, searchObject: params);
    if (response.statusCode == 200) {
      setState(() {
        petTypes = response.data;
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

  Future<void> deletePetType(int id) async {
    try {
      var response = await PetTypesService().delete('/$id');
      if (response.statusCode == 200) {
        fetchData();
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

  void showAddEditMenu(BuildContext context, {Map<String, dynamic>? data}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: const EdgeInsets.all(0),
            content: AddEditPetTypeMenu(
              onClose: () {
                Navigator.of(context).pop();
              },
              allPetTypes: petTypes,
              onAdd: (value) {
                setState(() {
                  petTypes!['items'].add(value);
                });
              },
              onEdit: (value) {
                setState(() {
                  petTypes!['items'][petTypes!['items']
                          .indexWhere((x) => x['id'] == value['id'])] =
                      value;
                });
              },
              data: data,
            ),
          );
        });
  }

 onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      setState(() {
        petTypes = null;
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'Pet types settings',
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
                            labelText: "Search by type name...",
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
                    const SizedBox(width: 20,),
                    PrimaryIconButton(
                        onPressed: () => showAddEditMenu(context),
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        label: "Add new pet type"),
                  ],
                ),
                const SizedBox(height: 16.0),
                if (petTypes != null)
                  Expanded(
                      child: SingleChildScrollView(
                          scrollDirection: Axis.vertical, child: table()))
                else
                  const Expanded(
                      child: Padding(
                          padding: EdgeInsets.only(top: 36.0),
                          child: Spinner()))
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
                header: 'Pet type name',
                alignmentGeometry: Alignment.centerLeft),
            TableHead(
                header: 'Actions', alignmentGeometry: Alignment.centerRight)
          ],
        ),
        for (var petType in petTypes!['items'])
          TableRow(
            children: [
              TableData(
                data: petType['name'],
                alignmentGeometry: Alignment.bottomLeft,
                paddingHorizontal: 25,
              ),
              tableActions(petType)
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
                      await PetsService().hasAnyWithPetTypeId(data['id']);
                  if (response.data == true) {
                    if (!mounted) return;
                    ToastHelper.showToastError(context,
                        "You cannot delete this pet type because it contains one or more pets.");
                    return;
                  }
                  if (!mounted) return;
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return ConfirmationDialog(
                        title: 'Confirmation',
                        content:
                            'Are you sure you want to delete this pet type?',
                        onYesPressed: () {
                          Navigator.of(context).pop();
                          deletePetType(data['id']);
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
