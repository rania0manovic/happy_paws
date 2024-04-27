import 'package:flutter/material.dart';
import 'package:happypaws/common/components/text/LightText.dart';
import 'package:happypaws/common/services/PetBreedsService.dart';
import 'package:happypaws/common/services/PetTypesService.dart';
import 'package:happypaws/common/utilities/toast.dart';
import 'package:happypaws/common/utilities/Colors.dart';
import 'package:happypaws/desktop/components/buttons/primary_button.dart';
import 'package:happypaws/desktop/components/spinner.dart';

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
      setState(() {
        petTypes = responseCategories.data;
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
  Map<String, dynamic>? petTypes;
  String? selectedPetType;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 370,
      height: 310,
      child: petTypes == null
          ? const Spinner()
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
                              dropdownMenu(petTypes!['items'], "Pet type",
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

  Column dropdownMenu(dynamic items, String label,
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
                color: Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownButton<String>(
                padding: EdgeInsets.symmetric(horizontal: 10),
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
              color:  Colors.black,
            ),
            obscureText: isObscure ? true : false,
            decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.only(bottom: 5, left: 10, right: 10),
                filled: true,
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: const BorderSide(
                      color:  AppColors.primary,
                      width: 5.0,
                    ),
                    borderRadius: BorderRadius.circular(10))),
          ),
        )
      ],
    );
  }
}
