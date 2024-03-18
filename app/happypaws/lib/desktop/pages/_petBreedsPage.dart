import 'dart:convert';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:happypaws/common/components/text/LightText.dart';
import 'package:happypaws/common/services/PetBreedsService.dart';
import 'package:happypaws/common/services/PetTypesService.dart';
import 'package:happypaws/common/utilities/Toast.dart';
import 'package:happypaws/common/utilities/colors.dart';
import 'package:happypaws/desktop/components/buttons/ActionButton.dart';
import 'package:happypaws/desktop/components/buttons/PrimaryButton.dart';
import 'package:happypaws/desktop/components/buttons/PrimaryIconButton.dart';
import 'package:happypaws/desktop/components/dialogs/confirmationDialog.dart';
import 'package:happypaws/desktop/components/spinner.dart';

@RoutePage()
class PetBreedsPage extends StatefulWidget {
  const PetBreedsPage({super.key});

  @override
  State<PetBreedsPage> createState() => _PetBreedsPageState();
}

class _PetBreedsPageState extends State<PetBreedsPage> {
  List<Map<String, dynamic>>? petBreeds;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    var response = await PetBreedsService().getPaged("", 1, 999);
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(response.body);
      setState(() {
        petBreeds = List<Map<String, dynamic>>.from(jsonData['items']);
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
        for (var petBreed in petBreeds!)
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

class AddEditPetBreedMenu extends StatefulWidget {
  final VoidCallback onClose;
  final VoidCallback fetchData;

  final Map<String, dynamic>? data;

  const AddEditPetBreedMenu({
    Key? key,
    required this.onClose,
    required this.fetchData,
    this.data,
  }) : super(key: key);

  @override
  _AddEditPetBreedMenuState createState() => _AddEditPetBreedMenuState();
}

class _AddEditPetBreedMenuState extends State<AddEditPetBreedMenu> {
  @override
  void initState() {
    super.initState();
    if (widget.data != null) {
      data = widget.data!;
    }
    fetchData();
  }

  Future<void> fetchData() async {
    var responseCategories = await PetTypesService().getPaged("", 1, 999);
    if (responseCategories.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(responseCategories.body);
      setState(() {
        petTypes = List<Map<String, dynamic>>.from(jsonData['items']);
        if (widget.data != null) {
          selectedPetType = widget.data!['petTypeId'].toString();
        }
      });
    }
  }

  Future<void> addPetBreed() async {
    try {
      final response = await PetBreedsService().post("", data);
      if (response.statusCode == 200) {
        widget.onClose();
        widget.fetchData();
        if (!mounted) return;
        ToastHelper.showToastSuccess(
            context, "You have succesfully added a new pet breed!");
      } else {
        throw Exception('Error occured');
      }
    } catch (e) {
      if (!mounted) return;
      ToastHelper.showToastError(
          context, "An error has occured! Please try again later.");
      rethrow;
    }
  }

  Future<void> editPetBreed() async {
    try {
      final response = await PetBreedsService().put("", widget.data);
      if (response.statusCode == 200) {
        widget.onClose();
        widget.fetchData();
        if (!mounted) return;
        ToastHelper.showToastSuccess(
            context, "You have succesfully edited the selected pet breed!");
      } else {
        throw Exception('Error occured');
      }
    } catch (e) {
      if (!mounted) return;
      ToastHelper.showToastError(
          context, "An error has occured! Please try again later.");
      rethrow;
    }
  }

  Map<String, dynamic> data = {};
  List<Map<String, dynamic>>? petTypes;
  String? selectedPetType;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 370,
      height: 310,
      child: petTypes == null
          ? Spinner()
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: [
                      const IconButton(
                        icon: Icon(Icons.inventory_2_outlined),
                        onPressed: null,
                        color: AppColors.gray,
                      ),
                      Text(
                        widget.data != null
                            ? 'Edit pet breed'
                            : "Add new pet breed",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
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
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 12, right: 12, bottom: 12),
                    child: SingleChildScrollView(
                      child: Wrap(
                        direction: Axis.horizontal,
                        alignment: WrapAlignment.start,
                        spacing: 20,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              dropdownMenu(petTypes!, "Pet type",
                                  (String? newValue) async {
                                setState(() {
                                  selectedPetType = newValue;
                                  data['petTypeId'] = newValue;
                                });
                              }, selectedPetType),
                              inputField("Breed name:", "name"),
                              const SizedBox(
                                height: 32,
                              ),
                              PrimaryButton(
                                  onPressed: () {
                                    widget.data != null
                                        ? editPetBreed()
                                        : addPetBreed();
                                  },
                                  width: double.infinity,
                                  label: widget.data != null ? 'Edit' : "Add")
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }

  Column dropdownMenu(List<Map<String, dynamic>> items, String label,
      void Function(String? newValue) onChanged, String? selectedOption,
      {bool isDisabeled = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          height: 16,
        ),
        LightText(
          label: label,
          fontSize: 14,
        ),
        Container(
            padding: const EdgeInsets.only(top: 10),
            width: double.infinity,
            height: 50,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xffF2F2F2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: selectedOption,
                  hint: const Text('Select'),
                  underline: Container(),
                  borderRadius: BorderRadius.circular(10),
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
                  onChanged: isDisabeled ? null : onChanged,
                  disabledHint: const Text("Select category first..."),
                  items: [
                    for (var item in items)
                      DropdownMenuItem<String>(
                        value: item['id'].toString(),
                        child: Text(item['name']),
                      ),
                  ],
                ),
              ),
            )),
      ],
    );
  }

  Column inputField(String label, String key, {bool isObscure = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 16,
        ),
        LightText(
          label: label,
          fontSize: 14,
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 40,
          width: double.infinity,
          child: TextFormField(
            enabled: selectedPetType != null,
            initialValue: widget.data != null ? widget.data!['name'] : '',
            onChanged: (value) {
              setState(() {
                data[key] = value;
              });
            },
            style: const TextStyle(
              color: false ? AppColors.error : Colors.black,
            ),
            obscureText: isObscure ? true : false,
            decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.only(bottom: 5, left: 10, right: 10),
                filled: true,
                fillColor: false ? AppColors.dimError : AppColors.dimWhite,
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: const BorderSide(
                      color: false ? AppColors.error : AppColors.primary,
                      width: 5.0,
                    ),
                    borderRadius: BorderRadius.circular(10))),
          ),
        )
      ],
    );
  }
}
