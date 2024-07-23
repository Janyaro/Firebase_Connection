import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ReUseBtn extends StatelessWidget {
  final String btnTitle;
  final VoidCallback ontap;
  final bool loading;
  const ReUseBtn(
      {super.key,
      required this.btnTitle,
      this.loading = false,
      required this.ontap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.deepPurple),
        child: Center(
            child: loading
                ? CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 3,
                  )
                : Text(
                    btnTitle,
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  )),
      ),
    );
  }
}
