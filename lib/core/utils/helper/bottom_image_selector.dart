import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../colors/app_color.dart';
import 'image_selector.dart';

class BottomImageSelector extends StatelessWidget {
  final BuildContext context;
  final ValueChanged<File>? onChanged;

  BottomImageSelector({
    super.key,
    required this.context,
    this.onChanged,
  }) {
    _openBottomSheet(context);
  }

  _openBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return this;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Wrap(
        children: [
          Container(
            height: MediaQuery.sizeOf(context).height * 0.18,
            padding:const EdgeInsets.only(top: 12),
            decoration: const BoxDecoration(
                color: AppColor.BACKGROUND_COLOR_LIGHT,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(16), topLeft: Radius.circular(16))),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text('Camera'),
                  onTap: () async {
                    File? imageCamera = await ImageSelector().showSelectImageDialog(source: ImageSource.camera);
                    if (imageCamera != null) {
                      onChanged == null ? null : onChanged!(imageCamera);
                      Navigator.pop(context);
                    }
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo),
                  title: const Text('Gallery'),
                  onTap: () async {
                    File? imageGallery = await ImageSelector()
                        .showSelectImageDialog(source: ImageSource.gallery);
                    if (imageGallery != null) {
                      onChanged == null ? null : onChanged!(imageGallery);
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
