import 'package:flutter/material.dart';
import 'package:happypaws/common/components/text/LightText.dart';

class ApiDataDropdownMenu extends StatefulWidget {
  final dynamic items;
  final String label;
  final void Function(String? newValue) onChanged;
  final String? selectedOption;
  final bool isDisabled;
  final String? propKey;
  const ApiDataDropdownMenu(
      {Key? key,
      required this.items,
      required this.label,
      required this.onChanged,
      required this.selectedOption,
      this.isDisabled = false,
      this.propKey = 'name'})
      : super(key: key);

  @override
  _ApiDataDropdownMenuState createState() => _ApiDataDropdownMenuState();
}

class _ApiDataDropdownMenuState extends State<ApiDataDropdownMenu> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          height: 16,
        ),
        LightText(
          label: widget.label,
          fontSize: 14,
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          height: 40,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color.fromARGB(117, 255, 255, 255),
            borderRadius: BorderRadius.circular(10),
          ),
          child: DropdownButton<String>(
            padding: EdgeInsets.symmetric(horizontal: 10),
            isExpanded: true,
            value: widget.selectedOption,
            hint: const Text('Select'),
            underline: Container(),
            borderRadius: BorderRadius.circular(10),
            icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
            onChanged: widget.isDisabled ? null : widget.onChanged,
            disabledHint: widget.selectedOption != null
                ? const Text("No breed found...")
                : const Text("Select the type first..."),
            items: [
              for (var item in widget.items)
                DropdownMenuItem<String>(
                  value: item['id'].toString(),
                  child: Text(
                    item['name'],
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
