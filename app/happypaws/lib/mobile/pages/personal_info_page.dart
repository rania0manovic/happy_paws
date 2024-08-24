import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:happypaws/common/components/dialogs/change_password_dialog.dart';
import 'package:happypaws/common/services/AuthService.dart';
import 'package:happypaws/common/services/ImagesService.dart';
import 'package:happypaws/common/services/UsersService.dart';
import 'package:happypaws/common/utilities/colors.dart';
import 'package:happypaws/common/utilities/firebase_storage.dart';
import 'package:happypaws/common/utilities/toast.dart';
import 'package:happypaws/desktop/components/buttons/go_back_button.dart';
import 'package:happypaws/desktop/components/buttons/primary_button.dart';
import 'package:happypaws/desktop/components/spinner.dart';
import 'package:happypaws/mobile/components/input_field.dart';
import 'package:happypaws/routes/app_router.gr.dart';
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
  bool isSubscribed = false;
  late dynamic formatedCardNumber = Null;
  File? _selectedImage;
  Map<String, dynamic>? profilePhoto;
  final _formKey = GlobalKey<FormState>();
  bool isDisabeledButton = false;

  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  Future<void> fetchUser() async {
    var fetchedUser = await AuthService().getCurrentUser();
    if (fetchedUser != null && fetchedUser['IsSubscribed'] == "True") {
      setState(() {
        isSubscribed = true;
      });
    }
    if (fetchedUser != null &&
        fetchedUser['ProfilePhotoId'] != null &&
        fetchedUser['ProfilePhotoId'] != "") {
      var image =
          await ImagesService().get("/${fetchedUser['ProfilePhotoId']}");
      if (image.statusCode == 200) {
        setState(() {
          profilePhoto = image.data;
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
      setState(() {
        isDisabeledButton = true;
      });
      dynamic imageUrl;
      if (_selectedImage != null) {
        if (profilePhoto != null) {
          imageUrl = await FirebaseStorageHelper.updateImage(
              _selectedImage!, profilePhoto!['downloadURL']);
        } else {
          imageUrl = await FirebaseStorageHelper.addImage(_selectedImage!);
        }
        if (imageUrl != null) {
          setState(() {
            user!['downloadUrl'] = imageUrl['downloadUrl'];
          });
        }
      }
      if (isSubscribed == true) {
        user!['IsSubscribed'] = true;
      } else {
        user!['IsSubscribed'] = false;
      }
      var response = await UsersService().put('', user);
      if (response.statusCode == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', response.data['token'].toString());
        setState(() {
          isDisabeledButton = false;
        });
        if (!mounted) return;
        ToastHelper.showToastSuccess(
            context, "Sucessfully updated user information!");
      } else {
        throw Exception();
      }
    } on DioException catch (e) {
      setState(() {
        isDisabeledButton = false;
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
                                            SizedBox(
                                              height: 128,
                                              width: 128,
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  child: _selectedImage != null
                                                      ? Image.file(
                                                          _selectedImage!,
                                                          fit: BoxFit.cover,
                                                        )
                                                      : profilePhoto != null
                                                          ? Image.network(
                                                              profilePhoto![
                                                                  'downloadURL'],
                                                              fit: BoxFit.cover,
                                                            )
                                                          : const Image(
                                                              image: AssetImage(
                                                                  "assets/images/user.png"))),
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
                              onChanged: (value) {
                                setState(() {
                                  user['firstName'] = value;
                                });
                              },
                              initialValue: user["FirstName"],
                            ),
                            InputField(
                              label: 'Surname:',
                              onChanged: (value) {
                                setState(() {
                                  user['lastName'] = value;
                                });
                              },
                              initialValue: user["LastName"],
                            ),
                            InputField(
                              label: 'Email:',
                              enabled: false,
                              onChanged: (value) {},
                              initialValue: user["Email"],
                            ),
                            dropdownMenu("Gender"),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Checkbox(
                                    activeColor: AppColors.primary,
                                    value: isSubscribed,
                                    visualDensity: VisualDensity.compact,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        isSubscribed = !isSubscribed;
                                      });
                                    },
                                  ),
                                  const Text(
                                    "Subscribed to newsletter",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return StatefulBuilder(
                                      builder: (context, setState) {
                                        return AlertDialog(
                                          contentPadding:
                                              const EdgeInsets.all(8),
                                          content: ChangePasswordMenu(
                                            setState: setState,
                                            onClosed: () {
                                              Navigator.of(context).pop();
                                              context.router
                                                  .push(const LoginRoute());
                                            },
                                            onCanceled: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                              child: const Text("Change password",
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500)),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            PrimaryButton(
                              isDisabled: isDisabeledButton,
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
}
