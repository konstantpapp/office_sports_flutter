import 'package:flutter/material.dart';
import 'season_results.dart';
import 'preferences.dart';
import 'about.dart';
import '../../modals/profile_modal.dart';
import 'sign_out_dialog.dart';
import '../../shared/constants.dart';
import '../../models/settings_option.dart';
import '../../models/player_model.dart';

class Settings extends StatelessWidget {
  const Settings({super.key, required this.player});
  final Player player;

  @override
  Widget build(context) {
    final List<SettingsOption> options = [
      SettingsOption(Icons.star_outline, 'Season results', SeasonResults()),
      SettingsOption(
          Icons.person_outline, 'Update profile', ProfileModal(player)),
      SettingsOption(Icons.checklist_outlined, 'Preferences', Preferences()),
      SettingsOption(Icons.info_outline, 'About', About()),
      SettingsOption(Icons.logout, 'Sign out', SignOutDialog()),
    ];

    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.only(top: 30.0, right: 15.0),
        child: IconButton(
          icon: const Icon(
            Icons.settings,
            size: 30.0,
            color: Constants.secondaryTextColor,
          ),
          onPressed: () {
            showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext context) {
                return Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: Container(
                    height: 300,
                    color: Colors.white,
                    child: ListView.builder(
                      itemCount: options.length,
                      itemBuilder: (_, int index) {
                        return ListTile(
                          onTap: () {
                            options[index].title != 'Sign out'
                                ? showModalBottomSheet<void>(
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return options[index].setting!;
                                    })
                                : showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return options[index].setting!;
                                    });
                          },
                          leading: Icon(
                            options[index].icon,
                            size: 30.0,
                            color: Constants.secondaryTextColor,
                          ),
                          title: Text(
                            options[index].title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                              color: Constants.secondaryTextColor,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
