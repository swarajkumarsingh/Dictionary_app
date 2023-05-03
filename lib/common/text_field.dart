import 'package:dictionary/constants/color.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String text;
  final TextInputType textInputType;
  final IconData iconData;
  final TextEditingController controller;
  const CustomTextField({
    Key? key,
    required this.text,
    this.textInputType = TextInputType.name,
    required this.controller,
    this.iconData = Icons.abc,
  }) : super(key: key);

  final double height = 40;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextFormField(
        controller: controller,
        keyboardType: textInputType,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          prefixIcon: Icon(iconData),
          hintText: text,
          fillColor: colors.textFieldColor,
          filled: true,
        ),
      ),
    );
  }
}

class NameTextField extends StatelessWidget {
  const NameTextField({
    Key? key,
    required this.text,
    this.iconData = Icons.abc,
    this.textInputType = TextInputType.name,
    required this.controller,
    this.function,
     this.autofocus,
  }) : super(key: key);

  final String text;
  final bool? autofocus;
  final IconData iconData;
  final VoidCallback? function;
  final TextInputType textInputType;
  final TextEditingController controller;

  final double height = 45;
  final int nameMinLength = 2;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: TextFormField(
        controller: controller,
        autofocus: autofocus ?? false,
        onEditingComplete: function ?? () {},
        keyboardType: textInputType,
        validator: (value) {
          final pattern = RegExp(r'^[a-zA-Z]+$');
          if (value!.isNotEmpty && value.length >= nameMinLength) {
            return null;
          } else if (!pattern.hasMatch(value)) {
            return "Please Enter only Alphabets";
          } else if (value.isEmpty) {
            return "Please enter a word";
          } else if (value.length < nameMinLength) {
            return "prompt must be at least $nameMinLength characters";
          } else {
            return "Please enter word";
          }
        },
        decoration: InputDecoration(
          prefixIcon: Icon(iconData, color: Colors.grey),
          border: InputBorder.none,
          hintStyle: const TextStyle(
            color: Colors.grey,
          ),
          hintText: text,
          fillColor: colors.textFieldColor,
          filled: true,
        ),
      ),
    );
  }
}

class SearchTextField extends StatelessWidget {
  final String text;
  final TextInputType textInputType;
  final TextEditingController controller;
  const SearchTextField({
    Key? key,
    required this.text,
    this.textInputType = TextInputType.name,
    required this.controller,
  }) : super(key: key);

  final double height = 40;
  final int nameMinLength = 3;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        controller: controller,
        keyboardType: textInputType,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search),
          border: InputBorder.none,
          hintText: text,
          fillColor: colors.textFieldColor,
          filled: true,
        ),
      ),
    );
  }
}

class EmailTextField extends StatelessWidget {
  final String text;
  final TextInputType textInputType;
  final TextEditingController controller;
  const EmailTextField({
    Key? key,
    required this.text,
    this.textInputType = TextInputType.name,
    required this.controller,
  }) : super(key: key);

  final double height = 40;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        controller: controller,
        keyboardType: textInputType,
        autofillHints: const [AutofillHints.email],
        validator: (value) {
          if (value!.isNotEmpty &&
              value.contains("@") &&
              value.contains(".com")) {
            return null;
          } else if (value.isEmpty) {
            return "Please enter an email";
          } else if (value.contains("@") == false) {
            return "Enter a valid Email";
          } else if (value.contains(".com") == false) {
            return "Enter a valid Email";
          } else {
            return "Please Enter a valid Number";
          }
        },
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.email_outlined),
          border: InputBorder.none,
          hintText: text,
          fillColor: colors.textFieldColor,
          filled: true,
        ),
      ),
    );
  }
}

class PasswordTextField extends StatelessWidget {
  final String text;
  final TextInputType textInputType;
  final TextEditingController controller;
  const PasswordTextField({
    Key? key,
    required this.text,
    this.textInputType = TextInputType.name,
    required this.controller,
  }) : super(key: key);

  final double height = 40;
  final int passwordMinLength = 6;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        controller: controller,
        keyboardType: textInputType,
        autofillHints: const [AutofillHints.password],
        validator: (value) {
          if (value!.isNotEmpty && value.length >= passwordMinLength) {
            return null;
          } else if (value.isEmpty) {
            return "Please enter a password";
          } else if (value.length < passwordMinLength) {
            return "password must be at least 8 characters";
          } else {
            return "Please Enter a valid Number";
          }
        },
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.password_rounded),
          border: InputBorder.none,
          hintText: text,
          fillColor: colors.textFieldColor,
          filled: true,
        ),
      ),
    );
  }
}

class PhoneNumberTextField extends StatelessWidget {
  final String text;
  final TextInputType textInputType;
  final TextEditingController controller;
  const PhoneNumberTextField({
    Key? key,
    required this.text,
    this.textInputType = TextInputType.name,
    required this.controller,
  }) : super(key: key);

  final double height = 40;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        controller: controller,
        keyboardType: textInputType,
        validator: (value) {
          if (value!.isNotEmpty && value.length == 10) {
            return null;
          } else if (value.isEmpty) {
            return "Please Enter a Number";
          } else if (int.tryParse(value)! < 10) {
            return "Please Enter 10 digits Number";
          } else if (int.tryParse(value)! > 10) {
            return "Please Enter 10 digits NUmber";
          } else {
            return "Please Enter a valid Number";
          }
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: text,
          fillColor: Colors.white,
          filled: true,
        ),
      ),
    );
  }
}
