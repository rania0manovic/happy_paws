import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:happypaws/common/components/text/light_text.dart';
import 'package:happypaws/common/utilities/Colors.dart';

class ApiDataDropdownMenu extends StatefulWidget {
  final dynamic items;
  final String? label;
  final void Function(String? newValue) onChanged;
  final String? selectedOption;
  final String hint;
  final bool isDisabled;
  final String? propKey;
  const ApiDataDropdownMenu(
      {Key? key,
      required this.items,
      this.label,
      required this.onChanged,
      required this.selectedOption,
      this.isDisabled = false,
      this.propKey = 'name',
      this.hint = "Select..."})
      : super(key: key);

  @override
  _ApiDataDropdownMenuState createState() => _ApiDataDropdownMenuState();
}

class _ApiDataDropdownMenuState extends State<ApiDataDropdownMenu> {
  bool isError = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (widget.label != null)
          Column(
            children: [
              const SizedBox(
                height: 16,
              ),
              LightText(
                label: widget.label!,
                fontSize: 14,
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        SizedBox(
          height: isError ? 65 : 40,
          width: double.infinity,
          child: DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              errorStyle: TextStyle(color: AppColors.error, fontSize: 14),
              fillColor: Colors.white38,
              filled: true,
              border: UnderlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
            ),
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
            isExpanded: true,
            value: widget.selectedOption,
            hint: Text(widget.hint),
            borderRadius: BorderRadius.circular(10),
            icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
            onChanged: widget.isDisabled ? null : widget.onChanged,
            disabledHint: widget.selectedOption != null
                ? const Text("No options found...")
                : const Text("Select the type first..."),
            items: [
              for (var item in widget.items)
                DropdownMenuItem<String>(
                  value: item['id'].toString(),
                  child: Text(
                    widget.label == "Subcategory:"
                        ? item['productSubcategory']['name']
                        : item['name'],
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
