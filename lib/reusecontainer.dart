import 'package:flutter/material.dart';
import 'main.dart';

class ReuseContainer extends StatefulWidget {
  final String label;
  final bool isPassword;
  final bool selectedCol;

  const ReuseContainer({
    Key? key,
    required this.label,
    this.isPassword = false,  // Defaults to false for non-password fields
    required this.selectedCol,
  }) : super(key: key);

  @override
  _ReuseContainerState createState() => _ReuseContainerState();
}

class _ReuseContainerState extends State<ReuseContainer> {
  bool _obscureText = true;  // For password visibility toggle

  @override
  Widget build(BuildContext context) {
    return  TextFormField(
        cursorColor: button,
        obscureText: widget.isPassword && _obscureText,  // Toggle password visibility
        decoration: InputDecoration(
          labelText: widget.label,  // Floating label
          labelStyle: AppTextStyles.satoshbig(Theme.of(context).colorScheme.primary, 15),  // Label text style
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),  // Rounded corners
            borderSide: BorderSide(
              color: button,  // Focused border color
              width: 2,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),  // Rounded corners
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,  // Enabled border color
              width: 2,
            ),
          ),
          suffixIcon: widget.isPassword
              ? IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility_off: Icons.visibility,
              color: _obscureText ? Theme.of(context).colorScheme.primary: button,
            ),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;  // Toggle the visibility state
              });
            },
          )
              : null,  // Show eye icon only for password fields
          floatingLabelBehavior: FloatingLabelBehavior.auto
        ),
    );
  }
}
