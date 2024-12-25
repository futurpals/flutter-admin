import 'package:flutter/material.dart';

class LoginTextField extends StatefulWidget {
  final double height;
  final String hintText;
  final bool isPassword;
  final BorderRadiusGeometry? borderRadius;

  const LoginTextField(
      {super.key,
      this.height = 48,
      this.hintText = '',
      this.isPassword = false,
      this.borderRadius});

  @override
  State<LoginTextField> createState() => _LoginTextFieldState();
}

class _LoginTextFieldState extends State<LoginTextField> {
  TextEditingController textCtrl = TextEditingController(text: '');
  final FocusNode _focusNode = FocusNode();
  bool _hasFocus = false;
  bool _obscureText = false;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword ? true : false;
    _focusNode.addListener(() {
      if (mounted) {
        setState(() {
          _hasFocus = _focusNode.hasFocus;
        });
      }
    });
  }

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      padding: const EdgeInsets.only(left: 12, right: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: widget.borderRadius ?? BorderRadius.circular(10),
        border: Border.all(
          color: _hasFocus ? Colors.black : const Color(0xFFE4E4E7),
          width: 1.0,
        ),
      ),
      child: TextField(
        focusNode: _focusNode,
        maxLines: 1,
        maxLength: 20,
        controller: textCtrl,
        textAlign: TextAlign.left,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
        obscureText: _obscureText,
        decoration: InputDecoration(
          border: InputBorder.none,
          counterText: '',
          hintText: widget.hintText,
          hintStyle: const TextStyle(
              color: Color(0xFFA4A4A9), fontWeight: FontWeight.w100),
          contentPadding: widget.isPassword
              ? const EdgeInsets.only(top: 12)
              : const EdgeInsets.only(bottom: 2),
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                    size: 18,
                  ),
                  onPressed: _toggleObscureText,
                )
              : null,
        ),
        cursorColor: Colors.black,
        cursorWidth: 1,
        onSubmitted: (text) {},
        onChanged: (text) {},
        style: const TextStyle(
            color: Colors.black87, fontSize: 14, fontWeight: FontWeight.bold),
      ),
    );
  }
}
