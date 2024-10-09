import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({Key? key, this.formKey, required this.onTap, required this.text}) : super(key: key);
  final GlobalKey<FormState>? formKey;
  final GestureTapCallback? onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (formKey == null) {
          onTap!.call();
        } else {
          if (formKey!.currentState!.validate()) {
            formKey!.currentState!.save();
            onTap!.call();
          }
        }
      },
      borderRadius: BorderRadius.circular(25),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(25)),
        child: Text(
          text,
          style: const TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
