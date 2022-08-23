import 'package:flutter/material.dart';
import '../mixins/validation_mixin.dart';
import '../shared/constants.dart';
import '../shared/emojis.dart';
import '../models/player_model.dart';
import '../models/team_model.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import '../services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../screens/home_page.dart';

class ProfileModal extends StatefulWidget {
  const ProfileModal([this.player]);
  final Player? player;
  @override
  createState() {
    return ProfileModalState();
  }
}

class ProfileModalState extends State<ProfileModal> with ValidationMixin {
  final formKey = GlobalKey<FormState>();

  late String nickname;
  late String emoji;
  late String teamName;
  late Team chosenTeam;
  late bool isExistingPlayer;

  @override
  void initState() {
    isExistingPlayer = widget.player != null;
    super.initState();
    if (isExistingPlayer) {
      nickname = widget.player!.nickname;
      emoji = widget.player!.emoji;
      teamName = widget.player!.team!.name;
      return;
    }
    teamName = '';
    nickname = '';
    emoji = Emojis().getRandom();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showModal(context);
    });
  }

  @override
  Widget build(context) {
    return isExistingPlayer ? profileForm(context) : Container();
  }

  void showModal(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isDismissible: false,
      isScrollControlled: true,
      enableDrag: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: profileForm(context),
        );
      },
    );
  }

  Widget profileForm(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Material(
      child: StatefulBuilder(builder: (context, setState) {
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
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text:
                                '${isExistingPlayer ? 'Update' : 'Create'} profile\n\n',
                            style: const TextStyle(
                              color: Constants.primaryTextColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 26.0,
                            )),
                        const TextSpan(
                            text: 'Choose a nickname and an associated\n',
                            style: TextStyle(
                                color: Constants.primaryTextColor,
                                fontSize: 18.0)),
                        const TextSpan(
                            text: 'emoji that people can remember you by.\n',
                            style: TextStyle(
                                color: Constants.primaryTextColor,
                                fontSize: 18.0)),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color.fromARGB(255, 143, 229, 240),
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
                    child: GestureDetector(
                      child:
                          Text(emoji, style: const TextStyle(fontSize: 50.0)),
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return EmojiPicker(
                              onEmojiSelected:
                                  (Category category, Emoji selectedEmoji) {
                                setState(() {
                                  emoji = selectedEmoji.emoji;
                                  Navigator.pop(context);
                                });
                              },
                              config: const Config(
                                  columns: 7,
                                  // Issue: https://github.com/flutter/flutter/issues/28894
                                  emojiSizeMax: 32,
                                  verticalSpacing: 0,
                                  horizontalSpacing: 0,
                                  gridPadding: EdgeInsets.zero,
                                  initCategory: Category.RECENT,
                                  bgColor: Color(0xFFF2F2F2),
                                  indicatorColor: Colors.blue,
                                  iconColor: Colors.grey,
                                  iconColorSelected: Colors.blue,
                                  progressIndicatorColor: Colors.blue,
                                  backspaceColor: Colors.blue,
                                  skinToneDialogBgColor: Colors.white,
                                  skinToneIndicatorColor: Colors.grey,
                                  enableSkinTones: true,
                                  showRecentsTab: true,
                                  recentsLimit: 28,
                                  replaceEmojiOnLimitExceed: false,
                                  noRecents: Text(
                                    'No Recents',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black26),
                                    textAlign: TextAlign.center,
                                  ),
                                  tabIndicatorAnimDuration: kTabScrollDuration,
                                  categoryIcons: CategoryIcons(),
                                  buttonMode: ButtonMode.MATERIAL),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  Container(margin: const EdgeInsets.only(top: 20.0)),
                  SizedBox(width: size.width * 0.8, child: nicknameField()),
                  Container(margin: const EdgeInsets.only(top: 20.0)),
                  SizedBox(width: size.width * 0.6, child: teamField(context)),
                  Container(margin: const EdgeInsets.only(top: 10.0)),
                  SizedBox(width: size.width * 0.8, child: submitButton()),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget nicknameField() {
    return TextFormField(
      initialValue: widget.player != null ? widget.player!.nickname : '',
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

  Widget teamField(BuildContext context) {
    final Stream<QuerySnapshot> teams = firestore.getTeams();
    return StreamBuilder<QuerySnapshot>(
      stream: teams,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        return DropdownButton<String>(
          value: teamName,
          icon: const Icon(
            Icons.arrow_downward,
            color: Constants.secondaryColor,
          ),
          elevation: 16,
          style: const TextStyle(
            color: Color.fromARGB(255, 31, 28, 85),
            fontWeight: FontWeight.bold,
          ),
          underline: Container(
            height: 2,
            color: Colors.blueAccent,
          ),
          onChanged: (String? newValue) {
            setState(() {
              teamName = newValue!;
            });
          },
          items: snapshot.data!.docs
              .map<DropdownMenuItem<String>>((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            Team team = Team(document.id, data['name']);
            return DropdownMenuItem<String>(
              value: team.name,
              child: Text(team.name),
              onTap: () {
                setState(() {
                  chosenTeam = team;
                });
              },
            );
          }).toList(),
        );
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
          firestore.createOrUpdatePlayerProfile(
              nickname, emoji, chosenTeam.toMap());
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(
                  profileData: {
                    'nickname': nickname,
                    'emoji': emoji,
                    'team': chosenTeam.toMap(),
                  },
                ),
              ),
              (route) => false);
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
