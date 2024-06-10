import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:happypaws/common/components/text/light_text.dart';
import 'package:happypaws/common/services/PetBreedsService.dart';
import 'package:happypaws/common/services/PetTypesService.dart';
import 'package:happypaws/common/services/PetsService.dart';
import 'package:happypaws/common/utilities/toast.dart';
import 'package:happypaws/common/utilities/Colors.dart';
import 'package:happypaws/common/utilities/constants.dart';
import 'package:happypaws/desktop/components/buttons/go_back_button.dart';
import 'package:happypaws/desktop/components/buttons/primary_button.dart';
import 'package:happypaws/desktop/components/buttons/primary_icon_button.dart';
import 'package:happypaws/desktop/components/confirmationDialog.dart';
import 'package:happypaws/desktop/components/spinner.dart';
import 'package:happypaws/desktop/dialogs/add_edit_allergy_dialog.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

@RoutePage()
class PetDetailsPage extends StatefulWidget {
  const PetDetailsPage(
      {super.key, required this.userId, this.petId, this.onChangedData});
  final String userId;
  final int? petId;
  final AsyncCallback? onChangedData;

  @override
  State<PetDetailsPage> createState() => _PetDetailsPageState();
}

class _PetDetailsPageState extends State<PetDetailsPage> {
  String selectedGender = 'Unknown';
  String selectedDate = 'Select date';
  String? selectedPetType;
  String? selectedPetBreed;
  Map<String, dynamic>? petTypes;
  List<dynamic>? petBreeds;
  Map<String, dynamic> data = {};
  final ImagePicker _imagePicker = ImagePicker();
  File? _selectedImage;
  Map<String, dynamic>? profilePhoto;
  final _formKey = GlobalKey<FormState>();
  Map<String, bool> errorStates = {};

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    var responsePetTypes = await PetTypesService().getPaged("", 1, 999);
    if (responsePetTypes.statusCode == 200) {
      setState(() {
        petTypes = responsePetTypes.data;
      });
      if (widget.petId != null) {
        var responsePetData = await PetsService().get('/${widget.petId}');
        if (responsePetData.statusCode == 200) {
          fetchPetBreeds(
              responsePetData.data['petBreed']['petType']['id'].toString());
          final formatter = DateFormat('dd.MM.yyyy');
          setState(() {
            data = responsePetData.data;
            selectedDate = formatter
                .format(DateTime.parse(responsePetData.data['birthDate']));
            profilePhoto = responsePetData.data['photo'];
            selectedGender = responsePetData.data['gender'];
            selectedPetType =
                responsePetData.data['petBreed']['petType']['id'].toString();
            selectedPetBreed =
                responsePetData.data['petBreed']['id'].toString();
          });
        }
      } else {
        data['OwnerId'] = widget.userId;
      }
    }
  }

  Future<void> addPet() async {
    try {
      if (data['weight'] is double || data['weight'] is String) {
        data['weight'] = data['weight'].toString().replaceAll('.', ',');
      }
      final response = await PetsService().postMultiPartRequest("", data);
      if (response.statusCode == 200) {
        await widget.onChangedData!.call();
        if (!mounted) return;
        context.router.pop();
        ToastHelper.showToastSuccess(
            context, "You have successfully added a new pet!");
      } else {
        throw Exception('Error occured');
      }
    } catch (e) {
      ToastHelper.showToastError(
          context, "An error occured! Please try again later.");
      rethrow;
    }
  }

  Future<void> editPet() async {
    try {
      if (data['weight'] is double || data['weight'] is String) {
        data['weight'] = data['weight'].toString().replaceAll('.', ',');
      }
      final response = await PetsService().putMultiPartRequest("", data);
      if (response.statusCode == 200) {
        await widget.onChangedData!.call();

        if (!mounted) return;
        ToastHelper.showToastSuccess(
            context, "You have successfully edited the selected pet!");
      } else {
        throw Exception('Error occured');
      }
    } catch (e) {
      ToastHelper.showToastError(
          context, "An error occured! Please try again later.");
      rethrow;
    }
  }

  Future<void> deletePet() async {
    try {
      final response = await PetsService().delete('/${widget.petId}');
      if (response.statusCode == 200) {
        await widget.onChangedData!.call();
        if (!mounted) return;
        context.router.pop();
        ToastHelper.showToastSuccess(context,
            "You have successfully deleted the selected pet from your profile!");
      } else {
        throw Exception('Error occured');
      }
    } catch (e) {
      ToastHelper.showToastError(
          context, "An error occured! Please try again later.");
      rethrow;
    }
  }

  Future<void> fetchPetBreeds(String? newValue) async {
    var responseSubcategories =
        await PetBreedsService().getBreedsForPetType(newValue);
    if (responseSubcategories.statusCode == 200) {
      setState(() {
        petBreeds = responseSubcategories.data;
      });
    }
  }

  Future<void> _pickImage() async {
    final XFile? selectedImage =
        await _imagePicker.pickImage(source: ImageSource.gallery);

    if (selectedImage != null) {
      setState(() {
        _selectedImage = File(selectedImage.path);
        data["photoFile"] = selectedImage.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return petTypes == null ||
            (widget.petId != null && selectedPetBreed == null)
        ? const Spinner()
        : SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const GoBackButton(),
                    Padding(
                        padding:
                            const EdgeInsets.only(left: 10, right: 10, top: 0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                    alignment: Alignment.topCenter,
                                    child: Column(
                                      children: [
                                        const Text("Pet information",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500)),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        SizedBox(
                                            height: 128,
                                            width: 128,
                                            child: Stack(
                                              children: [
                                                SizedBox(
                                                  height: 128,
                                                  width: 128,
                                                  child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                      child: _selectedImage !=
                                                              null
                                                          ? Image.file(
                                                              _selectedImage!,
                                                              fit: BoxFit.cover,
                                                            )
                                                          : profilePhoto != null
                                                              ? Image.memory(
                                                                  base64.decode(
                                                                    profilePhoto![
                                                                            'data']
                                                                        .toString(),
                                                                  ),
                                                                  fit: BoxFit
                                                                      .cover,
                                                                )
                                                              : const Image(
                                                                  image: AssetImage(
                                                                      "assets/images/pet_default.jpg"),
                                                                  fit: BoxFit
                                                                      .cover,
                                                                )),
                                                ),
                                                Positioned(
                                                    bottom: 5,
                                                    right: 5,
                                                    child: GestureDetector(
                                                      onTap: () => _pickImage(),
                                                      child: const Image(
                                                          image: AssetImage(
                                                              "assets/images/edit.png")),
                                                    ))
                                              ],
                                            ))
                                      ],
                                    )),
                                inputField(
                                    'Name:',
                                    widget.petId != null ? data['name'] : null,
                                    "name"),
                                inputField(
                                    'Weight (in kg):',
                                    widget.petId != null
                                        ? '${data['weight']}'
                                        : null,
                                    "weight"),
                                apiDropdownMenu(petTypes!['items'], "Pet type:",
                                    (String? newValue) async {
                                  setState(() {
                                    selectedPetBreed = null;
                                    selectedPetType = null;
                                  });
                                  await fetchPetBreeds(newValue);
                                  setState(() {
                                    selectedPetType = newValue;
                                  });
                                }, selectedPetType),
                                apiDropdownMenu(
                                    petBreeds == null
                                        ? List.empty()
                                        : petBreeds!,
                                    "Pet breed:",
                                    (String? newValue) => setState(() {
                                          selectedPetBreed = newValue;
                                          data['petBreedId'] = newValue;
                                        }),
                                    selectedPetBreed,
                                    isDisabeled:
                                        selectedPetType == null ? true : false),
                                dropdownMenu("Gender:", "gender"),
                                birthDateInput(context),
                                if (widget.petId != null)
                                  if (!data['petAllergies'].isEmpty)
                                    allergiesSection()
                                  else
                                    GestureDetector(
                                        onTap: () =>
                                            showAddAllergyMenu(context),
                                        child: const Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Text(
                                            "Add new allergy",
                                            style: TextStyle(
                                                color: AppColors.primary,
                                                decoration:
                                                    TextDecoration.underline),
                                          ),
                                        )),
                                if (widget.petId != null)
                                  if (!data['petMedications'].isEmpty)
                                    medicationSection(),
                                const SizedBox(
                                  height: 20,
                                ),
                                PrimaryButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      widget.petId == null
                                          ? addPet()
                                          : editPet();
                                    }
                                  },
                                  label: widget.petId == null
                                      ? "Add new pet"
                                      : "Edit pet",
                                  width: double.infinity,
                                  fontSize: 18,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Visibility(
                                  visible: widget.petId != null,
                                  child: PrimaryButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return ConfirmationDialog(
                                            title: 'Confirmation',
                                            content:
                                                'Are you sure you want to delete this pet?',
                                            onYesPressed: () {
                                              Navigator.of(context).pop();
                                              deletePet();
                                            },
                                            onNoPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          );
                                        },
                                      );
                                    },
                                    label: "Delete pet",
                                    width: double.infinity,
                                    fontSize: 18,
                                    backgroundColor: AppColors.error,
                                  ),
                                )
                              ],
                            ),
                          ),
                        )),
                  ]),
            ),
          );
  }

  Column birthDateInput(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        const Text(
          'Date of birth (approximately):',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
        ),
        const SizedBox(
          height: 10,
        ),
        PrimaryIconButton(
          icon: const Icon(
            Icons.date_range_rounded,
            color: Colors.white,
          ),
          label: selectedDate,
          width: double.infinity,
          onPressed: () {
            _showDatePicker(context);
          },
        ),
      ],
    );
  }

  void _showDatePicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            height: 300,
            width: MediaQuery.of(context).size.width,
            child: SfDateRangePicker(
              maxDate: DateTime.now(),
              selectionMode: DateRangePickerSelectionMode.single,
              showNavigationArrow: true,
              onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                final formatter = DateFormat('dd.MM.yyyy');
                final value = formatter.format(args.value!);
                setState(() {
                  selectedDate = value;
                  data['birthDate'] = value;
                });
                Navigator.of(context).pop();
              },
            ),
          ),
        );
      },
    );
  }

  Column medicationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        const Text(
          "Medications:",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          width: double.infinity,
          child: Wrap(
            spacing: 18.0,
            runSpacing: 8.0,
            children: [
              for (var item in data['petMedications'])
                listItem(item['medicationName'])
            ],
          ),
        ),
      ],
    );
  }

  Column allergiesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        const Text(
          "Allergies:",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              Expanded(
                child: Wrap(
                  spacing: 18.0,
                  runSpacing: 8.0,
                  children: [
                    for (var item in data['petAllergies'])
                      GestureDetector(
                          onTap: () => showAddAllergyMenu(context, data: item),
                          child: listItem(item['name'],
                              severity: item['allergySeverity'])),
                  ],
                ),
              ),
              Transform.rotate(
                angle: 90 * 3.1415926535 / 180,
                child: PopupMenuButton(
                  elevation: 0,
                  color: AppColors.dimWhite,
                  itemBuilder: (BuildContext context) {
                    return [
                      const PopupMenuItem(
                        value: 'add',
                        child: Row(
                          children: [
                            Text('Add new allergy'),
                          ],
                        ),
                      ),
                    ];
                  },
                  onSelected: (value) {
                    if (value == 'add') {
                      showAddAllergyMenu(context);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void showAddAllergyMenu(BuildContext context, {Map<String, dynamic>? data}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(8),
          content: AddAllergyMenu(
            onAdd: (value) {
              setState(() {
                this.data['petAllergies'].add(value);
              });
            },
            onEdit: (value) {
              setState(() {
                this.data['petAllergies'][this
                    .data['petAllergies']
                    .indexWhere((x) => x['id'] == value['id'])] = value;
              });
            },
            onRemove: (value) {
              setState(() {
                this.data['petAllergies'].removeWhere((x) => x['id'] == value);
              });
            },
            data: data,
            petId: this.data['id'],
            onClosed: () {
              Navigator.of(context).pop();
            },
          ),
        );
      },
    );
  }

  Wrap listItem(String allergy, {String? severity}) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Icon(
          Icons.circle,
          size: 8.0,
          color: severity == null
              ? Colors.grey.shade400
              : severity == "Mild"
                  ? AppColors.success
                  : severity == 'Moderate'
                      ? AppColors.info
                      : AppColors.error,
        ),
        const SizedBox(width: 8.0),
        Text(
          allergy,
          style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Column apiDropdownMenu(dynamic items, String label,
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
          fontSize: 18,
        ),
        Container(
            padding: const EdgeInsets.only(top: 10),
            width: double.infinity,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  errorStyle: TextStyle(color: AppColors.error, fontSize: 14),
                  fillColor: Color(0xffF2F2F2),
                  filled: true,
                  border: UnderlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    setState(() {
                      errorStates[label] = true;
                    });
                    return "This field is required";
                  }
                  setState(() {
                    errorStates[label] = false;
                  });
                  return null;
                },
                isExpanded: true,
                value: selectedOption,
                hint: const Text('Select'),
                borderRadius: BorderRadius.circular(10),
                icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
                onChanged: isDisabeled ? null : onChanged,
                disabledHint: selectedPetType != null
                    ? const Text("No breed found...")
                    : const Text("Select the type first..."),
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

  Column dropdownMenu(String label, String key) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
            width: double.infinity,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xffF2F2F2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: selectedGender,
                  underline: Container(),
                  borderRadius: BorderRadius.circular(10),
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedGender = newValue!;
                      data[key] = newValue;
                    });
                  },
                  items: <String>[
                    'Unknown',
                    'Female',
                    'Male',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500)),
                    );
                  }).toList(),
                ),
              ),
            )),
      ],
    );
  }

  Column inputField(String label, String? initialValue, String key) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: errorStates[key] ?? false ? 75 : 50,
          child: TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                setState(() {
                  errorStates[key] = true;
                });
                return "This field is required";
              } else if (key == "weight") {
                if (double.tryParse(value) == null) {
                  setState(() {
                    errorStates[key] = true;
                  });
                  return "Input must be numerical value (e.g. 5.5)";
                }
              }
              setState(() {
                errorStates[key] = false;
              });
              return null;
            },
            onChanged: (value) {
              setState(() {
                data[key] = value;
              });
            },
            initialValue: initialValue,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            decoration: InputDecoration(
                errorStyle:
                    const TextStyle(color: AppColors.error, fontSize: 14),
                filled: true,
                fillColor: const Color(0xfff2f2f2),
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: const BorderSide(
                      color: AppColors.primary,
                      width: 5.0,
                    ),
                    borderRadius: BorderRadius.circular(10))),
          ),
        )
      ],
    );
  }
}
