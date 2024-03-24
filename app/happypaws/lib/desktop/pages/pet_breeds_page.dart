import 'dart:convert';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:happypaws/common/services/PetBreedsService.dart';
import 'package:happypaws/common/utilities/Toast.dart';
import 'package:happypaws/common/utilities/colors.dart';
import 'package:happypaws/desktop/components/buttons/action_button.dart';
import 'package:happypaws/desktop/components/buttons/primary_icon_button.dart';
import 'package:happypaws/desktop/components/dialogs/confirmationDialog.dart';
import 'package:happypaws/desktop/components/spinner.dart';
import '../dialogs/add_edit_pet_breed_dialog.dart';

@RoutePage()
class PetBreedsPage extends StatefulWidget {
  const PetBreedsPage({super.key});

  @override
  State<PetBreedsPage> createState() => _PetBreedsPageState();
}

class _PetBreedsPageState extends State<PetBreedsPage> {
  Map<String, dynamic>? petBreeds;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    var response = await PetBreedsService().getPaged("", 1, 999);
    if (response.statusCode == 200) {
      setState(() {
        petBreeds = response.data;
      });
    }
  }

  Future<void> deletePetBreed(int id) async {
    try {
      var response = await PetBreedsService().delete('/$id');
      if (response.statusCode == 200) {
        fetchData();
        if (!mounted) return;
        ToastHelper.showToastSuccess(
            context, "You have successfully deleted the selected pet breed!");
      } else {
        throw Exception("An error has occured!");
      }
    } catch (e) {
      if (!mounted) return;
      ToastHelper.showToastError(
          context, "An error has occured! Please try again later.");
      rethrow;
    }
  }

  void showAddEditMenu(BuildContext context, {Map<String, dynamic>? data}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: const EdgeInsets.all(0),
            content: AddEditPetBreedMenu(
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
                      'Pet breeds settings',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w600),
                    ),
                    PrimaryIconButton(
                        onPressed: () => showAddEditMenu(context),
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        label: "Add new pet breed"),
                  ],
                ),
                const SizedBox(height: 16.0),
                if (petBreeds != null)
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
              child: tableHead('Pet type'),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: tableHead('Pet breed'),
            ),
            Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: tableHead('Actions'),
                )),
          ],
        ),
        for (var petBreed in petBreeds!['items'])
          TableRow(
            children: [
              tableCell(petBreed['petType']['name']),
              tableCell(petBreed['name']),
              tableActions(petBreed)
            ],
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
                            'Are you sure you want to delete this pet breed?',
                        onYesPressed: () {
                          Navigator.of(context).pop();
                          deletePetBreed(data['id']);
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
