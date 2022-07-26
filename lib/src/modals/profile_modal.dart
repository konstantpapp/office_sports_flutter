import 'package:flutter/material.dart';
import '../mixins/validation_mixin.dart';
import '../shared/constants.dart';

class ProfileModal extends StatefulWidget {
  @override
  createState() {
    return ProfileModalState();
  }
}

class ProfileModalState extends State<ProfileModal> with ValidationMixin {
  final formKey = GlobalKey<FormState>();
  String nickname = '';
  String emoji = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showModal(context);
    });
  }

  @override
  Widget build(context) {
    return const Text('build');
  }

  void showModal(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    showModalBottomSheet<void>(
      context: context,
      isDismissible: false,
      isScrollControlled: true,
      enableDrag: false,
      builder: (BuildContext context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            color: Constants.primaryColor,
            height: size.height * 0.95,
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(height: size.height * 0.05),
                  RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Update profile\n\n',
                            style: TextStyle(
                              color: Constants.primaryTextColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 26.0,
                            )),
                        TextSpan(
                            text: 'Choose a nickname and an associated\n',
                            style: TextStyle(
                                color: Constants.primaryTextColor,
                                fontSize: 18.0)),
                        TextSpan(
                            text: 'emoji that people can remember you by.\n\n',
                            style: TextStyle(
                                color: Constants.primaryTextColor,
                                fontSize: 18.0)),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.orange,
                      border: Border.all(
                        width: 5,
                        color: Colors.white,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 2.0,
                          spreadRadius: 2.0,
                          offset: Offset(5.0, 5.0),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    width: 100,
                    height: 100,
                    child: IconButton(
                      icon: const Icon(
                        Icons.emoji_emotions,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                  ),
                  Container(margin: const EdgeInsets.only(top: 20.0)),
                  SizedBox(width: size.width * 0.8, child: nicknameField()),
                  Container(margin: const EdgeInsets.only(top: 10.0)),
                  SizedBox(width: size.width * 0.8, child: submitButton()),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget nicknameField() {
    return TextFormField(
      style: const TextStyle(color: Constants.primaryTextColor),
      decoration: const InputDecoration(
          fillColor: Constants.secondaryColor,
          filled: true,
          errorStyle: TextStyle(color: Colors.white)),
      validator: validateNickname,
      onSaved: (String? value) {
        nickname = value!;
      },
    );
  }

  Widget submitButton() {
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
          side: MaterialStateProperty.all<BorderSide>(BorderSide.none)),
      onPressed: () {
        if (formKey.currentState!.validate()) {
          formKey.currentState!.save();
          formKey.currentState!.reset();
        }
      },
      child: const Text(
        'Continue',
        style: TextStyle(
          color: Constants.primaryColor,
          fontSize: 18,
        ),
      ),
    );
  }
}
