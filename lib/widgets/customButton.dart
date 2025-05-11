import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final Widget? icon;
  final bool isOutlined;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = const Color(0xFFD57D47),
    this.textColor = Colors.white,
    this.icon,
    this.isOutlined = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55, 
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: textColor,
          backgroundColor: isOutlined ? Colors.white : backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: isOutlined
                ? BorderSide(color: Colors.grey.shade300)
                : BorderSide.none,
          ),
          elevation: 0,
        ),
        child: Stack(
          children: [
            if(icon != null) ...[
              Positioned(
                left: 0,
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: icon,
                ),
              ),
            ],
            Row(
              mainAxisAlignment:
                 MainAxisAlignment.center,
              children: [
                 
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isOutlined ? Colors.black : textColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
