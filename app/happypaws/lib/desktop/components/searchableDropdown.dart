import 'package:flutter/material.dart';
import 'package:happypaws/common/services/UsersService.dart';
import 'package:happypaws/common/utilities/constants.dart';
import 'package:happypaws/desktop/components/input_field.dart';
import 'package:happypaws/desktop/components/spinner.dart';

class SearchableDropdown extends StatefulWidget {
  final dynamic data;
  final MyVoidCallback onChanged;
  const SearchableDropdown({super.key, this.data, required this.onChanged});

  @override
  _SearchableDropdownState createState() => _SearchableDropdownState();
}

class _SearchableDropdownState extends State<SearchableDropdown> {
  Map<String, dynamic>? options;
  String? selectedOption;
  bool isLoading = false;

  @override void initState() {
    super.initState();
    if(widget.data!=null){
      setState(() {
      options={'items':[widget.data]};
      });
      selectedOption=widget.data!['id'].toString();
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
//TODO: make it reusable 
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      InputField(
        label: "Type in owner name or surname:",
        onChanged: (value) {
          _fetchData(value);
        },
      ),
      const SizedBox(height: 20),
      isLoading
          ? const Spinner()
          : Container(
              height: 40,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color.fromARGB(117, 255, 255, 255),
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownButton<String>(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                isExpanded: true,
                hint: const Text('Select owner'),
                underline: Container(),
                borderRadius: BorderRadius.circular(10),
                value: selectedOption,
                disabledHint: const Text("Type name in the input field first..."),
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
