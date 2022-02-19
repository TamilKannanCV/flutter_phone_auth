import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_auth/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _verificationCodeController =
      TextEditingController();

  bool _codeSent = false;

  String verificationId = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _phoneNumberController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Phone number",
                ),
              ),
              const SizedBox(height: 10.0),
              ElevatedButton(
                child: const Text("Verify"),
                onPressed: () async {
                  await FirebaseAuth.instance.verifyPhoneNumber(
                    phoneNumber: _phoneNumberController.text,
                    verificationCompleted: (credential) async {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      );
                    },
                    verificationFailed: (e) {
                      if (e.code == 'invalid-phone-number') {
                        log('The provided phone number is not valid.');
                      }
                    },
                    codeSent: (id, resendToken) {
                      setState(() {
                        _codeSent = true;
                        verificationId = id;
                      });
                    },
                    codeAutoRetrievalTimeout: (id) {},
                  );
                },
              ),
              if (_codeSent == true) ...[
                const SizedBox(height: 10.0),
                TextFormField(
                  controller: _verificationCodeController,
                  decoration: const InputDecoration(
                    labelText: "Verification code",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10.0),
                ElevatedButton(
                  child: const Text("Verify code"),
                  onPressed: () async {
                    final credential = PhoneAuthProvider.credential(
                      verificationId: verificationId,
                      smsCode: _verificationCodeController.text,
                    );
                    FirebaseAuth.instance
                        .signInWithCredential(credential)
                        .then((value) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: ((context) => const HomeScreen()),
                        ),
                      );
                    });
                  },
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
