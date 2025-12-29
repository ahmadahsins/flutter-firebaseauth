import 'package:flutter/material.dart';
import 'package:flutter_firebaseauth/screens/services/auth_service.dart';
import 'package:flutter_firebaseauth/shared/styled_text.dart';
import 'package:flutter_firebaseauth/shared/styled_button.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
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
            const Center(child: StyledBodyText('Sign in to your account')),
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
                return null;
              },
            ),

            // error feedback
            if (_errorFeedback != null)
              Text(_errorFeedback!, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 16),

            // submit button
            StyledButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  final email = _emailController.text.trim();
                  final password = _passwordController.text.trim();

                  final user = await AuthService.signIn(email, password);

                  // error feedback here later
                  if (user == null) {
                    setState(() {
                      _errorFeedback = 'Incorrect login credentials.';
                    });
                  }
                }
              },
              child: StyledButtonText('Sign In'),
            ),
          ],
        ),
      ),
    );
  }
}
