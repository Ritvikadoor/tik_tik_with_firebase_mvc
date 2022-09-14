import 'package:flutter/material.dart';

import 'package:tik_tok_clone/constants.dart';

class WhiteScreen extends StatelessWidget {
  final String name;
  const WhiteScreen({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: whiteColor,
      child: Center(
          child: Text(
        name,
        style: const TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
      )),
    );
  }
}
