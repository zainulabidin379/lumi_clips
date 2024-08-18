import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lumi_clips/helpers/exports.dart';
import 'package:lumi_clips/models/message.dart';
import 'package:lumi_clips/widgets/alert_dialog.dart';

class AddMessage extends StatefulWidget {
  final MessageModel? message;
  const AddMessage({super.key, this.message});

  @override
  State<AddMessage> createState() => _AddMessageState();
}

class _AddMessageState extends State<AddMessage> {
  final formKey = GlobalKey<FormState>();
  final body = TextEditingController();
  final no = TextEditingController();
  final delay = TextEditingController();

  @override
  void initState() {
    if (widget.message != null) {
      body.text = widget.message!.body;
      no.text = widget.message!.no.toString();
      delay.text = widget.message!.delay.toString();
    }
    super.initState();
  }

  @override
  void dispose() {
    body.dispose();
    no.dispose();
    delay.dispose();
    super.dispose();
  }

  Future addMessage() async {
    Get.close(1);
    var id = Ext.uniqueId();
    await FirebaseFirestore.instance
        .collection("messages")
        .doc(id)
        .set(MessageModel(id: id, body: body.text, delay: int.parse(delay.text), no: int.parse(no.text)).toMap());
    ShowSnackbar.success("SMS Added");
  }

  Future updateMessage() async {
    Get.close(1);
    await FirebaseFirestore.instance
        .collection("messages")
        .doc(widget.message!.id)
        .update({'body': body.text, 'delay': int.parse(delay.text), 'no': int.parse(no.text)});
    ShowSnackbar.success("SMS Updated");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.message != null ? "Update SMS" : "Add SMS",
          style: AppTextStyle.kHeadingLarge.applyColor(AppColors.kPrimary),
        ),
        actions: [
          widget.message != null
              ? IconButton(
                  onPressed: () {
                    showAlertDialog(
                        context: context,
                        title: "Delete SMS",
                        body: const Text("Are you sure to delete this sms?"),
                        saveButtonTitle: "Delete",
                        saveButtonColor: AppColors.kRed,
                        onSave: () async {
                          Get.close(2);
                          await FirebaseFirestore.instance.collection("messages").doc(widget.message!.id).delete();
                          ShowSnackbar.success("SMS Deleted");
                        });
                  },
                  icon: const Icon(
                    Icons.delete_outline,
                    color: AppColors.kBlack,
                  )).padRight(10)
              : const SizedBox.shrink()
        ],
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: 15.padAll(),
          children: [
            CustomTextField(
              controller: no,
              hintText: "e.g. 1",
              label: "Message No",
              textInputType: TextInputType.number,
              textInputAction: TextInputAction.next,
              inputFormatters: [
                LengthLimitingTextInputFormatter(2),
                FilteringTextInputFormatter.digitsOnly,
              ],
              validator: (val) {
                if (val == null) {
                  return "Required";
                } else {
                  if (val.isEmpty) {
                    return "Required";
                  } else {
                    return null;
                  }
                }
              },
            ),
            const Gap(15),
            CustomTextField(
              controller: body,
              hintText: "Enter your SMS",
              label: "SMS Body",
              textInputType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              minLines: 2,
              inputFormatters: [
                LengthLimitingTextInputFormatter(160),
              ],
              validator: (val) {
                if (val == null) {
                  return "Required";
                } else {
                  if (val.isEmpty) {
                    return "Required";
                  } else {
                    return null;
                  }
                }
              },
            ),
            const Gap(15),
            CustomTextField(
              controller: delay,
              hintText: "e.g. 10",
              label: "SMS Delay After Registration (Minutes)",
              textInputType: TextInputType.number,
              textInputAction: TextInputAction.done,
              inputFormatters: [
                LengthLimitingTextInputFormatter(3),
                FilteringTextInputFormatter.digitsOnly,
              ],
              validator: (val) {
                if (val == null) {
                  return "Required";
                } else {
                  if (val.isEmpty) {
                    return "Required";
                  } else {
                    return null;
                  }
                }
              },
            ),
            const Gap(25),
            CustomElevatedButton(
                title: widget.message != null ? "Update SMS" : "Add SMS",
                onPress: () {
                  if (formKey.currentState!.validate()) {
                    if (widget.message != null) {
                      updateMessage();
                    } else {
                      addMessage();
                    }
                  }
                })
          ],
        ),
      ),
    ).unFocus(context);
  }
}
