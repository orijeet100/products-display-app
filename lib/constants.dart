import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

const KTextField=InputDecoration(
  hintText: 'Enter a value',
  hintStyle: TextStyle(
    fontFamily: 'Poppins',
    color: Colors.white,
    fontSize: 17,
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.black,
      width: 2,
    ),
    borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(20),
      bottomRight: Radius.circular(20),
      topLeft: Radius.circular(20),
      topRight: Radius.circular(20),
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.white,
      width: 2,
    ),
    borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(20),
      bottomRight: Radius.circular(20),
      topLeft: Radius.circular(20),
      topRight: Radius.circular(20),
    ),
  ),
  filled: true,
  fillColor: Colors.purple,
  contentPadding: EdgeInsets.fromLTRB(5, 5, 5, 5),
);

const InputDecoration KUploadTextFiled=InputDecoration(
  hintText: 'Enter a value',
  hintStyle: TextStyle(
    fontFamily: 'Poppins',
    color: Colors.white,
    fontSize: 17,
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.black,
      width: 2,
    ),
    borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(20),
      bottomRight: Radius.circular(20),
      topLeft: Radius.circular(20),
      topRight: Radius.circular(20),
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.white,
      width: 2,
    ),
    borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(20),
      bottomRight: Radius.circular(20),
      topLeft: Radius.circular(20),
      topRight: Radius.circular(20),
    ),
  ),
  filled: true,
  fillColor: Colors.purple,
  contentPadding: EdgeInsets.fromLTRB(5, 5, 5, 5),
);

var inputDecoration = InputDecoration(
  hintText: 'Add a value',
  hintStyle: TextStyle(
    fontFamily: 'Poppins',
    color: Color(0xFF303030),
    fontSize: 14,
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.black,
      width: 1,
    ),
    borderRadius: BorderRadius.circular(10),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.black,
      width: 1,
    ),
    borderRadius: BorderRadius.circular(10),
  ),
  filled: true,
  fillColor: Colors.white,
  contentPadding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
);