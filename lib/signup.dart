import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wensa/login.dart';
import 'navigationbar.dart';
import 'main.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  String name ='';
  String email = '';
  String password = '';
  String _errorMessage = '';
  bool _obscureText = true;
  bool showSpiner = false;

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

  // Sign up function
  void _signUp() async
  {
    if(email.isEmpty || password.isEmpty)
    {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please enter all required information")));
      return;
    }
    setState(() {showSpiner = true;});
    try {
      final addUser = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      if (addUser != true)
      {
        final uid = addUser.user?.uid;
        if (uid != null) {
          await FirebaseFirestore.instance.collection('users').doc(uid).set({
            'UserName': name,
            'email': email,
            'ProfileImageURL': '',
          });
        }
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Navigationbar()));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Error. email or password incorrect")));
    } finally {setState(() {showSpiner = false;});}


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
                    "Sign up",
                    style: AppTextStyles.pageTextStyle(Theme.of(context).colorScheme.secondary, 30),
                  ),
                ),
              ),
              Center(
                child: Text(
                  "Welcome, please sign up to continue",
                  style: AppTextStyles.satosh(Theme.of(context).colorScheme.secondary),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    TextFormField(
                      textAlign: TextAlign.center,
                      onChanged: (value)
                      {
                        email = value;
                      },
                      decoration: _buildInputDecoration('Enter your email'),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      textAlign: TextAlign.center,
                      onChanged: (value)
                      {
                        name = value;
                      },
                      decoration: _buildInputDecoration('Enter your name'),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      textAlign: TextAlign.center,
                      obscureText: _obscureText,  // Obscure text for password
                      onChanged: (value) {
                        password = value;
                      },
                      decoration: InputDecoration(
                        labelText: 'Enter your password',
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
                      onPressed: _signUp,
                      child: Text(
                        'Sign Up',
                        style: AppTextStyles.satosh(Theme.of(context).colorScheme.background),
                      ),
                    ),
                    if (_errorMessage.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          _errorMessage,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) =>  Login()),
                        );
                      },
                      child: Text(
                        "Already have an account?",
                        style: AppTextStyles.satoshbig(Theme.of(context).colorScheme.secondary, 17),
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
