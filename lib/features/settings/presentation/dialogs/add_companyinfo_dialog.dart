import 'package:flutter/material.dart';
import 'package:t89/common/buttons/k_elevated_button.dart';
import 'package:t89/common/textfield/k_textfield.dart';
import 'package:t89/common/widgets/add_photo_widget.dart';
import 'package:t89/config/styles/dimens.dart';
import 'package:t89/core/widget_keys/widget_keys.dart';
import 'package:t89/features/settings/controllers/settings_controller.dart';
import 'package:t89/features/settings/models/company_info_model.dart';
import 'package:t89/injection_container.dart';

showCompanyInfoDialog({
  CompanyInfoModel? companyInfo,
  bool barrierDissmissable = true,
}) {
  showDialog(
    context: rootNavKey.currentContext!,
    barrierDismissible: barrierDissmissable,
    builder: (context) => AddCompanyInfoDialog(companyInfo: companyInfo),
  );
}

class AddCompanyInfoDialog extends StatefulWidget {
  final CompanyInfoModel? companyInfo;
  const AddCompanyInfoDialog({
    super.key,
    this.companyInfo,
  });

  @override
  State<AddCompanyInfoDialog> createState() => _AddCompanyInfoDialogState();
}

class _AddCompanyInfoDialogState extends State<AddCompanyInfoDialog> {
  TextEditingController companyNameCtrl = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  final GlobalKey<AddPhotoWidgetState> addPhotoWidgetKey = GlobalKey();

  @override
  void initState() {
    if (widget.companyInfo != null) {
      companyNameCtrl.text = widget.companyInfo!.name;
    }
    super.initState();
  }

  @override
  void dispose() {
    companyNameCtrl.dispose();

    super.dispose();
  }

  bool validate() {
    bool isValid = true;
    if (!(formKey.currentState?.validate() ?? false)) {
      isValid = false;
    }

    if (!(addPhotoWidgetKey.currentState?.validate() ?? false)) {
      isValid = false;
    }

    return isValid;
  }

  save() async {
    if (validate()) {
      bool res = await getIt<SettingsController>().addCompanyInfo(
        companyNameCtrl.text,
        addPhotoWidgetKey.currentState!.selectedImage!.path,
      );
      if (res && mounted) {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(Dimens.marginM),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              key: formKey,
              child: KTextfield(
                controller: companyNameCtrl,
                label: 'Company Name',
                validator: (p0) {
                  if (p0 == null || p0.isEmpty) {
                    return 'Company Name shouldn\'t be empty';
                  }
                  return null;
                },
              ),
            ),
            AddPhotoWidget(
              key: addPhotoWidgetKey,
              imagePath: widget.companyInfo?.imagePath,
            ),
            const SizedBox(height: 7),
            SizedBox(
              height: 44,
              width: double.maxFinite,
              child: KElevatedButton(
                onPressed: save,
                title: 'Next',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
