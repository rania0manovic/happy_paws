import 'package:flutter/material.dart';
import 'package:happypaws/common/services/UsersService.dart';
import 'package:happypaws/common/utilities/Colors.dart';
import 'package:happypaws/common/utilities/constants.dart';
import 'package:happypaws/desktop/components/input_field.dart';
import 'package:happypaws/desktop/components/spinner.dart';

class SearchableDropdown extends StatefulWidget {
  final dynamic data;
  final MyVoidCallback onChanged;
  const SearchableDropdown({super.key, this.data, required this.onChanged});

  @override
  State<SearchableDropdown> createState() => _SearchableDropdownState();
}

class _SearchableDropdownState extends State<SearchableDropdown> {
  Map<String, dynamic>? options;
  String? selectedOption;
  bool isLoading = false;
  bool isError = false;

  @override
  void initState() {
    super.initState();
    if (widget.data != null) {
      setState(() {
        options = {
          'items': [widget.data]
        };
      });
      selectedOption = widget.data!['id'].toString();
    }
  }

  void _fetchData(String query) async {
    setState(() {
      isLoading = true;
    });
    final response = await UsersService()
        .getPaged('', 1, 10, searchObject: {'fullName': query});
    if (response.statusCode == 200) {
      setState(() {
        selectedOption = null;
        options = response.data;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      InputField(
        isRequired: false,
        label: "Type in owner name or surname:",
        onChanged: (value) {
          _fetchData(value);
        },
      ),
      const SizedBox(height: 20),
      isLoading
          ? const Spinner()
          : SizedBox(
              width: double.infinity,
              child: DropdownButtonFormField<String>(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    setState(() {
                      isError = true;
                    });
                    return "This field is required";
                  }
                  setState(() {
                    isError = false;
                  });
                  return null;
                },
                decoration: const InputDecoration(
                  errorStyle: TextStyle(color: AppColors.error, fontSize: 14),
                  fillColor: AppColors.fill,
                  filled: true,
                  border: UnderlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
                isExpanded: true,
                borderRadius: BorderRadius.circular(10),
                value: selectedOption,
                disabledHint:
                    const Text("Type name in the input field first..."),
                onChanged: options != null
                    ? (String? value) {
                        setState(() {
                          selectedOption = value;
                          widget.onChanged(value);
                        });
                      }
                    : null,
                items: options == null
                    ? null
                    : [
                        for (var item in options!['items'])
                          DropdownMenuItem<String>(
                            value: item['id'].toString(),
                            child: Text(
                              item['fullName'],
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                      ],
              ),
            )
    ]);
  }
}
