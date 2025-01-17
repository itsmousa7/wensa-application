import 'package:flutter/material.dart';
import 'package:wensa/login.dart';
import 'reusecontainer.dart';
import 'main.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({super.key});

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  String selectedCont = '';  // To track the selected text field

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
              child: Image.asset(
                'images/profile.jpeg',  // Your image asset
                height: 400,
                fit: BoxFit.fitHeight,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 60),
                      child: Text(
                        "Reset Password",
                        style: AppTextStyles.pageTextStyle(Theme.of(context).colorScheme.secondary,30),
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      "Please enter your new password",
                      style: AppTextStyles.satosh(shadegrey),
                    ),
                  ),
                  const SizedBox(height: 50),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedCont = 'new_password';
                            });
                          },
                          child: ReuseContainer(
                            label: "New Password",
                            selectedCol: selectedCont == 'new_password',
                            isPassword: true,  // Mark this as a password field
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedCont = 'confirm_password';
                            });
                          },
                          child: ReuseContainer(
                            label: "Confirm Password",
                            selectedCol: selectedCont == 'confirm_password',
                            isPassword: true,  // Mark this as a password field
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35),
                        color: Colors.blue,
                      ),
                      child: const Center(
                        child: Text(
                          "Reset Password",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
