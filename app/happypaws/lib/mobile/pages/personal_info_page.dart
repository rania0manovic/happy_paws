import 'dart:convert';
import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:happypaws/common/services/AuthService.dart';
import 'package:happypaws/common/services/ImagesService.dart';
import 'package:happypaws/common/services/UsersService.dart';
import 'package:happypaws/common/utilities/colors.dart';
import 'package:happypaws/common/utilities/toast.dart';
import 'package:happypaws/desktop/components/buttons/go_back_button.dart';
import 'package:happypaws/desktop/components/buttons/primary_button.dart';
import 'package:happypaws/desktop/components/spinner.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

@RoutePage()
class PersonalInformationPage extends StatefulWidget {
  const PersonalInformationPage({super.key});

  @override
  State<PersonalInformationPage> createState() =>
      _PersonalInformationPageState();
}

class _PersonalInformationPageState extends State<PersonalInformationPage> {
  String selectedValue = 'Unknown';
  late dynamic user = Null;
  late dynamic formatedCardNumber = Null;
  final ImagePicker _imagePicker = ImagePicker();
  File? _selectedImage;
  Map<String, dynamic>? profilePhoto;
  final _formKey = GlobalKey<FormState>();
  Map<String, bool> errorStates = {};

  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  Future<void> fetchUser() async {
    var fetchedUser = await AuthService().getCurrentUser();
    if (fetchedUser != null &&
        fetchedUser['ProfilePhotoId'] != null &&
        fetchedUser['ProfilePhotoId'] != "") {
      var image =
          await ImagesService().get("/${fetchedUser['ProfilePhotoId']}");
      if (image.statusCode == 200) {
        setState(() {
          profilePhoto = json.decode(image.body);
        });
      }
    }
    setState(() {
      selectedValue = fetchedUser?['Gender'];
      user = fetchedUser;
    });
  }

  Future<void> updateUser() async {
    try {
      var response = await UsersService().put('', user);
      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        Map<String, dynamic> jsonResponse = json.decode(responseBody);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', jsonResponse['token'].toString());
        if (!mounted) return;
        ToastHelper.showToastSuccess(
            context, "Sucessfully updated user information!");
      } else {
        throw Exception();
      }
    } catch (e) {
      ToastHelper.showToastError(
          context, "An error has occured! Please try again later.");
      rethrow;
    }
  }

  Future<void> _pickImage() async {
    final XFile? selectedImage =
        await _imagePicker.pickImage(source: ImageSource.gallery);

    if (selectedImage != null) {
      setState(() {
        _selectedImage = File(selectedImage.path);
        user["photoFile"] = selectedImage.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const GoBackButton(),
          Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: user != Null
                    ? Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                                alignment: Alignment.topCenter,
                                child: Column(
                                  children: [
                                    const Text("Personal information",
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
                                            ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                child: _selectedImage != null
                                                    ? Image.file(
                                                        _selectedImage!)
                                                    : profilePhoto != null
                                                        ? Image.memory(
                                                            base64.decode(
                                                                profilePhoto![
                                                                        'data']
                                                                    .toString()),
                                                          )
                                                        : const Image(
                                                            image: AssetImage(
                                                                "assets/images/user.png"))),
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
                            inputField('Name', user["FirstName"], "FirstName"),
                            inputField('Surname', user["LastName"], "LastName"),
                            inputField('Email', user["Email"], "Email"),
                            dropdownMenu("Gender"),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text("Change password",
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500)),
                            const SizedBox(
                              height: 20,
                            ),
                            PrimaryButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  updateUser();
                                }
                              },
                              label: 'Update',
                              width: double.infinity,
                              fontSize: 20,
                            )
                          ],
                        ),
                      )
                    : const Spinner(),
              )),
        ]),
      ),
    );
  }

  Column dropdownMenu(String label) {
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
                  value: selectedValue,
                  underline: Container(),
                  borderRadius: BorderRadius.circular(10),
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedValue = newValue!;
                      user[label] = selectedValue;
                    });
                  },
                  items: <String>[
                    'Female',
                    'Male',
                    'Unknown',
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

  Column inputField(String label, String? initialValue, String? objName) {
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
          height: errorStates[objName] ?? false ? 75 : 50,
          child: TextFormField(
            onChanged: (value) {
              setState(() {
                user[objName] = value;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                setState(() {
                  errorStates[objName!] = true;
                });
                return 'This field is required';
              }
              setState(() {
                errorStates[objName!] = false;
              });
              return null;
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
