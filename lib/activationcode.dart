import 'package:flutter/material.dart';
import 'otpauthentication.dart';
import 'package:wensa/newpassword.dart';
import 'main.dart';

class Activationcode extends StatefulWidget {
  const Activationcode({super.key});

  @override
  State<Activationcode> createState() => _ActivationcodeState();
}

class _ActivationcodeState extends State<Activationcode> {
  String selectedCont = '';  // This is used to track the selected text field

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
                'images/profile.jpeg',
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
                        "Activation Code",
                        style: AppTextStyles.pageTextStyle(Theme.of(context).colorScheme.secondary,30),
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      "Enter the activation code sent to your email",
                      style: AppTextStyles.satosh(Theme.of(context).colorScheme.secondary),
                    ),
                  ),
                  const SizedBox(height: 50),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [

                     OTPCont(),

                      OTPCont(),

                      OTPCont(),

                      OTPCont(),





                    ],
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const NewPassword()));

                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35),
                        color: Colors.blue,
                      ),
                      child:const Center(
                        child: Text(
                          "Reset password",
                          style: TextStyle(
                            color: background2,
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


