import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final EdgeInsets padding;
  final int lines;
  final bool secure;
  final Color color;
  final String hint;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final Icon icon;
  final String Function(String) validator;

  const CustomTextFormField(
      {Key key,
      this.secure = false,
      this.padding = const EdgeInsets.symmetric(vertical: 5.0),
      this.controller,
      this.hint,
      this.lines = 1,
      this.keyboardType = TextInputType.text,
      this.icon,
      this.validator,
      this.color = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: TextFormField(
        validator: validator,
        maxLines: lines,
        keyboardType: keyboardType,
        obscureText: secure,
        controller: controller,
        style: TextStyle(fontSize: 17, color: color),
        decoration: InputDecoration(
          icon: icon,
          hintText: hint,
          hintStyle: TextStyle(fontSize: 16, color: Colors.white60),
          // helperStyle: TextStyle(fontSize: 16, color: color),
          // labelStyle: TextStyle(fontSize: 16, color: Colors.white70),
          contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 10),
          border: InputBorder.none,
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(width: 1.2, color: color),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(width: 1.2, color: color),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(width: 1.2, color: Colors.red),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(width: 1.2, color: color),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(width: 1.2, color: color),
          ),
        ),
      ),
    );
  }
}
