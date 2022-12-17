import 'package:flutter/material.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';

class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({Key? key}) : super(key: key);

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  final controller = MultiImagePickerController(
    maxImages: 5,
    allowedImageTypes: ['png', 'jpg', 'jpeg'],
  );
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          MultiImagePickerView(
            controller: controller,
            padding: const EdgeInsets.all(10),
          ),
          const SizedBox(height: 8),
          GestureDetector(
            child: Text('Upload your item'),
            onTap: () {
              final images = controller.images;
            },
          )
        ],
      ),
    );
  }
}
