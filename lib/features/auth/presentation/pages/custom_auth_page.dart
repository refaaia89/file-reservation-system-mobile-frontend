import 'package:flutter/material.dart';

class CustomAuthPage extends StatelessWidget {
  const CustomAuthPage({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 35),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.black12.withOpacity(.1), borderRadius: BorderRadius.circular(8)),
            child: child,
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
