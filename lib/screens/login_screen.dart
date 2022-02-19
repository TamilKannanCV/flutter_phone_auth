import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _verificationCodeController =
      TextEditingController();

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
                child: const Text("Get verification code"),
                onPressed: () {},
              ),
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
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
