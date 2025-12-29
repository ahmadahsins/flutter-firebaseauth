import 'package:flutter/material.dart';
import 'package:flutter_firebaseauth/providers/auth_provider.dart';
import 'package:flutter_firebaseauth/screens/models/app_user.dart';
import 'package:flutter_firebaseauth/screens/profile/profile.dart';
import 'package:flutter_firebaseauth/screens/welcome/welcome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Consumer(
        builder: (context, ref, child) {
          final AsyncValue<AppUser?> user = ref.watch(authProvider);

          return user.when(
            data: (user) {
              if (user == null) {
                return const WelcomeScreen();
              }
              return ProfileScreen(user: user);
            },
            error: (error, _) => const Text('error loading auth status.'),
            loading: () => const Text('loading...'),
          );
        },
      ),
    );
  }
}
