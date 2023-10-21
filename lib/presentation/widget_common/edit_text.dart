import 'package:flutter/material.dart';

class EditText extends StatelessWidget {
  final String nameEdtTxt;
  final TextEditingController txtEdt;
  final TextInputType txtType;
  final String hintTxt;
  final valueEdtTxt;

  const EditText({
    super.key,
    required this.nameEdtTxt,
    required this.txtEdt,
    required this.txtType,
    required this.hintTxt,
    this.valueEdtTxt
  });


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          nameEdtTxt,
          style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 13,
              color: Color(0xFFB9B9B9)
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        TextFormField(
          controller: txtEdt,
          keyboardType: txtType,
          style: const TextStyle(
              color: Colors.grey
          ),
          decoration: InputDecoration(
            hintText: hintTxt,
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.black38
              ),
            ),
            fillColor: const Color(0xFFFBFBFB),
            contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            border: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black38,
              )
            ),
            hintStyle: const TextStyle(
                color: Colors.grey,
                fontSize: 14
            ),
            labelStyle: const TextStyle(
                color: Colors.grey,
                fontSize: 14
            ),
          ),
        ),
      ],
    );
  }
}
