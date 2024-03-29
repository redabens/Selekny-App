import 'package:flutter/material.dart';



class ProfileMenuWidget extends StatelessWidget {
   ProfileMenuWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.textColor,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;

  Color tPrimaryColor = Colors.white; // Use the appropriate color code or define your color
  Color tAccentColor  = Colors.blueAccent;

  @override
  Widget build(BuildContext context) {

    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    var iconColor = isDark ? tPrimaryColor : tAccentColor;

    return ListTile(

      onTap: onPress,

      leading: Container(
        width: 30,
        height: 30,
        child: Icon(icon, color: iconColor),
      ),

      title: Text(title, style: Theme.of(context).textTheme.bodyLarge?.apply(color: textColor)),


      trailing: endIcon? Container(
          width: 10,
          height: 10,

          child:  Icon(Icons.arrow_forward_ios_outlined, size: 25.0, color: Colors.grey.shade900),) : null,

    );
  }
}