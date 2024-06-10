import 'package:flutter/material.dart';
import 'package:happypaws/common/utilities/Colors.dart';

class TableActions extends StatefulWidget {
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const TableActions({
    super.key,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  State<TableActions> createState() => _TableActionsState();
}

class _TableActionsState extends State<TableActions> {
  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ActionButton(
              onPressed: widget.onEdit,
              icon: Icons.edit_outlined,
              iconColor: AppColors.gray,
            ),
            ActionButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ConfirmationDialog(
                      title: 'Confirmation',
                      content: 'Are you sure you want to delete this entry?',
                      onYesPressed: () {
                        Navigator.of(context).pop();
                        widget.onDelete();
                      },
                      onNoPressed: () {
                        Navigator.of(context).pop();
                      },
                    );
                  },
                );
              },
              icon: Icons.delete_outline_outlined,
              iconColor: AppColors.error,
            ),
          ],
        ),
      ),
    );
  }
}

class ActionButton extends StatefulWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final Color iconColor;

  const ActionButton({super.key, 
    required this.onPressed,
    required this.icon,
    required this.iconColor,
  });

  @override
  State<ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: widget.onPressed,
      icon: Icon(widget.icon),
      color: widget.iconColor,
    );
  }
}

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onYesPressed;
  final VoidCallback onNoPressed;

  const ConfirmationDialog({super.key, 
    required this.title,
    required this.content,
    required this.onYesPressed,
    required this.onNoPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: onNoPressed,
          child: Text('No'),
        ),
        TextButton(
          onPressed: onYesPressed,
          child: Text('Yes'),
        ),
      ],
    );
  }
}
