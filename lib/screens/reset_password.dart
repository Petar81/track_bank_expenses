import 'package:flutter/material.dart';
import '../models/input_decoration.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _resetFormKey = GlobalKey<FormState>();
  String loginEmail = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Track Bank Expenses'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Form(
                  key: _resetFormKey,
                  child: Column(
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: Text(
                          "RESET PASSWORD",
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          decoration:
                              buildInputDecoration(Icons.email, "Email"),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter an email';
                            }
                            if (!RegExp(
                                    "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                .hasMatch(value)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            loginEmail = value!;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            // Validate returns true if the form is valid, or false otherwise.
                            if (_resetFormKey.currentState!.validate()) {
                              _resetFormKey.currentState!.save();
                              // If the form is valid, display a snackbar. In the real world,
                              // you'd often call a server or save the information in a database.
                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(
                                  const SnackBar(
                                      duration: Duration(seconds: 2),
                                      content: Text('Processing Data')),
                                );
                              await Future.delayed(const Duration(seconds: 1));
                              () async {
                                try {
                                  await FirebaseAuth.instance
                                      .sendPasswordResetEmail(
                                          email: loginEmail);
                                } on FirebaseAuthException catch (e) {
                                  return e.message;
                                }
                              }();
                            }
                          },
                          child: const Text('Submit'),
                        ),
                      ),
                    ],
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
