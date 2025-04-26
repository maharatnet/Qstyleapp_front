import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:intl/intl.dart' hide TextDirection;

class CustomTextField extends StatefulWidget {
  final bool obscureText;
  final bool withValidation;
  final bool isMultiLine;
  final bool enabled;
  final bool? filled;
  final String? name;
  final String? hint;
  final TextStyle? hintStyle;
  final String? initialValue;
  final List<TextInputFormatter>? inputFormatters;
  final double? borderRadius;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final VoidCallback? onTap;
  final Function(String? value)? onSaved;
  final Function(String value)? onFieldSubmitted;
  final String? Function(String? value)? validator;
  final Function(String value)? onChanged;
  final Function()? onEditingComplete;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? pathPrefixIcon;
  final BoxConstraints? prefixIconConstraints;
  final BoxConstraints? suffixIconConstraints;
  final double? pathPrefixIconSize;
  final InputBorder? errorBorder;
  final InputBorder? focusedErrorBorder;
  final InputBorder? disabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final InputBorder border;
  final Color? fillColor;
  final InputDecoration? decoration;
  final AutovalidateMode? autovalidateMode;
  final TextDirection? textDirection;
  final int? maxLength;
  final bool autoDirection;

  const CustomTextField(
      {Key? key,
      this.obscureText = false,
      this.withValidation = true,
      this.isMultiLine = false,
      this.enabled = true,
      this.filled,
      this.hint,
      this.hintStyle,
      this.initialValue,
      this.inputFormatters,
      this.borderRadius,
      this.style,
      this.textAlign,
      this.maxLines = 1,
      this.padding,
      this.margin,
      this.onTap,
      this.onSaved,
      this.onFieldSubmitted,
      this.keyboardType,
      this.validator,
      this.onChanged,
      this.onEditingComplete,
      this.controller,
      this.focusNode,
      this.prefixIcon,
      this.pathPrefixIcon,
      this.pathPrefixIconSize,
      this.suffixIcon,
      this.prefixIconConstraints,
      this.suffixIconConstraints,
      this.textInputAction,
      this.errorBorder,
      this.focusedErrorBorder,
      this.disabledBorder,
      this.focusedBorder,
      this.enabledBorder,
      this.border = InputBorder.none,
      this.fillColor,
      this.autovalidateMode,
      this.textDirection,
      this.maxLength,
      this.name,
      this.autoDirection = false,
      this.decoration = const InputDecoration()})
      : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  String? text;

  @override
  void initState() {
    super.initState();
    if (widget.controller != null) {
      text = widget.controller!.text;
    }
    if (widget.initialValue != null) {
      text = widget.initialValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (widget.name != null)
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  '${widget.name}',
                  style: TextStyle(
                      color: const Color(0xff404040), fontSize: 14),
                ),
              ),

            ],
          ),
        InkWell(
          onTap: widget.onTap,
          child: IgnorePointer(
              ignoring: widget.onTap != null,
              child: Padding(
                padding:
                    widget.margin ?? EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                      style: widget.style,
                      textDirection: !widget.autoDirection
                          ? widget.textDirection
                          : text == null || text!.isEmpty
                              ? null
                              //: Bidi.detectRtlDirectionality(text!)
                                //  ? TextDirection.rtl
                                  :
                      TextDirection.ltr,
                      controller: widget.controller,
                      maxLines: widget.maxLines,
                      maxLength: widget.maxLength,
                      keyboardType: widget.keyboardType,
                      textInputAction: widget.textInputAction,
                      onFieldSubmitted: widget.onFieldSubmitted,
                      onChanged: (value) {
                        if (widget.autoDirection) {
                          text = value;
                        }
                        if (widget.onChanged != null) {
                          widget.onChanged!(value);
                        }
                      },
                      focusNode: widget.focusNode,
                      autovalidateMode: widget.autovalidateMode,
                      validator: widget.validator,
                      obscureText: widget.obscureText,
                      inputFormatters: widget.inputFormatters,
                      decoration: InputDecoration(
                        counterText: '',
                          hintText: widget.hint,
                          hintStyle: widget.hintStyle,
                          border: InputBorder.none,
                          contentPadding:
                              widget.padding ?? EdgeInsets.all(13),
                          filled: true,
                          fillColor: widget.fillColor?? Color(0xffFAFAFA),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                  color: const Color(0xffD5D6DD),
                                  width: 0.5)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                  color: const Color(0xffD5D6DD),
                                  width: 0.5)),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                  color: const Color(0xffD5D6DD),
                                  width: 0.5)),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                  color: const Color(0xffD5D6DD),
                                  width: 0.5)),
                          prefixIcon: widget.prefixIcon,
                          prefixIconConstraints:
                              widget.prefixIconConstraints,
                          suffixIconConstraints:
                              widget.suffixIconConstraints,
                          suffixIcon: widget.suffixIcon),
                    ),
              )),
        ),
      ],
    );
  }
}
