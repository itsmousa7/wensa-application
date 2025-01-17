import 'package:flutter/material.dart';
import 'activationcode.dart';
import 'reusecontainer.dart';
import 'main.dart';

class Forgetpassword extends StatefulWidget {
  const Forgetpassword({super.key});

  @override
  State<Forgetpassword> createState() => _ForgetpasswordState();
}

class _ForgetpasswordState extends State<Forgetpassword> {
  String selectedCont = '';  // Used to track the selected text field

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
                'images/profile.jpeg',  // Use a different image if needed
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
                        "Forget Password",
                        style: AppTextStyles.pageTextStyle(Theme.of(context).colorScheme.secondary,30),
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      "Enter your email to reset your password",
                      style: AppTextStyles.satosh(Theme.of(context).colorScheme.secondary),
                    ),
                  ),
                  const SizedBox(height: 50),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedCont = 'email';  // Update the selected field
                            });
                          },
                          child: ReuseContainer(
                            label: "Email",
                            selectedCol: selectedCont == 'email',  // Check if this field is selected
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  Activationcode()),  // Ensure Activationcode is being correctly used
                      );
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35),
                        color: Colors.blue,
                      ),
                      child: const Center(
                        child: Text(
                          "Send Reset Link",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Back to Login",
                      style: AppTextStyles.satoshbig(Theme.of(context).colorScheme.secondary, 15),
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
