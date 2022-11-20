import 'package:flutter/material.dart';

class FormTextFieldInput extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final Function(String?) validator;
  const FormTextFieldInput({
    super.key,
    required this.label,
    required this.controller,
    required this.validator,
  });

  @override
  State<FormTextFieldInput> createState() => _FormTextFieldInputState();
}

class _FormTextFieldInputState extends State<FormTextFieldInput> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: (value) => widget.validator(value!),
      decoration: InputDecoration(
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue,
            width: 1.0,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xffE3E5E6),
            width: 1.0,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        labelText: widget.label,
        labelStyle: const TextStyle(
          color: Color(0xff72777A),
        ),
      ),
    );
  }
}
