import 'dart:convert';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:happypaws/common/components/text/light_text.dart';
import 'package:happypaws/common/services/ImagesService.dart';
import 'package:happypaws/common/services/PetBreedsService.dart';
import 'package:happypaws/common/services/PetTypesService.dart';
import 'package:happypaws/common/services/PetsService.dart';
import 'package:happypaws/common/utilities/toast.dart';
import 'package:happypaws/common/utilities/Colors.dart';
import 'package:happypaws/common/utilities/constants.dart';
import 'package:happypaws/desktop/components/api_data_dropdown_menu.dart';
import 'package:happypaws/desktop/components/searchable_dropdown.dart';
import 'package:happypaws/desktop/components/buttons/primary_button.dart';
import 'package:happypaws/desktop/components/buttons/secondary_button.dart';
import 'package:happypaws/desktop/components/gender_dropdown_menu.dart';
import 'package:happypaws/desktop/components/input_field.dart';
import 'package:happypaws/desktop/components/spinner.dart';
import 'package:happypaws/desktop/dialogs/add_edit_medication_dialog.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'add_edit_allergy_dialog.dart';

class AddEditPatientMenu extends StatefulWidget {
  final VoidCallback onClose;
  final MyVoidCallback onAdd;
  final MyVoidCallback onEdit;
  final Map<String, dynamic>? data;

  const AddEditPatientMenu({
    Key? key,
    required this.onClose,
    this.data,
    required this.onAdd,
    required this.onEdit,
  }) : super(key: key);

  @override
  _AddEditPatientMenuState createState() => _AddEditPatientMenuState();
}

class _AddEditPatientMenuState extends State<AddEditPatientMenu> {
  Map<String, dynamic> data = {};
  String selectedGender = "Unknown";
  String selectedDate = 'Select date';
  String? selectedPetType;
  final _formKey = GlobalKey<FormState>();
  bool disabledButton = false;

  String? selectedPetBreed;
  Map<String, dynamic>? petTypes;
  List<dynamic>? petBreeds;
  String selectedRole = '';
  final ImagePicker _imagePicker = ImagePicker();
  File? _selectedImage;
  Map<String, dynamic>? profilePhoto;
  List<dynamic>? employeePositions;

  @override
  void initState() {
    super.initState();
    if (widget.data != null) {
      setInit();
    }
    fetchData();
  }

  Future<void> setInit() async {
    setState(() {
      data = widget.data!;
      selectedGender = widget.data!["gender"];
    });
    if (widget.data!['photoId'] != null) {
      var photo = await ImagesService().get("/${widget.data!['photoId']}");
      setState(() {
        data['photo'] = photo.data;
      });
    }
  }

  Future<void> fetchData() async {
    var responsePetTypes = await PetTypesService().getPaged("", 1, 999);
    if (responsePetTypes.statusCode == 200) {
      setState(() {
        petTypes = responsePetTypes.data;
      });
      if (widget.data != null) {
        fetchPetBreeds(widget.data!['petBreed']['petType']['id'].toString());
        final formatter = DateFormat('dd.MM.yyyy');
        setState(() {
          selectedDate =
              formatter.format(DateTime.parse(widget.data!['birthDate']));
          profilePhoto = widget.data!['photo'];
          selectedPetType =
              widget.data!['petBreed']['petType']['id'].toString();
          selectedPetBreed = widget.data!['petBreed']['id'].toString();
        });
      }
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

  Future<String> uploadImage(File imageFile) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference storageReference =
        FirebaseStorage.instance.ref().child('images/$fileName');
    UploadTask uploadTask = storageReference.putFile(imageFile);
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadURL = await taskSnapshot.ref.getDownloadURL();
    return downloadURL;
  }

  Future<void> _pickImage() async {
    final XFile? selectedImage =
        await _imagePicker.pickImage(source: ImageSource.gallery);

    // if (selectedImage != null) {
    //   setState(() {
    //     _selectedImage = File(selectedImage.path);
    //     user["photoFile"] = selectedImage.path;
    //   });
    // }
     if (selectedImage != null) {
    File imageFile = File(selectedImage.path);
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();

      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.ref().child("images/$fileName");
      UploadTask uploadTask = ref.putFile(imageFile);

      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => {});

      String downloadURL = await taskSnapshot.ref.getDownloadURL();

      setState(() {
        _selectedImage = imageFile;
      });

      print("Image uploaded successfully. URL: $downloadURL");
    } catch (e) {
      print("Failed to upload image: $e");
    }
     }
  }

  Future<void> addPatient() async {
    try {
      setState(() {
        disabledButton = true;
      });
      if (data['weight'] is double) {
        data['weight'] = data['weight'].toString().replaceAll('.', ',');
      } else {
        data['weight'] = data['weight'].replaceAll('.', ',');
      }
      var response = await PetsService().postMultiPartRequest('', data);
      if (response.statusCode == 200) {
        setState(() {
          disabledButton = false;
        });
        widget.onAdd(response.data);
        widget.onClose();
        if (!mounted) return;
        ToastHelper.showToastSuccess(
            context, "You have successfully added a new patient!");
      } else {
        setState(() {
          disabledButton = false;
        });
        throw Exception('Error occured');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> editPatient() async {
    try {
      setState(() {
        disabledButton = true;
      });
      if (data['weight'] is double || data['weight'] is String) {
        data['weight'] = data['weight'].toString().replaceAll('.', ',');
      }
      var response = await PetsService().putMultiPartRequest('', data);
      if (response.statusCode == 200) {
        setState(() {
          disabledButton = false;
        });
        widget.onEdit(response.data);
        widget.onClose();
        if (!mounted) return;
        ToastHelper.showToastSuccess(context,
            "You have successfully edited selected patient information!");
      } else {
        setState(() {
          disabledButton = false;
        });
        throw Exception('Error occured');
      }
    } catch (e) {
      rethrow;
    }
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
                widget.data!['petAllergies'].add(value);
              });
            },
            onEdit: (value) {
              setState(() {
                widget.data!['petAllergies'][widget.data!['petAllergies']
                    .indexWhere((x) => x['id'] == value['id'])] = value;
              });
            },
            onRemove: (value) {
              setState(() {
                widget.data!['petAllergies']
                    .removeWhere((x) => x['id'] == value);
              });
            },
            data: data,
            petId: widget.data!['id'],
            onClosed: () {
              Navigator.of(context).pop();
            },
          ),
        );
      },
    );
  }

  void showAddMedicationMenu(BuildContext context,
      {Map<String, dynamic>? data}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          insetPadding: const EdgeInsets.symmetric(vertical: 60, horizontal: 0),
          contentPadding: const EdgeInsets.all(8),
          content: AddMedicationMenu(
            onAdd: (value) {
              setState(() {
                widget.data!['petMedications'].add(value);
              });
            },
            onEdit: (value) {
              setState(() {
                widget.data!['petMedications'][widget.data!['petMedications']
                    .indexWhere((x) => x['id'] == value['id'])] = value;
              });
            },
            onRemove: (value) {
              setState(() {
                widget.data!['petMedications']
                    .removeWhere((x) => x['id'] == value);
              });
            },
            data: data,
            petId: widget.data!['id'],
            onClosed: () {
              Navigator.of(context).pop();
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      height: MediaQuery.of(context).size.width,
      child: petTypes == null
          ? const Spinner()
          : SingleChildScrollView(
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
                      //  Image.network("https://firebasestorage.googleapis.com/v0/b/happy-paws-fb.appspot.com/o/images%2F1718234082914?alt=media&token=6e302f75-090a-4aa2-a9a5-be23da488e12"),
                      Text(
                        widget.data != null
                            ? "Edit patient info"
                            : "Add new patient",
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
                    padding: const EdgeInsets.all(12),
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
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
                                              BorderRadius.circular(100),
                                          child: _selectedImage != null
                                              ? Image.file(
                                                  _selectedImage!,
                                                  fit: BoxFit.cover,
                                                )
                                              : (widget.data != null &&
                                                      widget.data!['photo'] !=
                                                          null)
                                                  ? Image.memory(
                                                      base64.decode(widget
                                                          .data!['photo']
                                                              ['data']
                                                          .toString()),
                                                      fit: BoxFit.cover)
                                                  : const Image(
                                                      image: AssetImage(
                                                          "assets/images/pet_default.jpg"),
                                                      fit: BoxFit.cover)),
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
                                )),
                            SearchableDropdown(
                              onChanged: (value) => setState(() {
                                data['ownerId'] = value;
                              }),
                              data: widget.data == null
                                  ? null
                                  : widget.data!['owner'],
                            ),
                            Wrap(
                              direction: Axis.horizontal,
                              alignment: WrapAlignment.start,
                              spacing: 10,
                              children: [
                                FractionallySizedBox(
                                  widthFactor: 0.48,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      InputField(
                                        label: "Name:",
                                        onChanged: (value) => setState(() {
                                          data['name'] = value;
                                        }),
                                        value: data['name'],
                                      ),
                                      InputField(
                                        label: "Weight (kg):",
                                        onChanged: (value) => setState(() {
                                          data['weight'] = value;
                                        }),
                                        isNumber: true,
                                        value: data['weight']?.toString(),
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
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      if (widget.data != null &&
                                          !widget.data!['petAllergies'].isEmpty)
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const LightText(
                                              label: "Allergies:",
                                              fontSize: 14,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                for (var item in widget
                                                    .data!['petAllergies'])
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 8.0),
                                                    child: GestureDetector(
                                                      onTap: () =>
                                                          showAddAllergyMenu(
                                                              context,
                                                              data: item),
                                                      child: LightText(
                                                        label: item['name'],
                                                        fontSize: 14,
                                                        color: item['allergySeverity'] ==
                                                                'Mild'
                                                            ? AppColors.success
                                                            : item['allergySeverity'] ==
                                                                    'Moderate'
                                                                ? AppColors.info
                                                                : AppColors
                                                                    .error,
                                                      ),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        ),
                                    ],
                                  ),
                                ),
                                FractionallySizedBox(
                                  widthFactor: 0.48,
                                  child: Column(
                                    children: [
                                      GenderDropdownMenu(
                                        selectedGender: selectedGender,
                                        onChanged: (newValue) => setState(() {
                                          selectedGender = newValue!;
                                          data['gender'] = newValue;
                                        }),
                                      ),
                                      birthDateInput(context),
                                      ApiDataDropdownMenu(
                                        items: petBreeds == null
                                            ? List.empty()
                                            : petBreeds!,
                                        label: "Pet breed:",
                                        onChanged: (String? newValue) =>
                                            setState(() {
                                          selectedPetBreed = newValue;
                                          data['petBreedId'] = newValue;
                                        }),
                                        selectedOption: selectedPetBreed,
                                        isDisabled: selectedPetType == null
                                            ? true
                                            : false,
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      if (widget.data != null &&
                                          !widget
                                              .data!['petMedications'].isEmpty)
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const LightText(
                                              label: "Medications:",
                                              fontSize: 14,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                for (var item in widget
                                                    .data!['petMedications'])
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 8.0),
                                                    child: GestureDetector(
                                                      onTap: () =>
                                                          showAddMedicationMenu(
                                                              context,
                                                              data: item),
                                                      child: LightText(
                                                        label: item[
                                                                'medicationName'] +
                                                            ' (' +
                                                            item['dosage']
                                                                .toString() +
                                                            ' mg)',
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            if (widget.data != null)
                              Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: PrimaryButton(
                                        onPressed: () {
                                          showAddAllergyMenu(context);
                                        },
                                        label: "Add new allergy",
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: PrimaryButton(
                                        onPressed: () {
                                          showAddMedicationMenu(context);
                                        },
                                        label: "Add new medication",
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            const SizedBox(
                              height: 20,
                            ),
                            PrimaryButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  widget.data != null
                                      ? editPatient()
                                      : addPatient();
                                }
                              },
                              isDisabled: disabledButton,
                              label: widget.data != null
                                  ? "Edit patient information"
                                  : "Add new patient",
                              width: double.infinity,
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }

  Column birthDateInput(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 16,
        ),
        const LightText(
          label: 'Date of birth (approximately):',
          fontSize: 14,
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
              child: SecondaryButton(
                height: 40,
                icon: Icons.date_range_rounded,
                label: selectedDate,
                width: double.infinity,
                onPressed: () {
                  _showDatePicker(context);
                },
              ),
            ),
          ],
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
            width: MediaQuery.of(context).size.width / 3,
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

  Column positionsDropdownMenu() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 16,
        ),
        const LightText(
          label: "Position:",
          fontSize: 14,
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
            width: double.infinity,
            height: 40,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xffF2F2F2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: selectedRole,
                  underline: Container(),
                  borderRadius: BorderRadius.circular(10),
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedRole = newValue!;
                      data['employeePosition'] = newValue;
                    });
                  },
                  items: [
                    for (var item in employeePositions!)
                      DropdownMenuItem<String>(
                        value: item['value'].toString(),
                        child: Text(item['value'][0] +
                            item['value']
                                .split(RegExp(r'(?=[A-Z])'))
                                .join(' ')
                                .toLowerCase()
                                .substring(1)),
                      ),
                  ],
                ),
              ),
            )),
      ],
    );
  }
}
