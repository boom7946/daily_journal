import 'dart:io';
import 'package:flutter/material.dart';
import '../utils/image_picker_helper.dart';

class ImageField extends StatefulWidget {
  const ImageField({super.key, required this.onImageSelected});
  final Function(File) onImageSelected;
  @override
  State<ImageField> createState() => _ImageFieldState();
}

class _ImageFieldState extends State<ImageField> {
  File? _image;
  void _pickImage() async {
    try {
      final picked = await ImagePickerHelper.pickImageFromGallery();
      if (picked != null) {
        setState(() => _image = picked);
        widget.onImageSelected(picked);
      }
    } catch (e) {
      debugPrint("Image picking failed: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_image != null)
          Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                  border: Border.all(width: 2, color: Colors.black),
                  borderRadius: BorderRadius.circular(8)),
              child: Image.file(_image!,
                  height: 150, width: 150, fit: BoxFit.fill)),
        TextButton.icon(
          icon: const Icon(Icons.image, color: Colors.black),
          label: const Text(
            "Pick Image",
            style: TextStyle(color: Colors.black),
          ),
          onPressed: _pickImage,
        ),
      ],
    );
  }
}
