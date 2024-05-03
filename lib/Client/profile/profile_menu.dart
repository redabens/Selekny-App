import 'package:flutter/material.dart';

class ProfileMenuWidget extends StatelessWidget {
  ProfileMenuWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.textColor,
  });

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    var isDark = Theme.of(context).brightness == Brightness.dark;
    var iconColor = isDark ? Colors.white : Colors.blueAccent;
    var backgroundColor = isDark ? Colors.black.withOpacity(0.8) : Colors.white;
    var textColor = isDark ? Colors.white : Colors.black;

    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 30,
        height: 30,
        child: Icon(
          icon,
          color: iconColor,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(color: textColor,
        fontSize: 15),
      ),
      trailing: endIcon
          ? Container(
        width: 10,
        height: 10,
        child: Icon(
          Icons.arrow_forward_ios_outlined,
          size: 20.0,
          color: Theme.of(context).iconTheme.color,
        ),
      )
          : null,
      tileColor: backgroundColor,
    );
  }
}