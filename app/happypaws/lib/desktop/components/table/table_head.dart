import 'package:flutter/material.dart';

class TableHead extends StatefulWidget {
  final String header;
  final AlignmentGeometry alignmentGeometry;
  final double paddingHorizontal;
  final double paddingVertical;


  const TableHead({
    super.key,
    required this.header,
    required this.alignmentGeometry,
    this.paddingHorizontal=25,
    this.paddingVertical=10
  });

  @override
  State<TableHead> createState() => _TableHeadState();
}

class _TableHeadState extends State<TableHead> {
  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: Align(
        alignment: widget.alignmentGeometry,
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: widget.paddingHorizontal, vertical: widget.paddingVertical),
          child: Text(
            widget.header,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
