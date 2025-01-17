import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'navigationbar.dart';
import 'signup.dart';
import 'forgetpassword.dart';
import 'main.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  String email = '';
  String password = '';
  bool showSpiner = false;
  bool _obscureText = true;

  // Input decoration with password visibility toggle
  InputDecoration _buildInputDecoration(String hintText) {
    return InputDecoration(
      labelText: hintText,
      labelStyle: AppTextStyles.satoshbig(Theme.of(context).colorScheme.primary, 15),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: button,
          width: 2,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.primary,
          width: 2,
        ),
      ),
      suffixIcon: hintText == 'Password'
          ? IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility_off : Icons.visibility,
          color: _obscureText ? Theme.of(context).colorScheme.primary : button,
        ),
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;  // Toggle password visibility
          });
        },
      )
          : null,
      floatingLabelBehavior: FloatingLabelBehavior.auto,
    );
  }

  // Login function
  void _login() async {

    if(email.isEmpty || password.isEmpty)
    {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Enter Email and Password")));
      return;
    }

    setState(() {
      showSpiner = true;
    });
    try {

      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Navigationbar()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    } finally {
      setState(() {
        showSpiner = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(100),
                    bottomRight: Radius.circular(80),
                  ),
                  child: Image.asset(
                    'images/profile.jpeg',
                    height: 300,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      "Login",
                      style: AppTextStyles.pageTextStyle(Theme.of(context).colorScheme.secondary, 30),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    "Welcome back, please login to continue",
                    style: AppTextStyles.satosh(Theme.of(context).colorScheme.secondary),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      TextField(
                        keyboardType: TextInputType.emailAddress,
                        textAlign: TextAlign.center,
                        style:  TextStyle(color: Theme.of(context).colorScheme.secondary),
                        onChanged: (value) => email = value,
                        decoration: _buildInputDecoration('Email'),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        textAlign: TextAlign.center,
                        obscureText: _obscureText,  // Obscure text for password
                        onChanged: (value) {
                          password = value;
                        },
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: AppTextStyles.satoshbig(Theme.of(context).colorScheme.primary, 15),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: button,
                              width: 2,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary,
                              width: 2,
                            ),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText ? Icons.visibility_off : Icons.visibility,  // Toggle icon
                              color: _obscureText ? Theme.of(context).colorScheme.primary : button,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;  // Toggle password visibility
                              });
                            },
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                        ),
                      ),

                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: button),
                        onPressed: _login,
                        child: Text(
                          'Login',
                          style: AppTextStyles.satosh(Theme.of(context).colorScheme.background),
                        ),
                      ),

                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Signup()),
                          );
                        },
                        child: Text(
                          "Don't have an account?",
                          style: AppTextStyles.satoshbig(Theme.of(context).colorScheme.secondary, 17),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const Forgetpassword()),
                          );
                        },
                        child: Text(
                          "Forgot Password?",
                          style: AppTextStyles.satoshbig(Theme.of(context).colorScheme.secondary, 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
      ),
    );
  }
}
