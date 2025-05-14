import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Expose current user
  User? get currentUser => _auth.currentUser;

  // Listen to auth state changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Sign Up
  Future<UserCredential> signUp({
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      // Check if username is already taken
      final existingUser = await _firestore
          .collection('users')
          .where('username', isEqualTo: username)
          .limit(1)
          .get();

      if (existingUser.docs.isNotEmpty) {
        throw Exception('Username is already taken');
      }

      // Create Firebase Auth user
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Create Firestore user profile
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
        'username': username,
      });

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      rethrow;
    }
  }

  // Sign In (with email or username)
  Future<UserCredential> signIn({
    required String emailOrUsername,
    required String password,
  }) async {
    try {
      String email = emailOrUsername;

      // If input is not an email, treat it as username
      if (!email.contains('@')) {
        final result = await _firestore
            .collection('users')
            .where('username', isEqualTo: emailOrUsername)
            .limit(1)
            .get();

        if (result.docs.isEmpty) {
          throw Exception('Username not found. Try using your email.');
        }

        email = result.docs.first['email'];
      }

      // Sign in with resolved email
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      rethrow;
    }
  }

  // Sign Out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Reset Password
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  // Handle Firebase Auth exceptions
  Exception _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return Exception('No user found for that email.');
      case 'wrong-password':
        return Exception('Incorrect password.');
      case 'email-already-in-use':
        return Exception('Email is already in use.');
      case 'invalid-email':
        return Exception('Invalid email format.');
      case 'weak-password':
        return Exception('Password is too weak.');
      case 'network-request-failed':
        return Exception('Network error. Check your internet connection.');
      default:
        return Exception('Auth error: ${e.message}');
    }
  }
}