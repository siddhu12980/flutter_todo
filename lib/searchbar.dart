import 'package:flutter/material.dart';
import 'constants/colors.dart';

// ignore: camel_case_types
class searchbar extends StatelessWidget {
  final filter;
  const searchbar({
    super.key,
    required this.filter,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        onChanged: (value) => filter(value),
        decoration: InputDecoration(
          hintText: 'Enter search text...',
          prefixIcon: Icon(
            Icons.search,
            color: primaryColor,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: listColors), // Color for the line when not focused
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: primaryColor), // Color for the line when focused
          ),
        ),
      ),
    );
  }
}
