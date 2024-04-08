import 'dart:convert';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:happypaws/common/services/PetTypesService.dart';
import 'package:happypaws/common/utilities/colors.dart';
import 'package:happypaws/desktop/components/buttons/action_button.dart';
import 'package:happypaws/desktop/components/buttons/primary_icon_button.dart';
import 'package:happypaws/desktop/components/confirmationDialog.dart';
import 'package:happypaws/desktop/components/spinner.dart';
import '../dialogs/add_edit_pet_type_dialog.dart';

@RoutePage()
class PetTypesPage extends StatefulWidget {
  const PetTypesPage({super.key});

  @override
  State<PetTypesPage> createState() => _PetTypesPageState();
}

class _PetTypesPageState extends State<PetTypesPage> {
  Map<String, dynamic>? petTypes;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    var response = await PetTypesService().getPaged("", 1, 999);
    if (response.statusCode == 200) {
      setState(() {
        petTypes = response.data;
      });
    }
  }

  Future<void> deletePetType(int id) async {
    try {
      var response = await PetTypesService().delete('/$id');
      if (response.statusCode == 200) {
        fetchData();
      }
    } catch (e) {
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
              fetchData: fetchData,
              data: data,
            ),
          );
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
                      'Pet types settings',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w600),
                    ),
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
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: tableHead('Pet type name'),
            ),
            Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: tableHead('Actions'),
                )),
          ],
        ),
        for (var petType in petTypes!['items'])
          TableRow(
            children: [tableCell(petType['name']), tableActions(petType)],
          ),
      ],
    );
  }

  TableCell tableCell(String data) {
    return TableCell(
      child: Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 20, left: 30),
        child: Text(
          data,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  TableCell tableCellPhoto(String data) {
    return TableCell(
        child: Padding(
            padding: const EdgeInsets.only(top: 0, bottom: 0.0),
            child: Image.memory(
              base64.decode(data.toString()),
              height: 25,
            )));
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
                onPressed: () {
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

  TableCell tableHead(String header) {
    return TableCell(
      child: Padding(
        padding: const EdgeInsets.only(top: 12, bottom: 12),
        child: Text(
          header,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
