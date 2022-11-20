import 'package:flutter/material.dart';

class CardLengthen extends StatelessWidget {
  const CardLengthen(
      {super.key, required this.title, required this.callback, this.subtitle});
  final String title;
  final Function() callback;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        callback();
      },
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
        ),
        height: 100,
        width: 50,
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xff8BA07E),
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Inter'),
              ),
              Row(
                children: [
                  subtitle != null
                      ? Text(
                          subtitle!,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff8BA07E),
                          ),
                        )
                      : const SizedBox(),
                  const SizedBox(width: 20),
                  const Icon(Icons.chevron_right, size: 30),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
