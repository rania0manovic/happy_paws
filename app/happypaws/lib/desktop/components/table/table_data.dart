import 'package:flutter/material.dart';

class TableData extends StatefulWidget {
  final String data;
  final AlignmentGeometry alignmentGeometry;
 final double paddingHorizontal;
  final double paddingVertical;
  const TableData({
    super.key,
    required this.data,
    this.alignmentGeometry = Alignment.center,
    this.paddingHorizontal=0,
    this.paddingVertical=20
  });

  @override
  State<TableData> createState() => _TableDataState();
}

class _TableDataState extends State<TableData> {
  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: widget.paddingHorizontal, vertical: widget.paddingVertical),
        child: Align(
          alignment: widget.alignmentGeometry,
          child: Tooltip(
            message: widget.data.length > 20 ? widget.data : '',
            child: Text(
              widget.data.length > 20
                  ? '${widget.data.substring(0, 20)}...'
                  : widget.data,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }
}
