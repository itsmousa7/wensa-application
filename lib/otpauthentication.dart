import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'main.dart';

class OTPCont extends StatelessWidget {
  const OTPCont({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: 68,
      width: 64,
      child: TextFormField(
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
        style: TextStyle(color: Theme.of(context).colorScheme.secondary,fontSize: 25),
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
        decoration: InputDecoration(

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: button, width: 2), // Focused border color
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2), // Enabled border color
          ),
        ),
      ),
    );

  }
}
