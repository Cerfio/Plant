import 'package:flutter/material.dart';

class CardElementaryBase extends StatelessWidget {
  const CardElementaryBase({
    super.key,
    required this.backgroundColor,
    required this.titleColor,
    required this.subtitleColor,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.callback,
  });
  final Color backgroundColor;
  final Color titleColor;
  final Color subtitleColor;
  final Color iconColor;
  final String title;
  final String subtitle;
  final IconData icon;
  final Function callback;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          callback();
        },
        child: Card(
          elevation: 0,
          color: backgroundColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 12, top: 28, bottom: 28),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Icon(icon, size: 36, color: iconColor),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: titleColor,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          subtitle,
                          style: TextStyle(
                            fontSize: 16,
                            color: subtitleColor,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
