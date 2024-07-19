import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:t89/config/styles/app_colors.dart';

class AddPhotoWidget extends StatefulWidget {
  final String? imagePath;
  const AddPhotoWidget({
    super.key,
    required this.imagePath,
  });

  @override
  State<AddPhotoWidget> createState() => AddPhotoWidgetState();
}

class AddPhotoWidgetState extends State<AddPhotoWidget> {
  File? selectedImage;
  String? selectedImageErrorText;

  @override
  void initState() {
    if (widget.imagePath != null) {
      selectedImage = File(widget.imagePath!);
    }
    super.initState();
  }

  bool validate() {
    if (selectedImage == null) {
      setState(() {
        selectedImageErrorText = 'Image shouldn\'t be empty';
      });
      return false;
    }
    return true;
  }

  pickImage() async {
    try {
      FocusScope.of(context).unfocus();
      FilePickerResult? res = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.image,
      );
      if (res != null && res.files.isNotEmpty) {
        selectedImageErrorText = null;
        setState(() {
          selectedImage = File(res.files.first.path!);
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 17,
            bottom: 10,
          ),
          child: Container(
            height: 142,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: AppColors.lightGrey,
            ),
            child: DottedBorder(
              radius: const Radius.circular(16),
              borderType: BorderType.RRect,
              strokeWidth: 1,
              strokeCap: StrokeCap.round,
              dashPattern: const [20, 20],
              color: AppColors.borderColor10,
              child: selectedImage != null
                  ? SizedBox(
                      width: double.infinity,
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.file(
                                selectedImage!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: SizedBox(
                              height: 40,
                              width: 40,
                              child: ElevatedButton(
                                onPressed: pickImage,
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16)),
                                  backgroundColor: Colors.black87,
                                ),
                                child: const Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : SizedBox(
                      width: double.infinity,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: pickImage,
                          borderRadius: BorderRadius.circular(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 25,
                                  bottom: 10,
                                ),
                                child: SvgPicture.asset(
                                  'assets/icons/camera.svg',
                                  colorFilter: const ColorFilter.mode(
                                    AppColors.purple,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                              const Text(
                                '+ Add Logo',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.purple,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
            ),
          ),
        ),
        if (selectedImageErrorText != null)
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
              bottom: 10,
            ),
            child: Text(
              selectedImageErrorText!,
              style: TextStyle(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          ),
        const SizedBox(height: 7),
      ],
    );
  }
}
