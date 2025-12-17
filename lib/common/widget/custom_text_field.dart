import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:flutter/foundation.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class CustomTextField extends StatefulWidget {
  final String? hintText;
  final String? labelText;
  final TextEditingController? controller;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final bool isPassword;
  final bool isAmount;
  final Function(String text)? onChanged;
  final String? Function(String?)? validator;
  final Function()? onTap;
  final Function()? onEditingComplete;
  final bool isEnabled;
  final int maxLines;
  final int minLines;
  final TextCapitalization capitalization;
  final List<TextInputFormatter>? inputFormatters ;
  final double borderRadius;
  final Color? borderColor;
  final String? prefixIcon;
  final Widget? prefix;
  final double? prefixIconSize;
  final String? suffixIcon;
  final Widget? suffix;
  final Color? suffixIconColor;
  final bool showBorder;
  final Color? fillColor;
  final bool limit;
  final Function()? onPressedSuffix;
  final Function()? onPressedPrefix;
  final void Function(String)? onSubmitted;
  final String? title;
  final bool readOnly;
  final bool filled;
  final Color? prefixIconColor;
  final int? maxLength;
  final bool isRequired;
  final double? contentPadding;


  const CustomTextField({
    super.key,
    this.hintText = 'Write something...',
    this.labelText,
    this.controller,
    this.focusNode,
    this.nextFocus,
    this.isEnabled = true,
    this.inputType = TextInputType.text,
    this.inputAction = TextInputAction.next,
    this.maxLines = 1,
    this.onChanged,
    this.prefixIcon,
    this.prefixIconSize,
    this.capitalization = TextCapitalization.none,
    this.isPassword = false,
    this.isAmount = false,
    this.borderRadius = 5,
    this.showBorder = true,
    this.fillColor,
    this.suffixIcon,
    this.onPressedSuffix,
    this.onSubmitted,
    this.limit = false,
    this.maxLength = 500,
    this.title,
    this.onTap,
    this.readOnly = false,
    this.filled = false,
    this.prefixIconColor,
    this.validator,
    this.suffixIconColor,
    this.inputFormatters,
    this.onEditingComplete,
    this.borderColor,
    this.textStyle,
    this.hintStyle,
    this.suffix,
    this.prefix,
    this.isRequired = false,
    this.minLines = 1,
    this.onPressedPrefix, this.contentPadding,

  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(widget.title != null)...[
          Padding(
            padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
            child: Row(
              children: [
                Text(widget.title??"",
                  style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault)),
                if(widget.isRequired)
                  Text('*',style: textSemiBold.copyWith( fontSize: Dimensions.fontSizeDefault),),
              ],
            ),
          ),
          const SizedBox(height: Dimensions.paddingSizeSeven,)
        ],

        TextFormField(
          maxLines: widget.maxLines,
          minLines: widget.minLines,
          controller: widget.controller,
          focusNode: widget.focusNode,
          validator: widget.validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onTap: widget.onTap,
          readOnly:widget.readOnly,
          style: widget.textStyle?? Get.textTheme.titleMedium!.copyWith(fontSize: Dimensions.fontSizeLarge,
              color: Theme.of(context).textTheme.bodyLarge?.color, fontWeight: FontWeight.w400),
          textInputAction: widget.inputAction,

          keyboardType: (widget.isAmount || widget.inputType == TextInputType.phone)
              ? const TextInputType.numberWithOptions(signed: false, decimal: true) : widget.inputType,
          cursorColor: Theme.of(context).primaryColor,
          textCapitalization: widget.capitalization,
          enabled: widget.isEnabled,
          autofocus: false,

          autofillHints: widget.inputType == TextInputType.name
              ? [AutofillHints.name]
              : widget.inputType == TextInputType.emailAddress
              ? [AutofillHints.email]
              : widget.inputType == TextInputType.phone
              ? [AutofillHints.telephoneNumber]
              : widget.inputType == TextInputType.streetAddress
              ? [AutofillHints.fullStreetAddress]
              : widget.inputType == TextInputType.url
              ? [AutofillHints.url]
              : widget.inputType == TextInputType.visiblePassword
              ? [AutofillHints.password]
              : null,
          obscureText: widget.isPassword ? _obscureText : false,
          inputFormatters:  widget.inputFormatters,
          onEditingComplete: widget.onEditingComplete,
          decoration: InputDecoration(
            isDense: true,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                borderSide: BorderSide(
                    width: widget.showBorder ? .5 : 0,
                    color: widget.borderColor ?? Theme.of(context).hintColor.withValues(alpha: widget.showBorder ? 1 : 0)),),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                borderSide: BorderSide(width: widget.showBorder ? .5 : 0,
                    color:  widget.borderColor ?? Theme.of(context).hintColor.withValues(alpha: widget.showBorder ? 1 : 0)),),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                borderSide: BorderSide(width: widget.showBorder ? .5 : 0, color: Theme.of(context).colorScheme.error.withValues(alpha: widget.showBorder ? 1 : 0)),),
              focusedErrorBorder : OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                borderSide: BorderSide(width: widget.showBorder ? .5 : 0, color: Theme.of(context).colorScheme.error.withValues(alpha: widget.showBorder ? 1 : 0)),),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                borderSide: BorderSide(width: widget.showBorder ? .5 : 0, color: Theme.of(context).primaryColor.withValues(alpha: widget.showBorder ? 1 : 0) ),),
              errorStyle: textRegular.copyWith(color:  Theme.of(context).colorScheme.error,fontSize: Dimensions.fontSizeDefault),
              hintText: widget.hintText,
              alignLabelWithHint: true,
              labelStyle: widget.hintStyle ?? widget.textStyle ??  textRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).hintColor,fontWeight: FontWeight.w400),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              labelText: widget.labelText,
              floatingLabelStyle: textRegular.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).colorScheme.secondary,fontWeight: FontWeight.w400),
              fillColor: widget.fillColor?? Theme.of(context).cardColor,
              hintStyle: widget.hintStyle ?? widget.textStyle ??  textRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).hintColor,fontWeight: FontWeight.w400),
              filled: widget.filled,
              contentPadding: EdgeInsets.symmetric(vertical: widget.maxLines > 1 ? 10 : widget.contentPadding??10,
                  horizontal:Dimensions.paddingSizeDefault),

              prefixIcon: widget.prefix ?? (widget.prefixIcon != null  ?
              GestureDetector(
                onTap: widget.onPressedPrefix,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: SvgPicture.asset(widget.prefixIcon!,colorFilter: ColorFilter.mode(widget.prefixIconColor??
                      Theme.of(context).hintColor, BlendMode.srcIn), height: widget.prefixIconSize??20,),
                ),
              ) : null),

              suffixIcon: widget.suffix ?? (widget.suffixIcon != null ?
              IconButton(
                onPressed: widget.onPressedSuffix,
                icon: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                  child: Image.asset(widget.suffixIcon!, height: 20, width: 20,color: widget.suffixIconColor),),) : widget.isPassword ?

              IconButton(icon: Icon(_obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                  color: Theme.of(context).hintColor),
                  onPressed: _toggle) : null)),
          onFieldSubmitted: widget.onSubmitted ?? (text) => widget.nextFocus  != null ?
              FocusScope.of(context).requestFocus(widget.nextFocus) : null,
          onChanged: widget.onChanged,
        ),
      ],
    );
  }

  bool _obscureText = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}


class DecoratedInputBorder extends InputBorder {
  DecoratedInputBorder({
    required this.child,
    required this.shadow,
  }) : super(borderSide: child.borderSide);

  final InputBorder child;

  final BoxShadow shadow;

  @override
  bool get isOutline => child.isOutline;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) => child.getInnerPath(rect, textDirection: textDirection);

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) => child.getOuterPath(rect, textDirection: textDirection);

  @override
  EdgeInsetsGeometry get dimensions => child.dimensions;

  @override
  InputBorder copyWith({BorderSide? borderSide, InputBorder? child, BoxShadow? shadow, bool? isOutline}) {
    return DecoratedInputBorder(
      child: (child ?? this.child).copyWith(borderSide: borderSide),
      shadow: shadow ?? this.shadow,
    );
  }

  @override
  ShapeBorder scale(double t) {
    final scalledChild = child.scale(t);

    return DecoratedInputBorder(
      child: scalledChild is InputBorder ? scalledChild : child,
      shadow: BoxShadow.lerp(null, shadow, t)!,
    );
  }

  @override
  void paint(Canvas canvas, Rect rect, {double? gapStart, double gapExtent = 0.0, double gapPercentage = 0.0, TextDirection? textDirection}) {
    final clipPath = Path()
      ..addRect(const Rect.fromLTWH(-5000, -5000, 10000, 10000))
      ..addPath(getInnerPath(rect), Offset.zero)
      ..fillType = PathFillType.evenOdd;
    canvas.clipPath(clipPath);

    final Paint paint = shadow.toPaint();
    final Rect bounds = rect.shift(shadow.offset).inflate(shadow.spreadRadius);

    canvas.drawPath(getOuterPath(bounds), paint);

    child.paint(canvas, rect, gapStart: gapStart, gapExtent: gapExtent, gapPercentage: gapPercentage, textDirection: textDirection);
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    return other is DecoratedInputBorder && other.borderSide == borderSide && other.child == child && other.shadow == shadow;
  }

  @override
  int get hashCode => Object.hash(borderSide, child, shadow);

  @override
  String toString() {
    return '${objectRuntimeType(this, 'DecoratedInputBorder')}($borderSide, $shadow, $child)';
  }
}