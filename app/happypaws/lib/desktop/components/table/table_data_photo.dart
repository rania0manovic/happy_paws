import 'package:flutter/material.dart';
import 'dart:convert';

class TableDataPhoto extends StatefulWidget {
  final String data;
  final double size;
  final double borderRadius;

  const TableDataPhoto({
    required this.data,
    this.size=40,
    this.borderRadius=1000
  });

  @override
  State<TableDataPhoto> createState() => _TableDataPhotoState();
}

class _TableDataPhotoState extends State<TableDataPhoto> {
  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: SizedBox(
        height: widget.size,
        width: widget.size,
        child: FittedBox(
          fit: BoxFit.contain,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            child: Image.memory(
              base64.decode(widget.data),
              width: widget.size,
              height: widget.size,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
