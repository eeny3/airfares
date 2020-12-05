import 'package:flutter/material.dart';

const kCustomPurple = Color(0xFF7D59EE);
const kToken = 'f41230bc222d3528d8909d1def2913d3';
const kInputDecoration = InputDecoration(
  hintText: 'Enter your email',
  contentPadding: EdgeInsets.symmetric(vertical: 10),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.grey,
      width: 1.0,
    ),
    borderRadius: BorderRadius.all(Radius.circular(8)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: kCustomPurple,
      width: 2.0,
    ),
    borderRadius: BorderRadius.all(Radius.circular(8)),
  ),
);