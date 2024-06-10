import 'package:flutter/material.dart';
import 'package:happypaws/common/services/AuthService.dart';
import 'package:happypaws/common/utilities/toast.dart';
import 'package:happypaws/common/utilities/Colors.dart';
import 'package:happypaws/desktop/components/buttons/primary_button.dart';
import 'package:happypaws/desktop/components/input_field.dart';

class ChangePasswordMenu extends StatefulWidget {
  final VoidCallback onClosed;
  final VoidCallback onCanceled;

  final Map<String, dynamic>? data;
  const ChangePasswordMenu(
      {super.key,
      required this.onClosed,
      this.data,
      required StateSetter setState, required this.onCanceled});

  @override
  State<ChangePasswordMenu> createState() => _ChangePasswordMenuState();
}

class _ChangePasswordMenuState extends State<ChangePasswordMenu> {
  Map<String, dynamic> data = {};
  bool isObscure = false;
  @override
  initState() {
    super.initState();
  }

  Future<void> changePassword() async {
    try {
      var response = await AuthService().updatePassword(data);
      if (response.statusCode == 200) {
        await AuthService().logOut();
        widget.onClosed();
        if (!mounted) return;
        ToastHelper.showToastSuccess(context,
            "You have successfully updated your password! Please login with your new password.");
      } else if (response.statusCode == 403) {
        if (!mounted) return;
        ToastHelper.showToastSuccess(
            context, "Wrong email or current password! Please try again.");
      } else {
        throw Exception('Error occured');
      }
    } catch (e) {
      rethrow;
    }
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const IconButton(
                    icon: Icon(Icons.inventory_2_outlined),
                    onPressed: null,
                    color: AppColors.gray,
                  ),
                  const Text(
                    "Change password",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: widget.onCanceled,
                    icon: const Icon(Icons.close),
                    color: Colors.grey,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: [
                    InputField(
                      label: "Email:",
                      value: '',
                      onChanged: (value) => setState(() {
                        data['email'] = value;
                      }),
                    ),
                    InputField(
                      label: "Old password:",
                      value: '',
                      onChanged: (value) => setState(() {
                        data['oldPassword'] = value;
                      }),
                      isObscure: !isObscure,
                    ),
                    InputField(
                      label: "New password:",
                      value: '',
                      onChanged: (value) => setState(() {
                        data['newPassword'] = value;
                      }),
                      isObscure: !isObscure,
                      customValidation: () {
                        RegExp passwordRegex = RegExp(
                            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                        return passwordRegex.hasMatch(data['newPassword']);
                      },
                      customMessage:
                          'Password must be at least 8 characters with 1 uppercase, 1 number, and 1 special character',
                    ),
                    InputField(
                      label: "Confirm new password:",
                      value: '',
                      onChanged: (value) => setState(() {
                        data['newPasswordConfirm']=value;
                      }),
                      customValidation: () {
                        return data['newPassword'] ==
                            data['newPasswordConfirm'];
                      },
                      customMessage: "Passwords do not match!",
                      isObscure: !isObscure,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(
                          activeColor: AppColors.primary,
                          value: isObscure,
                          visualDensity: VisualDensity.compact,
                          onChanged: (bool? value) {
                            setState(() {
                              isObscure = value!;
                            });
                          },
                        ),
                        const Text(
                          "Show password",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
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
                          changePassword();
                        }
                      },
                      label: "Change",
                      width: double.infinity,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
