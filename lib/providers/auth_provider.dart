import 'package:flutter_firebaseauth/screens/models/app_user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

final authProvider = StreamProvider.autoDispose<AppUser?>((ref) async* {
  // create a stream provides continues values (user/null)
  final Stream<AppUser?> userStream = FirebaseAuth.instance
      .authStateChanges()
      .map((user) {
        if (user != null) {
          return AppUser(uid: user.uid, email: user.email!);
        }
        return null;
      });

  // YIELD that value whenever it changes
  await for (final user in userStream) {
    yield user;
  }
});
