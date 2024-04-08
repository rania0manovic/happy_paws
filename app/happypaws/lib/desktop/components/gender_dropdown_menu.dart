import 'package:flutter/material.dart';
import 'package:happypaws/common/components/text/LightText.dart';

class GenderDropdownMenu extends StatefulWidget {
  final String? selectedGender;
  final void Function(String?)? onChanged;

  const GenderDropdownMenu({
    Key? key,
    this.selectedGender,
    this.onChanged,
  }) : super(key: key);

  @override
  _GenderDropdownMenuState createState() => _GenderDropdownMenuState();
}

class _GenderDropdownMenuState extends State<GenderDropdownMenu> {
  String? selectedGender;

  @override
  void initState() {
    super.initState();
    selectedGender = widget.selectedGender;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 16,
        ),
       const LightText(
          label: 'Gender:',
          fontSize: 14,
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
           width: double.infinity,
        height: 40,
          decoration: BoxDecoration(
            color: Color.fromARGB(117, 255, 255, 255),
            borderRadius: BorderRadius.circular(10),
          ),
          child: DropdownButton<String>(
            padding: EdgeInsets.symmetric(horizontal: 10),
            isExpanded: true,
            value: selectedGender,
            underline: Container(),
            borderRadius: BorderRadius.circular(10),
            icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
            onChanged: (String? newValue) {
              setState(() {
                selectedGender = newValue;
              });
              if (widget.onChanged != null) {
                widget.onChanged!(newValue);
              }
            },
            items: <String>[
              'Unknown',
              'Female',
              'Male',
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}