import 'package:flutter/material.dart';
import 'package:pim_smarket/components/components.dart';
import 'package:pim_smarket/theme.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.title});

  final String title;

  @override
  State<ProfilePage> createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return PageTemplate.build(Text(widget.title,
        textAlign: TextAlign.center, style: CustomTheme.pinkText));
  }
}
