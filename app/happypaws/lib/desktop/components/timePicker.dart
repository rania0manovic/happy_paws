import 'package:flutter/material.dart';
import 'package:happypaws/common/components/text/light_text.dart';
import 'package:happypaws/common/utilities/toast.dart';
import 'package:happypaws/common/utilities/constants.dart';
import 'package:happypaws/desktop/components/buttons/secondary_button.dart';
import 'package:intl/intl.dart';

class TimeSlotSelectionPage extends StatefulWidget {
  const TimeSlotSelectionPage(
      {super.key,
      required this.onStartTimeChanged,
      required this.onEndTimeChanged});

  final MyVoidCallback onStartTimeChanged;
  final MyVoidCallback onEndTimeChanged;

  @override
  _TimeSlotSelectionPageState createState() => _TimeSlotSelectionPageState();
}

class _TimeSlotSelectionPageState extends State<TimeSlotSelectionPage> {
  late TimeOfDay _selectedStartTime;
  late TimeOfDay _selectedEndTime;

  @override
  void initState() {
    super.initState();
    _selectedStartTime = const TimeOfDay(hour: 0, minute: 0);
    _selectedEndTime = const TimeOfDay(hour: 0, minute: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const LightText(
          label: "Select start time:",
          fontSize: 14,
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          child: SecondaryButton(
            icon: Icons.more_time_rounded,
            onPressed: () {
              _selectStartTime(context);
            },
            width: double.infinity,
            label: _selectedStartTime.format(context),
          ),
        ),
        const SizedBox(height: 10),
        const LightText(
          label: 'Select end time:',
          fontSize: 14,
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          child: SecondaryButton(
            icon: Icons.more_time_rounded,
            onPressed: () {
              _selectEndTime(context);
            },
            width: double.infinity,
            label: _selectedEndTime.format(context),
          ),
        ),
      ],
    );
  }

  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: _selectedStartTime,
    );
    if (selectedTime != null) {
      if (selectedTime.hour >= 16 || selectedTime.hour < 8) {
        if (!mounted) return;
        ToastHelper.showToastError(context,
            "Selected time is outside of working hours! (08:00h-16:00h)");
        return;
      }
    if (_selectedEndTime != const TimeOfDay(hour: 0, minute: 0)) {
        if (_selectedEndTime.hour == selectedTime.hour) {
          if (_selectedEndTime.minute == selectedTime.minute) {
            ToastHelper.showToastError(
                context, "Start and end time must differ!");
            return;
          }
          else if (_selectedEndTime.minute < selectedTime.minute) {
            ToastHelper.showToastError(
                context, "Start time must be before end time!");
            return;
          }
        } else if (_selectedEndTime.hour < selectedTime.hour) {
          ToastHelper.showToastError(
              context, "Start time must be before end time!");
          return;
        }
      }

      widget.onStartTimeChanged(selectedTime);
      setState(() {
        _selectedStartTime = selectedTime;
      });
    }
  }

  Future<void> _selectEndTime(BuildContext context) async {
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: _selectedEndTime,
    );
    if (selectedTime != null) {
      if (selectedTime.hour > 16 || selectedTime.hour < 8) {
        ToastHelper.showToastError(context,
            "Selected time is outside of working hours! (08:00h-16:00h)");
        return;
      }

      if (_selectedStartTime != const TimeOfDay(hour: 0, minute: 0)) {
        if (_selectedStartTime.hour == selectedTime.hour) {
          if (_selectedStartTime.minute == selectedTime.minute) {
            ToastHelper.showToastError(
                context, "Start and end time must differ!");
            return;
          } else if (_selectedStartTime.minute > selectedTime.minute) {
            ToastHelper.showToastError(
                context, "End time must be after start time!");
            return;
          }
        } else if (_selectedStartTime.hour > selectedTime.hour) {
          ToastHelper.showToastError(
              context, "End time must be after start time!");
          return;
        }
      }
      widget.onEndTimeChanged(selectedTime);
      setState(() {
        _selectedEndTime = selectedTime;
      });
    }
  }

  String _formatTime(TimeOfDay timeOfDay) {
    final time = DateTime(0, timeOfDay.hour, timeOfDay.minute);
    final format = DateFormat.jm(); // Format as AM/PM
    return format.format(time);
  }
}
