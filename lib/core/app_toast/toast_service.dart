import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:maharat_ecommerce/component/styles_manager.dart';
import 'package:maharat_ecommerce/core/app_toast/app_toast.dart';

class ToastViewManager<T> extends ValueNotifier<T> {
  ToastViewManager(super.val);
}

enum ToastLength {short, medium, long, ages, never }

class ToastService {
  static final ToastViewManager<int> _expandedIndex = ToastViewManager<int>(-1);
  static final List<OverlayEntry?> _overlayEntries = [];
  static final List<double> _overlayPositions = [];
  static final List<int> _overlayIndexList = [];
  static final List<AnimationController?> _animationControllers = [];
  static OverlayState? _overlayState;
  static int? _showToastNumber;

  static void showToastNumber(int val) {
    assert(val > 0, "Show toast number can't be negative or zero. Default show toast number is 5.");
    if (val > 0) {_showToastNumber = val;}
  }

  static void _reverseAnimation(int index) {
    if (_overlayIndexList.contains(index)) {
      _animationControllers[index]?.reverse().then((_) async {
        await Future.delayed(const Duration(milliseconds: 50));
        _removeOverlayEntry(index);
      });
    }
  }

  static void _removeOverlayEntry(int index) {
    _overlayEntries[index]?.remove();
    _animationControllers[index]?.dispose();
    _overlayIndexList.remove(index);
  }

  static void _forwardAnimation(int index) {
    _overlayState?.insert(_overlayEntries[index]!);
    _animationControllers[index]?.forward();
  }

  static double _calculatePosition(int index) {
    return _overlayPositions[index];
  }

  static void _addOverlayPosition(int index) {
    _overlayPositions.add(40);
    _overlayIndexList.add(index);
  }

  static bool _isToastInFront(int index) => index > _overlayPositions.length - 5;

  static void _updateOverlayPositions({bool isReverse = false, int pos = 0}) {
    if (isReverse) {
      _reverseUpdatePositions(pos: pos);
    } else {
      _forwardUpdatePositions();
    }
  }

  static void _rebuildPositions() {
    for (int i = 0; i < _overlayPositions.length; i++) {
      _overlayEntries[i]?.markNeedsBuild();
    }
  }

  static void _reverseUpdatePositions({int pos = 0}) {
    for (int i = pos - 1; i >= 0; i--) {
      _overlayPositions[i] = _overlayPositions[i] - 10;
      _overlayEntries[i]?.markNeedsBuild();
    }
  }

  static void _forwardUpdatePositions() {
    for (int i = 0; i < _overlayPositions.length; i++) {
      _overlayPositions[i] = _overlayPositions[i] + 10;
      _overlayEntries[i]?.markNeedsBuild();
    }
  }

  static double _calculateOpacity(int index) {
    int noOfShowToast = _showToastNumber ?? 5;
    if (_overlayIndexList.length <= noOfShowToast) return 1;
    final isFirstFiveToast = _overlayIndexList.sublist(_overlayIndexList.length - noOfShowToast).contains(index);
    return isFirstFiveToast ? 1 : 0;
  }

  static void _toggleExpand(int index) {
    if (_expandedIndex.value == index) {
      _expandedIndex.value = -1;
    } else {
      _expandedIndex.value = index;
    }
    _rebuildPositions();
  }

  static Duration _toastDuration(ToastLength length) {
    switch (length) {
      case ToastLength.short:
        return const Duration(milliseconds: 2000);
      case ToastLength.medium:
        return const Duration(milliseconds: 4000);
      case ToastLength.long:
        return const Duration(milliseconds: 6000);
      case ToastLength.ages:
        return const Duration(minutes: 2);
      default:
        return const Duration(hours: 24);
    }
  }


  static Future<void> _showToast(
    BuildContext context, {
    String? message,
    bool topView = false,
    TextStyle? messageStyle,
    Widget? leading,
    ToastType type = ToastType.success,
    EdgeInsetsGeometry? padding,
    Widget? child,
    bool isClosable = false,
    double expandedHeight = 100,
    Color? backgroundColor,
    Color? shadowColor,
    Curve? slideCurve,
    Curve positionCurve = Curves.elasticOut,
    ToastLength length = ToastLength.medium,
    DismissDirection dismissDirection = DismissDirection.down,
  }) async {
    assert(expandedHeight >= 0.0,
        "Expanded height should not be a negative number!");
    if (context.mounted) {
      _overlayState = Overlay.of(context);
      final controller = AnimationController(
        vsync: _overlayState!,
        duration: const Duration(milliseconds: 1000),
        reverseDuration: const Duration(milliseconds: 1000),
      );
      _animationControllers.add(controller);
      int controllerIndex = _animationControllers.indexOf(controller);
      _addOverlayPosition(controllerIndex);
      final overlayEntry = OverlayEntry(
        builder: (context) => AnimatedPositioned(
          top: topView?_calculatePosition(controllerIndex) + (_expandedIndex.value == controllerIndex ? expandedHeight : 0.0):null,
          left: 10,
          right: 10,
          bottom: topView?null:30,
          duration: const Duration(milliseconds: 500),
          curve: positionCurve,
          child: Dismissible(
            key: Key(UniqueKey().toString()),
            direction: dismissDirection,
            onDismissed: (_) {
              _removeOverlayEntry(_animationControllers.indexOf(controller));
              _updateOverlayPositions(
                isReverse: true,
                pos: _animationControllers.indexOf(controller),
              );
            },
            child: AnimatedPadding(
              padding: EdgeInsets.symmetric(
                horizontal: (_expandedIndex.value == controllerIndex ? 10 : max(_calculatePosition(controllerIndex) - 35, 0.0)),
              ),
              duration: const Duration(milliseconds: 500),
              curve: positionCurve,
              child: AnimatedOpacity(
                opacity: _calculateOpacity(controllerIndex),
                duration: const Duration(milliseconds: 500),
                child: CustomToast(
                  message: message,
                  padding: padding,
                  type: type,
                  messageStyle: messageStyle,
                  backgroundColor: backgroundColor,
                  shadowColor: shadowColor,
                  curve: slideCurve,
                  isClosable: isClosable,
                  isInFront: _isToastInFront(_animationControllers.indexOf(controller)),
                  controller: controller,
                  onTap: () => _toggleExpand(controllerIndex),
                  onClose: () {
                    _removeOverlayEntry(_animationControllers.indexOf(controller));
                    _updateOverlayPositions(
                      isReverse: true,
                      pos: _animationControllers.indexOf(controller),
                    );
                  },
                  leading: leading,
                  child: child,
                ),
              ),
            ),
          ),
        ),
      );
      _overlayEntries.add(overlayEntry);
      _updateOverlayPositions();
      _forwardAnimation(_animationControllers.indexOf(controller));
      await Future.delayed(_toastDuration(length));
      _reverseAnimation(_animationControllers.indexOf(controller));
    }
  }

  
  static Future<void> showToast(
    BuildContext context, {
    ToastType type = ToastType.success,
    String? message,
    TextStyle? messageStyle,
    Widget? leading,
    Widget? child,
    bool isClosable = false,
    EdgeInsetsGeometry? padding,
    bool topView = false,
    double expandedHeight = 100,
    Color? backgroundColor,
    Color? shadowColor,
    Curve? slideCurve,
    Curve positionCurve = Curves.elasticOut,
    ToastLength length = ToastLength.short,
    DismissDirection dismissDirection = DismissDirection.down,
  }) async {
    _showToast(
      context,
      message: message,
      topView: topView,
      padding: padding,
      type: type,
      messageStyle: messageStyle,
      isClosable: isClosable,
      expandedHeight: expandedHeight,
      backgroundColor: backgroundColor,
      shadowColor: shadowColor,
      positionCurve: positionCurve,
      length: length,

      child: child,
      dismissDirection: dismissDirection,
      leading: leading,
    );
  }
}

class CustomToast extends StatefulWidget {
  final ToastType type;
  final String? message;
  final TextStyle? messageStyle;
  final EdgeInsetsGeometry? padding;
  final Widget? child;
  final Widget? leading;
  final Color? backgroundColor;
  final Color? shadowColor;
  final AnimationController? controller;
  final bool isInFront;
  final VoidCallback onTap;
  final VoidCallback? onClose;
  final Curve? curve;
  final bool? isClosable;

  const CustomToast({
    required this.controller,
    required this.onTap,
    required this.type,
    super.key,
    this.isInFront = false,
    this.onClose,
    this.message,
    this.messageStyle,
    this.padding,
    this.leading,
    this.child,
    this.isClosable,
    this.backgroundColor,
    this.shadowColor,
    this.curve,
  }) : assert((message != null || message != '') || child != null);

  @override
  State<CustomToast> createState() => _CustomToastState();
}

class _CustomToastState extends State<CustomToast> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller!,
      builder: (context, _) {
        return Material(
          color: Colors.transparent,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.0, 1.0),
              end: const Offset(0.0, 0.0),
            ).animate(
              CurvedAnimation(
                parent: widget.controller!,
                curve: widget.curve ?? Curves.elasticOut,
                reverseCurve: widget.curve ?? Curves.elasticOut,
              ),
            ),
            child: Stack(
              children: [
                InkWell(
                  onTap: widget.onTap,
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    width: MediaQuery.sizeOf(context).width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(80),
                      border: Border.all(
                        width: 1,
                        color: widget.type == ToastType.warning
                            ? const Color(0xffFFD21E)
                            : widget.type == ToastType.error
                            ? const Color(0xffF04248)
                            : const Color(0xff95E2B8),
                      ),
                      color: Colors.transparent, // important
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(80),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          padding: widget.padding ??
                              const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                              // const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                          color: widget.type == ToastType.warning
                              ? const Color(0xffFFD21E).withOpacity(0.25)
                              : widget.type == ToastType.error
                              ? const Color(0xffF04248).withOpacity(0.25)
                              : const Color(0xffF2FFF7),
                          child: widget.child ??
                              Row(
                                children: [
                                  if (widget.leading != null) ...[
                                    widget.leading!,
                                    const SizedBox(width: 10),
                                  ],
                                  if (widget.message != null)
                                    Expanded(
                                      child: Text(
                                        widget.message!,
                                        style: widget.type == ToastType.success
                                            ? getBoldStyle(
                                          color: const Color(0xff2DC071),
                                          fontSize: 14,
                                        )
                                            : widget.messageStyle,
                                      ),
                                    ),
                                ],
                              ),
                        ),
                      ),
                    ),
                  ),
                ),
                if (widget.isClosable ?? false)
                  Positioned(
                    top: 0,
                    right: 16,
                    bottom: 0,
                    child: InkWell(
                      onTap: widget.onClose,
                      child: const Icon(Icons.close, size: 18),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );

    // return AnimatedBuilder(
    //     animation: widget.controller!,
    //     builder: (context, _) {
    //       return Material(
    //         color: Colors.transparent,
    //         child: SlideTransition(
    //           position: Tween<Offset>(
    //             begin: const Offset(0.0, 1.0),
    //             end: const Offset(0.0, 0.0),
    //           ).animate(
    //             CurvedAnimation(
    //               parent: widget.controller!,
    //               curve: widget.curve ?? Curves.elasticOut,
    //               reverseCurve: widget.curve ?? Curves.elasticOut,
    //             ),
    //           ),
    //           child: Directionality(
    //             textDirection: context.textDirection,
    //
    //             child: Stack(
    //               children: [
    //                 InkWell(
    //                   onTap: widget.onTap,
    //                   borderRadius: BorderRadius.circular(15),
    //                   child: Container(
    //                     clipBehavior: Clip.hardEdge,
    //                     width: MediaQuery.sizeOf(context).width,
    //                     padding: widget.padding?? const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
    //                     decoration: BoxDecoration(
    //                       borderRadius: BorderRadius.circular(80),
    //                       // borderRadius: BorderRadius.circular(15),
    //                       color: widget.type == ToastType.warning ?
    //                       const Color(0xffFFD21E).withOpacity(0.25) : widget.type == ToastType.error ?
    //                       const Color(0xffF04248).withOpacity(0.25) : const Color(0xffF2FFF7),
    //                       // gradient: LinearGradient(colors: [
    //                       //
    //                       //   widget.type == ToastType.warning ?
    //                       //   const Color(0xffFFD21E).withOpacity(0.25) : widget.type == ToastType.error ?
    //                       //   const Color(0xffF04248).withOpacity(0.25) : const Color(0xffF2FFF7),
    //                       //   // const Color(0xffF04248).withOpacity(0.25) : const Color(0xff00DF80).withOpacity(0.05),
    //                       //   Theme.of(context).highlightColor.withOpacity(0.25)
    //                       // ]
    //                       // ),
    //                       border: Border.all(
    //                         width: 2,
    //                         color:  widget.type == ToastType.warning ?
    //                         const Color(0xffFFD21E) : widget.type == ToastType.error ?
    //                         const Color(0xffF04248) :
    //                         const Color(0xff00a250)
    //                       )
    //                     ),
    //                     child: BackdropFilter(
    //                       filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
    //                       child: (widget.child != null) ? widget.child :Row(
    //                         children: [
    //                           if (widget.leading != null) ...[widget.leading!, const SizedBox(width: 10,),],
    //                           if (widget.message != null)Expanded(child: Text(widget.message!, style:
    //                           widget.type ==ToastType.success?getBoldStyle(color: Color(0xff2DC071),fontSize: 14):
    //                               widget.messageStyle),),
    //                         ],
    //                       ),
    //                     )
    //                   ),
    //                 ),
    //                 if (widget.isClosable ?? false)
    //                 Positioned(
    //                   top: 0,
    //                   right: 16,
    //                   bottom: 0,
    //                   child: InkWell(
    //                     onTap: widget.onClose,
    //                     child: const Icon(Icons.close, size: 18),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ),
    //       );
    //     });
  }
}
