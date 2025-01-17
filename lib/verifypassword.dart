import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'main.dart';
import 'package:get/get.dart';
import 'otpauthentication.dart';
import 'navigationbar.dart';

class Verifyemail extends StatefulWidget {
  const Verifyemail({super.key});

  @override
  State<Verifyemail> createState() => _VerifyemailState();
}

class _VerifyemailState extends State<Verifyemail> {
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
              borderRadius: BorderRadius.only(
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
                  SizedBox(height: 50),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [

                       OTPCont(),

                       OTPCont(),

                       OTPCont(),

                       OTPCont(),





                    ],
                  ),
                  SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      Get.offAll(() =>  Navigationbar());
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35),
                        color: Colors.blue,
                      ),
                      child: Center(
                        child: Text(
                          "Verify",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


