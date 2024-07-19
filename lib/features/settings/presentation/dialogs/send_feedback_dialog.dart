import 'package:flutter/material.dart';
import 'package:t89/config/styles/app_colors.dart';
import 'package:t89/core/widget_keys/widget_keys.dart';

showSendFeedbackDialog() {
  showDialog(
    context: rootNavKey.currentContext!,
    builder: (context) => const SendFeedbackDialog(),
  );
}

class SendFeedbackDialog extends StatelessWidget {
  const SendFeedbackDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 15,
          right: 15,
          bottom: 15,
          top: 25,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Share your feedback',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: AppColors.darkblue,
              ),
            ),
            const SizedBox(height: 17),
            Text(
              'Do you enjoy using APP NAME? What can we do to improve your experience?',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: AppColors.darkblue.withOpacity(0.5),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 17),
              height: 142,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  width: 1,
                  color: const Color(0x0d000000),
                ),
                color: AppColors.lightGrey,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 25,
              ),
              child: const TextField(
                maxLines: 4,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: '∙ Describe your experience or suggestions',
                  hintStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.darkblue40,
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 44,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: OutlinedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(30),
                          right: Radius.circular(4),
                        )),
                        side: const BorderSide(
                          width: 1,
                          color: AppColors.darkblue,
                        ),
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: AppColors.darkblue,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 1),
                Expanded(
                  child: SizedBox(
                    height: 44,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(4),
                          right: Radius.circular(30),
                        )),
                      ),
                      child: const Text('Send'),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
