import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  const AuthField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.isObscure,
  });

  final TextEditingController controller;
  final String hintText;
  final bool isObscure;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.grey,
        ),
        fillColor: Colors.grey[200],
        filled: true,
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
      ),
      controller: controller,
      validator: (value) {
        if (value!.isEmpty) {
          return 'please enter $hintText';
        }
        return null;
      },
      obscureText: isObscure,
      obscuringCharacter: '*',
    );
  }
}
