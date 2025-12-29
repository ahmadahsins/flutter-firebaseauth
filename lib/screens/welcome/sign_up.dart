import 'package:flutter/material.dart';
import 'package:flutter_firebaseauth/screens/services/auth_service.dart';
import 'package:flutter_firebaseauth/shared/styled_text.dart';
import 'package:flutter_firebaseauth/shared/styled_button.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _errorFeedback;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // intro text
            const Center(child: StyledBodyText('Sign up for a new account')),
            const SizedBox(height: 16),

            // email address
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(labelText: 'Email'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
            ),

            // password
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                if (value.length < 8) {
                  return 'Password must be at least 8 chars long';
                }
                return null;
              },
            ),

            // error feedback
            if (_errorFeedback == null)
              Text(_errorFeedback!, style: TextStyle(color: Colors.red)),
            const SizedBox(height: 16),

            // submit button
            StyledButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  final email = _emailController.text.trim();
                  final password = _passwordController.text.trim();

                  final user = await AuthService.signUp(email, password);

                  if (user == null) {
                    setState(() {
                      _errorFeedback = 'Could not sign up with those details.';
                    });
                  }
                }
              },
              child: StyledButtonText('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
