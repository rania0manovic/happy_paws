import 'package:flutter/material.dart';
import 'package:happypaws/common/services/PetBreedsService.dart';
import 'package:happypaws/common/services/PetTypesService.dart';
import 'package:happypaws/common/utilities/toast.dart';
import 'package:happypaws/common/utilities/Colors.dart';
import 'package:happypaws/desktop/components/api_data_dropdown_menu.dart';
import 'package:happypaws/desktop/components/buttons/primary_button.dart';
import 'package:happypaws/desktop/components/input_field.dart';
import 'package:happypaws/desktop/components/spinner.dart';

class AddEditPetBreedMenu extends StatefulWidget {
  final VoidCallback onClose;
  final VoidCallback fetchData;
  final Map<String, dynamic>? data;
  final Map<String, dynamic>? allbreeds;

  const AddEditPetBreedMenu({
    Key? key,
    required this.onClose,
    required this.fetchData,
    this.data,
    this.allbreeds,
  }) : super(key: key);

  @override
  _AddEditPetBreedMenuState createState() => _AddEditPetBreedMenuState();
}

class _AddEditPetBreedMenuState extends State<AddEditPetBreedMenu> {
  bool disabledButton = false;

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
      setState(() {
        disabledButton = true;
      });
      final response = await PetBreedsService().post("", data);
      if (response.statusCode == 200) {
        widget.onClose();
        widget.fetchData();
        setState(() {
          disabledButton = false;
        });
        if (!mounted) return;
        ToastHelper.showToastSuccess(
            context, "You have succesfully added a new pet breed!");
      } else {
        throw Exception('Error occured');
      }
    } catch (e) {
      setState(() {
        disabledButton = false;
      });
      if (!mounted) return;
      ToastHelper.showToastError(
          context, "An error has occured! Please try again later.");
      rethrow;
    }
  }

  Future<void> editPetBreed() async {
    try {
       setState(() {
          disabledButton = true;
        });
      final response = await PetBreedsService().put("", widget.data);
      if (response.statusCode == 200) {
        widget.onClose();
        widget.fetchData();
         setState(() {
          disabledButton = false;
        });
        if (!mounted) return;
        ToastHelper.showToastSuccess(
            context, "You have succesfully edited the selected pet breed!");
      } else {
        throw Exception('Error occured');
      }
    } catch (e) {
       setState(() {
          disabledButton = false;
        });
      if (!mounted) return;
      ToastHelper.showToastError(
          context, "An error has occured! Please try again later.");
      rethrow;
    }
  }

  Map<String, dynamic> data = {};
  Map<String, dynamic>? petTypes;
  String? selectedPetType;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 370,
      child: petTypes == null
          ? const Spinner()
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
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
                          Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ApiDataDropdownMenu(
                                    items: petTypes!['items'],
                                    label: 'Pet type:',
                                    onChanged: (String? newValue) async {
                                      setState(() {
                                        selectedPetType = newValue;
                                        data['petTypeId'] = newValue;
                                      });
                                    },
                                    selectedOption: selectedPetType),
                                InputField(
                                  label: "Breed name:",
                                  value: widget.data != null
                                      ? widget.data!['name']
                                      : '',
                                  onChanged: (value) => setState(() {
                                    data['name'] = value;
                                  }),
                                ),
                                const SizedBox(
                                  height: 32,
                                ),
                                PrimaryButton(
                                  isDisabled: disabledButton,
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        widget.data != null
                                            ? editPetBreed()
                                            : addPetBreed();
                                      }
                                    },
                                    width: double.infinity,
                                    label: widget.data != null ? 'Edit' : "Add")
                              ],
                            ),
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
}
