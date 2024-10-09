import 'package:flutter/material.dart';
import 'package:internet_application/core/extensions/media_query.dart';

Widget buildElevatedButton({
  GlobalKey<FormState>? formKey,
  required BuildContext context,
  required String nameBtn,
  required VoidCallback function,
}) {
  return Container(
      width: 20,
      padding: const EdgeInsets.only(top: 3, left: 3),
      child: ElevatedButton(
        onPressed: () {
          if (formKey == null) {
            function;
          } else {
            if (formKey.currentState!.validate()) {
              formKey.currentState!.save();
              function;
            }
          }
        },
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        child: Text(
          nameBtn,
          style: const TextStyle(fontSize: 20, color: Colors.white),
        ),
      ));
}

Widget buildTextFormField(
    {required TextEditingController controller,
    FormFieldValidator<String>? validator,
    required String hintText,
    required Widget prefixIcon,
    required bool obscureText,
    required BuildContext context}) {
  return SizedBox(
    width: context.width / 2,
    child: TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide.none),
        fillColor: Colors.purple.withOpacity(0.1),
        filled: true,
        prefixIcon: prefixIcon,
      ),
      obscureText: obscureText,
    ),
  );
}

Widget btnHintToSignUpOrLogin({required BuildContext context, required String descriptionBtn, required String nameBtn, required VoidCallback function}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Text(descriptionBtn),
      TextButton(
          onPressed: function,
          child: Text(
            nameBtn,
            style: TextStyle(color: Theme.of(context).primaryColor),
          ))
    ],
  );
}
