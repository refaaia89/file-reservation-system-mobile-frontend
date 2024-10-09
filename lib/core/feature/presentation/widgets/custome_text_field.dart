import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({Key? key, required this.label, this.autofocus = false, this.onChanged, this.controller, this.initialValue}) : super(key: key);

  final TextEditingController? controller;
  final String? initialValue;
  final String label;
  final bool? autofocus;
  final ValueChanged<String>? onChanged;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  void initState() {
    super.initState();
    if (widget.initialValue != null) {
      widget.controller!.value = TextEditingValue(text: widget.initialValue!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          child: TextFormField(
            controller: widget.controller,
            decoration: InputDecoration(
              label: Text(widget.label),
              hintText: widget.initialValue,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: const BorderSide(
                    color: Colors.lightBlueAccent,
                  )),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: const BorderSide(
                    color: Colors.blue,
                  )),
            ),
            // style: TextStyle(color: Colors.black45),
            autofocus: true,
            onChanged: widget.onChanged,
          ),
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}
