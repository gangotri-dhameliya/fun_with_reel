import 'package:flutter/material.dart';
import 'package:reels_app/UI/common/headline_body_one_base_widget.dart';
import 'package:reels_app/infrastructure/constant/color_constant.dart';
import 'package:reels_app/infrastructure/constant/font_constant.dart';

commonTextField(
    {required BuildContext context,
      required String hint,
      required String label,
      bool obscureText = false,
      bool showOnFocusBorder = false,
      bool? showLabel = true,
      bool showBorder = true,
      bool addPadding = false,
      bool isDense = true,
      Widget? suffixIcon,
      Widget? prefixIcon,
      bool? suffixIconSpace,
      FocusNode? focusNode,
      FormFieldValidator<String>? validator,
      TextCapitalization? textCapitalization,
      ValueChanged<String>? onChanged,
      void Function(String?)? onFieldSubmitted,
      Function()? onEditingComplete,
      GestureTapCallback? onTap,
      TextInputType? textInputType,
      TextInputAction? textInputAction,
      int maxLine=1,
      int minLine=1,
      TextAlignVertical? textAlignVertical = TextAlignVertical.center,
      TextStyle? textStyle,
      EdgeInsetsGeometry? padding,
      required TextEditingController controller}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if(label.isNotEmpty)
        ...[  Container(
          margin: const EdgeInsets.only(left: 14),
          child: HeadlineBodyOneBaseWidget(
            title: label,
            fontWeight: FontWeight.w300,
            fontSize: 14,
              fontFamily: FontConstant.satoshiMedium,
          ),
        ), const SizedBox(height: 5),],
      TextFormField(
        validator: validator,
        keyboardType: textInputType ?? TextInputType.text,
        obscuringCharacter: "*",
        controller: controller,
        onTap: onTap,
        cursorColor: ColorConstants.white,
        obscureText: obscureText,
        maxLines: maxLine,
        minLines: minLine,
        onFieldSubmitted: onFieldSubmitted,
        style: textStyle??const TextStyle(fontSize: 14, fontWeight: FontWeight.w300,color: ColorConstants.white,fontFamily: FontConstant.satoshiMedium),
        textCapitalization: textCapitalization ?? TextCapitalization.none,
        onChanged:onChanged ,
        textInputAction: textInputAction ?? TextInputAction.done,
        textAlignVertical: textAlignVertical ?? TextAlignVertical.bottom,
        decoration: InputDecoration(
            isDense: isDense,
            suffixIconConstraints: suffixIconSpace == true ? null : const BoxConstraints(maxWidth: 50, minWidth: 35, minHeight: 25, maxHeight: 25),
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            errorStyle: const TextStyle(
                color: Colors.redAccent,
                fontSize: 14,
                fontWeight: FontWeight.w300,fontFamily: FontConstant.satoshiMedium),
            focusedBorder: showBorder?(showOnFocusBorder?enabledBorder(context):customBorder(context)):InputBorder.none,
            enabledBorder: showBorder?(customBorder(context)):InputBorder.none,
            disabledBorder:showBorder?(customBorder(context)):InputBorder.none,
            border:        showBorder?customBorder(context):InputBorder.none,
            contentPadding: addPadding ? padding ?? const EdgeInsets.symmetric(vertical: 15,horizontal: 15):null,
            hintText: hint,
            hintStyle: TextStyle(color: ColorConstants.white.withOpacity(.3), fontSize: 14, fontWeight: FontWeight.w300,fontFamily: FontConstant.satoshiMedium)),
        focusNode: focusNode,
      ),
    ],
  );
}

customBorder(BuildContext context) {
  return OutlineInputBorder(
      borderSide: const BorderSide(color: ColorConstants.border),
      borderRadius: BorderRadius.circular(12));
}

enabledBorder(BuildContext context) {
  return OutlineInputBorder(
      borderSide: const BorderSide(color: ColorConstants.blue, width: 2),
      borderRadius: BorderRadius.circular(12));
}
