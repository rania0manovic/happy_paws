import 'dart:async';
import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:happypaws/common/services/PetBreedsService.dart';
import 'package:happypaws/common/services/PetTypesService.dart';
import 'package:happypaws/common/services/PetsService.dart';
import 'package:happypaws/common/utilities/firebase_storage.dart';
import 'package:happypaws/common/utilities/toast.dart';
import 'package:happypaws/common/utilities/Colors.dart';
import 'package:happypaws/common/utilities/constants.dart';
import 'package:happypaws/desktop/components/api_data_dropdown_menu.dart';
import 'package:happypaws/desktop/components/buttons/go_back_button.dart';
import 'package:happypaws/desktop/components/buttons/primary_button.dart';
import 'package:happypaws/desktop/components/buttons/primary_icon_button.dart';
import 'package:happypaws/desktop/components/confirmationDialog.dart';
import 'package:happypaws/desktop/components/gender_dropdown_menu.dart';
import 'package:happypaws/desktop/components/input_field.dart';
import 'package:happypaws/desktop/components/spinner.dart';
import 'package:happypaws/desktop/dialogs/add_edit_allergy_dialog.dart';
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
  Map<String, dynamic>? data;
  File? _selectedImage;
  final _formKey = GlobalKey<FormState>();
  Map<String, bool> errorStates = {};
  bool isDisabledButton = false;

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
            selectedGender = responsePetData.data['gender'];
            selectedPetType =
                responsePetData.data['petBreed']['petType']['id'].toString();
            selectedPetBreed =
                responsePetData.data['petBreed']['id'].toString();
          });
        }
      } else {
        setState(() {
          data = {'ownerId': widget.userId};
        });
      }
    }
  }

  Future<void> addPet() async {
    try {
      setState(() {
        isDisabledButton = true;
      });
      if (_selectedImage != null) {
        var imageUrl = await FirebaseStorageHelper.addImage(_selectedImage!);
        if (imageUrl != null) {
          setState(() {
            data!['downloadUrl'] = imageUrl['downloadUrl'];
          });
        }
      }
      if (data!['weight'] is double || data!['weight'] is String) {
        data!['weight'] = data!['weight'].toString().replaceAll('.', ',');
      }
      final response = await PetsService().post("", data!);
      if (response.statusCode == 200) {
        await widget.onChangedData!.call();
        setState(() {
          isDisabledButton = false;
        });
        if (!mounted) return;
        context.router.pop();
        ToastHelper.showToastSuccess(
            context, "You have successfully added a new pet!");
      } else {
        throw Exception('Error occured');
      }
    } on DioException catch (e) {
      setState(() {
        isDisabledButton = false;
      });
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

  Future<void> editPet() async {
    try {
      setState(() {
        isDisabledButton = true;
      });
      dynamic imageUrl;
      if (_selectedImage != null) {
        if (widget.petId != null && data!['photo'] != null) {
          imageUrl = await FirebaseStorageHelper.updateImage(
              _selectedImage!, data!['photo']['downloadURL']);
        } else {
          imageUrl = await FirebaseStorageHelper.addImage(_selectedImage!);
        }
        if (imageUrl != null) {
          setState(() {
            data!['downloadUrl'] = imageUrl['downloadUrl'];
          });
        }
      }
      if (data!['weight'] is double || data!['weight'] is String) {
        data!['weight'] = data!['weight'].toString().replaceAll('.', ',');
      }
      final response = await PetsService().put("", data!);
      if (response.statusCode == 200) {
        setState(() {
          isDisabledButton = false;
        });
        await widget.onChangedData!.call();
        if (!mounted) return;
        ToastHelper.showToastSuccess(
            context, "You have successfully edited the selected pet!");
      } else {
        throw Exception('Error occured');
      }
    } on DioException catch (e) {
      setState(() {
        isDisabledButton = false;
      });
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

  Future<void> fetchPetBreeds(String? newValue) async {
    var responseSubcategories =
        await PetBreedsService().getBreedsForPetType(newValue);
    if (responseSubcategories.statusCode == 200) {
      setState(() {
        petBreeds = responseSubcategories.data;
      });
    }
  }

  Future<dynamic> _pickImage() async {
    var result = await FirebaseStorageHelper.pickImage();
    if (result != null) {
      setState(() {
        _selectedImage = result['selectedImage'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return petTypes == null || data == null
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
                                                          : data!['photo'] !=
                                                                  null
                                                              ? Image.network(
                                                                  data!['photo']
                                                                      [
                                                                      'downloadURL'],
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
                                InputField(
                                  label: 'Name:',
                                  value: data!['name'],
                                  onChanged: (value) {
                                    data!['name'] = value;
                                  },
                                ),
                                InputField(
                                  label: 'Weight (in kg):',
                                  value: widget.petId != null
                                      ? '${data!['weight']}'
                                      : '',
                                  isNumber: true,
                                  onChanged: (value) {
                                    data!['weight'] = value;
                                  },
                                ),
                                ApiDataDropdownMenu(
                                    items: petTypes!['items'],
                                    label: "Pet type:",
                                    onChanged: (String? newValue) async {
                                      setState(() {
                                        selectedPetBreed = null;
                                        selectedPetType = null;
                                      });
                                      await fetchPetBreeds(newValue);
                                      setState(() {
                                        selectedPetType = newValue;
                                      });
                                    },
                                    selectedOption: selectedPetType),
                                ApiDataDropdownMenu(
                                  items: petBreeds == null
                                      ? List.empty()
                                      : petBreeds!,
                                  label: "Pet breed:",
                                  onChanged: (String? newValue) => setState(() {
                                    selectedPetBreed = newValue;
                                    data!['petBreedId'] = newValue;
                                  }),
                                  selectedOption: selectedPetBreed,
                                  isDisabled:
                                      selectedPetType == null ? true : false,
                                ),
                                GenderDropdownMenu(
                                  selectedGender: selectedGender,
                                  onChanged: (newValue) => setState(() {
                                    selectedGender = newValue!;
                                    data!['gender'] = newValue;
                                  }),
                                ),
                                birthDateInput(context),
                                if (widget.petId != null)
                                  if (data!['petAllergies'] != null &&
                                      !data!['petAllergies'].isEmpty)
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
                                  if (data!['petMedications'] != null &&
                                      !data!['petMedications'].isEmpty)
                                    medicationSection(),
                                const SizedBox(
                                  height: 20,
                                ),
                                PrimaryButton(
                                  isDisabled: isDisabledButton,
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
              backgroundColor: Colors.transparent,
              maxDate: DateTime.now(),
              selectionMode: DateRangePickerSelectionMode.single,
              showNavigationArrow: true,
              onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                final formatter = DateFormat('dd.MM.yyyy');
                final value = formatter.format(args.value!);
                setState(() {
                  selectedDate = value;
                  data!['birthDate'] =
                      DateFormat('yyyy-MM-dd').format(args.value);
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
              for (var item in data!['petMedications'])
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
                    for (var item in data!['petAllergies'])
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
                this.data!['petAllergies'].add(value);
              });
            },
            onEdit: (value) {
              setState(() {
                this.data!['petAllergies'][this
                    .data!['petAllergies']
                    .indexWhere((x) => x['id'] == value['id'])] = value;
              });
            },
            onRemove: (value) {
              setState(() {
                this.data!['petAllergies'].removeWhere((x) => x['id'] == value);
              });
            },
            data: data,
            petId: this.data!['id'],
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
}
