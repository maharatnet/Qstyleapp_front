import 'package:maharat_ecommerce/component/color_manger.dart';
import 'package:maharat_ecommerce/component/styles_manager.dart';
import 'package:flutter/material.dart';

class CustomDropDownTextField extends StatefulWidget {
  final ValueChanged onChanged;
  final List<DropdownMenuItem>? items;
  final String? name;
  final Widget? icon;
  final String? Function(dynamic value)? validator;
  final AutovalidateMode? autovalidateMode;
  final dynamic value;
  final String? hint;

  const CustomDropDownTextField(
      {Key? key,
      required this.onChanged,
      this.items,
      this.name,
      this.icon,
      this.validator,
      this.hint,
      this.autovalidateMode,
      this.value})
      : super(key: key);

  @override
  State<CustomDropDownTextField> createState() =>
      _CustomDropDownTextFieldState();
}

class _CustomDropDownTextFieldState extends State<CustomDropDownTextField> {
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
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 8),
                child: Text(
                  '${widget.name}',
                  style: getBoldStyle(
                      color: const Color(0xff404040), fontSize: 14),
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: DropdownButtonFormField(
              value: widget.value,
              items: widget.items,
              icon: widget.icon,
              hint:widget.hint != null ? Text(widget.hint!,style: getBoldStyle(color: ColorManager.grey),) : null,
              validator: widget.validator,
              autovalidateMode: widget.autovalidateMode,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(13),
                  filled: true,
                  fillColor: const Color(0xffFAFAFA),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                          color: const Color(0xffD5D6DD), width: 0.5)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                          color: const Color(0xffD5D6DD), width: 0.5)),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                          color: const Color(0xffD5D6DD), width: 0.5)),
                  focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                          color: const Color(0xffD5D6DD), width: 0.5))),
              onChanged: widget.onChanged),
        ),
      ],
    );
  }
}


class CustomDropDownTWoTextField extends StatefulWidget {
  final ValueChanged onChanged;
  final List<DropdownMenuItem>? items;
  final String? name;
  final Widget? icon;
  final String? Function(dynamic value)? validator;
  final AutovalidateMode? autovalidateMode;
  final dynamic value;

  const CustomDropDownTWoTextField(
      {Key? key,
        required this.onChanged,
        this.items,
        this.name,
        this.icon,
        this.validator,
        this.autovalidateMode,
        this.value})
      : super(key: key);

  @override
  State<CustomDropDownTWoTextField> createState() =>
      _CustomDropDownTWoTextFieldState();
}

class _CustomDropDownTWoTextFieldState extends State<CustomDropDownTWoTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: DropdownButtonFormField(
          value: widget.value,
          items: widget.items,
          icon: widget.icon,
          validator: widget.validator,
          autovalidateMode: widget.autovalidateMode,
          decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(13),
              filled: true,
              fillColor: const Color(0xffFAFAFA),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(
                      color: const Color(0xffD5D6DD), width: 0.5)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(
                      color: const Color(0xffD5D6DD), width: 0.5)),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(
                      color: const Color(0xffD5D6DD), width: 0.5)),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(
                      color: const Color(0xffD5D6DD), width: 0.5))),
          onChanged: widget.onChanged),
    );
  }
}