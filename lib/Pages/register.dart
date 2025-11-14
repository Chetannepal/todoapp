import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_todo/components/colors.dart';

class Register extends StatefulWidget {
  const Register({super.key});
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Register> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  //final _confirmPwController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> createUser() async {
    try {
      final usercredentials = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          );
      print(usercredentials);
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ABGColor,
      appBar: AppBar(backgroundColor: AGrey),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.message, size: 60),
                const SizedBox(height: 30),
                Text(
                  "Let's create an account for you",
                  style: TextStyle(color: ABlack, fontSize: 20),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    controller: _emailController,
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: ABlack),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: ABlack),
                      ),
                      labelText: "Enter your mail",
                      labelStyle: TextStyle(color: Colors.black),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter an email";
                      }
                      final emailRegex = RegExp(
                        r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
                      );
                      if (!emailRegex.hasMatch(value)) {
                        return "Please enter a valid email address";
                      }
                      return null;
                    },
                  ),
                ),
                //SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: ABlack),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: ABlack),
                      ),
                      //hintText: "Enter your Password",
                      labelText: "Password",
                      labelStyle: TextStyle(color: Colors.black),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 30),
                // Padding(
                //   padding: const EdgeInsets.all(16.0),
                //   child: TextFormField(
                //     controller: _confirmPwController,
                //     obscureText: true,
                //     decoration: InputDecoration(
                //       border: OutlineInputBorder(
                //         borderSide: BorderSide(color: ABlack),
                //       ),
                //       focusedBorder: OutlineInputBorder(
                //         borderSide: BorderSide(color: ABlack),
                //       ),
                //       //hintText: "Enter your Password",
                //       labelText: "Confirm Password",
                //       labelStyle: TextStyle(color: Colors.black),
                //     ),
                //     validator: (value) {
                //       if (value == null || value.isEmpty) {
                //         return 'Please enter your Password';
                //       }
                //       if (value.length < 6) {
                //         return 'Password must be at least 6 characters';
                //       }
                //       return null;
                //     },
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                    ),
                    onPressed: () async {
                      await createUser();
                    },
                    child: Text("Register", style: TextStyle(fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
