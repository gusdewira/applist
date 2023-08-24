import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';


class CustomButto extends StatelessWidget {
  final Function()? onTap;
  final String? label;
  const CustomButto({super.key, this.onTap, this.label});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.blueAccent),
        child: Text(
          label ?? 'submit',
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
    );
  }
}
