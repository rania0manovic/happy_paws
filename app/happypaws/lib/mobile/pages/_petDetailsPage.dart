import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:happypaws/common/components/text/LightText.dart';
import 'package:happypaws/common/services/PetBreedsService.dart';
import 'package:happypaws/common/services/PetTypesService.dart';
import 'package:happypaws/common/services/PetsService.dart';
import 'package:happypaws/common/utilities/Toast.dart';
import 'package:happypaws/common/utilities/colors.dart';
import 'package:happypaws/common/utilities/constants.dart';
import 'package:happypaws/desktop/components/buttons/go_back_button.dart';
import 'package:happypaws/desktop/components/buttons/primary_button.dart';
import 'package:happypaws/desktop/components/buttons/primary_icon_button.dart';
import 'package:happypaws/desktop/components/dialogs/confirmationDialog.dart';
import 'package:happypaws/desktop/components/spinner.dart';
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
       
          fetchPetBreeds(responsePetData.data['petBreed']['petType']['id'].toString());
          final formatter = DateFormat('dd.MM.yyyy');
          setState(() {
            data = responsePetData.data;
            selectedDate =
                formatter.format(DateTime.parse(responsePetData.data['birthDate']));
            profilePhoto = responsePetData.data['photo'];
            selectedGender = responsePetData.data['gender'];
            selectedPetType = responsePetData.data['petBreed']['petType']['id'].toString();
            selectedPetBreed = responsePetData.data['petBreed']['id'].toString();
          });
        }
      } else {
        data['OwnerId'] = widget.userId;
      }
    }
  }

  Future<void> addPet() async {
    try {
      final response = await PetsService().post("", data);
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
      final response = await PetsService().put("", data);
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
        data["PhotoFile"] = selectedImage.path;
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
                            const EdgeInsets.only(left: 20, right: 20, top: 0),
                        child: Align(
                          alignment: Alignment.centerLeft,
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
                                  print(newValue);

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
                                  petBreeds == null ? List.empty() : petBreeds!,
                                  "Pet breed:",
                                  (String? newValue) => setState(() {
                                        selectedPetBreed = newValue;
                                        data['petBreedId'] = newValue;
                                      }),
                                  selectedPetBreed,
                                  isDisabeled:
                                      selectedPetType == null ? true : false),
                              birthDateInput(context),
                              dropdownMenu("Gender:", "gender"),
                              // TODO: allergies and medication info
                              // allergiesSection(),
                              // medicationSection(),
                              const SizedBox(
                                height: 20,
                              ),
                              PrimaryButton(
                                onPressed: () {
                                  widget.petId == null ? addPet() : editPet();
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
            children: [listItem("Vetmedin 5mg")],
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
          width: double.infinity,
          child: Wrap(
            spacing: 18.0,
            runSpacing: 8.0,
            children: [listItem("Soy"), listItem("Eggs")],
          ),
        ),
      ],
    );
  }

  Wrap listItem(String allergy) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Icon(
          Icons.circle,
          size: 8.0,
          color: Colors.grey.shade400,
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
          height: 49,
          child: TextFormField(
            onChanged: (value) {
              setState(() {
                data[key] = value;
              });
            },
            initialValue: initialValue,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xfff2f2f2),
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xff3F0D84),
                      width: 5.0,
                    ),
                    borderRadius: BorderRadius.circular(10))),
          ),
        )
      ],
    );
  }
}
