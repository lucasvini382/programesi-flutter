import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:programesi/widgets/flat_input.widget.dart';

/// Componente para seleção de data com suporte para Cupertino.
class JuiDatepicker extends StatefulWidget {
  const JuiDatepicker({
    Key? key,
    required this.onChange,
    this.type = JuiDatepickerType.SINGLE,
    this.mode = JuiDatepickerMode.DAY,
    this.labelText,
    this.hintText,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.validator,
    this.initialValue,
    this.controller,
    this.icon,
    this.colorLabelText,
  }) : super(key: key);

  final JuiDatepickerType type;
  final JuiDatepickerMode mode;
  final String? labelText;
  final String? hintText;
  final String? initialValue;
  final ValueChanged<dynamic> onChange;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  final Icon? icon;
  final Color? colorLabelText;

  @override
  _JuiDatepickerState createState() => _JuiDatepickerState();
}

// ignore: deprecated_member_use_from_same_package
class _JuiDatepickerState extends State<JuiDatepicker> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.initialValue != null) controller.text = widget.initialValue!;
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(primaryColor: Colors.blue),
      child: JuiFlatInput2(
        label: widget.labelText,
        controller: controller,
        hintText: widget.hintText,
        readOnly: true,
        onTap: () => _showDatePicker(context),
        onChanged: (value) {},
        validator: widget.validator,
      ),
    );
  }

  void _showDatePicker(BuildContext context) async {
    showDatePicker(
      context: context,
      initialDate: widget.initialDate ?? DateTime.now(),
      firstDate: widget.firstDate ?? DateTime.utc(1900, 01, 01),
      lastDate: widget.lastDate ?? DateTime.utc(2050, 12, 31),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDatePickerMode: widget.mode == JuiDatepickerMode.DAY
          ? DatePickerMode.day
          : DatePickerMode.year,
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(primary: Colors.blue),
        ),
        child: child ?? Container(),
      ),
    ).then((value) {
      if (value == null) return;
      widget.onChange(value);
      controller.text = DateFormat("dd/MM/yyyy").format(value);
    });
  }
}

enum JuiDatepickerType { SINGLE, RANGE }

enum JuiDatepickerMode { DAY, YEAR }
