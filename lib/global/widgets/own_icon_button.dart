import 'package:flutter/material.dart';

class OwnIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color? color;
  final double size;

  const OwnIconButton({
    Key? key,
    required this.icon,
    required this.onTap,
    this.color,
    this.size = 50.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xffaaaaaa)),
          borderRadius: BorderRadius.all(Radius.circular(size/2)),
          boxShadow: const [
            BoxShadow(
              color: Color(0xffcccccc),
              blurRadius: 4,
              offset: Offset(0, 0),
            ),
          ]
        ),
        child: Icon(icon, color: Colors.black),
      ),
    );
  }
}