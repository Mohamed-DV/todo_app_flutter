import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
class CustomInputField extends StatelessWidget {
  final TextEditingController? controller;
  final Widget? leading;
  final String hintText;
  final bool obscureText;
  final bool isSearch;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final List<TextInputFormatter> inputFormatters;
  final TextStyle? hintStyle;
  final bool autofocus;
  final bool readOnly;
  final bool expands;
  final int? minLines;
  final int maxLines;
  final Color fillColor;
  final Color textColor;
  final Color borderColor;
  final double radius;
  final bool usePrefix;
  final Widget? trailing;
  final String? Function(String?)? validator;
  final void Function()? onTap;
  final void Function(String)? onFieldSubmitted;

  final void Function(String)? onChanged;

  const CustomInputField({
    super.key,
    this.controller,
    this.leading,
    this.usePrefix = false,
    required this.hintText,
    this.hintStyle,
    this.isSearch = false,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.inputFormatters = const <TextInputFormatter>[],
    this.autofocus = false,
    this.readOnly = false,
    this.expands = false,
    this.minLines,
    this.maxLines = 1,
    this.fillColor = Colors.transparent,
    this.textColor = Colors.black,
    this.borderColor = Colors.grey,
    this.radius = 20,
    this.trailing,
    this.validator,
    this.onTap,
    this.onFieldSubmitted,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    /// TODO : App Theme
    final ThemeData appTheme = Theme.of(context);

    /// TODO : isTablet
    // final bool isTablet = context.isTablet;
    // final double fontSize = isTablet ? 15 : 13;

    ///
    return TextFormField(
      onFieldSubmitted: onFieldSubmitted,
      controller: controller,
      onTap: onTap,
      onChanged: onChanged,
      validator: validator,
      style: Theme.of(context).textTheme.labelLarge,
      scrollPadding: EdgeInsets.zero,
      cursorColor: Color(0xFFD57D47),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      obscureText: obscureText,
      // obscuringCharacter: constants.obscuring_character,
      autofocus: autofocus,
      readOnly: readOnly,
      expands: expands,
      minLines: minLines,
      maxLines: maxLines,
      textAlign: TextAlign.start,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        prefixIcon: controller?.text.isEmpty ?? true ? Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: leading,
        ) : null,
        suffixIcon: controller?.text.isEmpty ?? true ? trailing : null,

        // prefixText: usePrefix ? '+253 ' : null,
        //isCollapsed: false,
        //isDense: false,
        border: inputBorder(radius, borderColor),
        focusedBorder: inputBorder(radius, borderColor),
        enabledBorder: inputBorder(radius, borderColor),
        disabledBorder: inputBorder(radius, borderColor),
        focusedErrorBorder: inputBorder(radius, borderColor),
        errorBorder: inputBorder(radius, borderColor),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 19),
        filled: true,
        fillColor: fillColor,
        hintText: hintText,
        hintStyle: GoogleFonts.poppins(
          color: textColor.withOpacity(.5),
          fontWeight: FontWeight.w500,
          letterSpacing: .5,
          fontSize: 14,
        ),
        errorStyle:
            Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.red),
      ),
    );
  }
}

OutlineInputBorder inputBorder(double radius,
    [Color borderColor = Colors.transparent]) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(radius)),
    borderSide: BorderSide(
      color: borderColor,
      width: 1.5,
    ),
  );
}
