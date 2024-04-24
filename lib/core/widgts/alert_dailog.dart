import 'package:flutter/material.dart';

class AppMethods {
  static Future<void> imagePickerDialog({
    required BuildContext context,
    required Function camerFun,
    required Function galeryFun,
    required Function removeFun,
  }) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Color(0x80FFFFFF), // Set background color to transparent
          content: Row( // Wrap the content in a Row to display buttons horizontally
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton.icon(
                onPressed: () {
                  camerFun();
                },
                icon: const Icon(Icons.camera),
                label: const Text("Camera"),
              ),
              TextButton.icon(
                onPressed: () {
                  galeryFun();
                },
                icon: const Icon(Icons.file_open),
                label: const Text("Gallery"),
              ),
            ],
          ),
        );
      },
    );
  }
}
