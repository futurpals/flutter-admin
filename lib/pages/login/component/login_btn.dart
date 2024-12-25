import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iot_web/base/constants.dart';

class LoginButton extends StatefulWidget {
  final String text;
  final Function onPress;
  final Color textColor;
  final Color borderColor;
  final double borderWidth;
  final Color color;
  final Color? focusColor;
  final double width;
  final BorderRadiusGeometry? borderRadius;

  const LoginButton(
      {super.key,
      required this.text,
      required this.onPress,
      this.textColor = Colors.white,
      this.borderColor = primaryBtnColor,
      this.color = primaryBtnColor,
      this.focusColor,
      this.borderWidth = 0,
      this.width = double.infinity,
      this.borderRadius});

  @override
  State<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  bool _isPressed = false;
  bool _isHover = false;

  void _onTapDown(TapDownDetails details) {
    if (mounted) {
      setState(() {
        _isPressed = true;
      });
    }
  }

  void _onTapUp(TapUpDetails details) {
    if (mounted) {
      setState(() {
        _isPressed = false;
      });
    }
    widget.onPress();
  }

  void _onTapCancel() {
    if (mounted) {
      setState(() {
        _isPressed = false;
      });
    }
  }

  void _onEnter(PointerEnterEvent event) {
    if (mounted) {
      setState(() {
        _isHover = true;
      });
    }
  }

  void _onExit(PointerExitEvent event) {
    if (mounted) {
      setState(() {
        _isHover = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: _onEnter,
      onExit: _onExit,
      child: GestureDetector(
        onTapUp: _onTapUp,
        onTapDown: _onTapDown,
        onTapCancel: _onTapCancel,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.only(top: 12, bottom: 12),
          decoration: BoxDecoration(
            color: _isHover ? widget.focusColor ?? focusBtnColor : widget.color,
            borderRadius: widget.borderRadius ??
                const BorderRadius.all(Radius.circular(10)),
            border: Border.all(
              color: widget.borderColor,
              width: widget.borderWidth,
            ),
            boxShadow: const [
              BoxShadow(
                color: Colors.white70,
                offset: Offset(1.0, 1.0),
                blurRadius: 1.0,
              ),
            ],
          ),
          child: Center(
            child: Text(
              widget.text,
              style: TextStyle(color: widget.textColor),
            ),
          ),
        ),
      ),
    );
  }
}
