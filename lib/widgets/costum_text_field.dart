import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? hint;
  final TextEditingController controller;
  final TextInputType type;

  const CustomTextField(
      {super.key,
      this.hint,
      required this.controller,
      this.type = TextInputType.text});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.black45),
        contentPadding: const EdgeInsets.all(20),
      ),
      keyboardType: TextInputType.number,
    );
  }
}
