import 'package:flutter/material.dart';

class SettingsOption {
  final IconData icon;
  final String title;
  Widget? setting;

  SettingsOption(this.icon, this.title, [this.setting]);
}
