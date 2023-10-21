import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {

  String nameBtn;
  VoidCallback? btnAction;
  Color? btnColor;
  Color? txtColor;
  BorderSide? borderBtn ;
  Size? sizeExtend;

  CustomBtn({
    super.key,
    required this.nameBtn,
    this.btnAction,
    this.btnColor,
    this.txtColor,
    this.borderBtn,
    this.sizeExtend
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: btnAction,
      style: ElevatedButton.styleFrom(
        backgroundColor: btnColor,
        minimumSize: sizeExtend,
        elevation: 0,
        side: borderBtn
      ),
      child: Text(
        nameBtn,
        style: TextStyle(
          color: txtColor
        ),
      ),
    );
  }
}
