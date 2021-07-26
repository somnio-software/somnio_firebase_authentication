import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mockito/annotations.dart';
import 'package:somnio_firebase_authentication/somnio_firebase_authentication.dart';
import 'auth_test.mocks.dart';
import 'firebase_mock.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_auth/firebase_auth.dart' as Auth;

@GenerateMocks([
  FirebaseAuth,
  GoogleSignIn,
  UserCredential,
  Auth.User,
  GoogleSignInService,
  FacebookSignInService,
  AppleSignInService,
])
void main() async {
  setupFirebaseAuthMocks();
  TestWidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final auth = MockFirebaseAuth();
  final googleSignIn = MockGoogleSignIn();
  final userCredential = MockUserCredential();
  Auth.User? firebaseUser;

  setUp(() {
    firebaseUser = MockUser();
    when(firebaseUser!.displayName).thenReturn('testName testLastName');
    when(firebaseUser!.uid).thenReturn('1');
    when(firebaseUser!.email).thenReturn('testEmail');
    when(firebaseUser!.photoURL).thenReturn('assets/somnio_logo.png');
    when(firebaseUser!.isAnonymous).thenReturn(false);
    when(userCredential.user).thenReturn(firebaseUser);
  });

  group('Firebase auth /', () {
    test('Sign in with email and password', () async {
      final authService = FirebaseAuthService(firebaseAuth: auth);

      when(
        auth.signInWithEmailAndPassword(email: 'email', password: 'password'),
      ).thenAnswer((_) async => userCredential);

      final obtainedUser =
          await authService.signInWithEmailAndPassword('email', 'password');

      expect(firebaseUser, obtainedUser);
    });

    test('Current user', () async {
      final authService = FirebaseAuthService(firebaseAuth: auth);

      when(auth.currentUser).thenAnswer((_) => firebaseUser);

      final obtainedUser = await authService.currentUser();

      expect(firebaseUser, obtainedUser);
    });

    test('Anonymous sign in', () async {
      final authService = FirebaseAuthService(firebaseAuth: auth);

      when(auth.signInAnonymously()).thenAnswer((_) async => userCredential);

      final obtainedUser = await authService.signInAnonymously();

      expect(firebaseUser, obtainedUser);
    });

    test('Change profile', () async {
      final authService = FirebaseAuthService(firebaseAuth: auth);
      final user = MockUser();

      when(auth.currentUser).thenAnswer((_) => user);

      when(user.updateDisplayName('A Test')).thenAnswer((_) async => null);
      when(user.updatePhotoURL('URL')).thenAnswer((_) async => null);

      final changedProfile = await authService.changeProfile(
          firstName: 'A', lastName: 'Test', photoURL: 'URL');

      expect(changedProfile, true);
    });

    test('Delete account', () async {
      final authService = FirebaseAuthService(firebaseAuth: auth);
      final user = MockUser();

      when(user.delete()).thenAnswer((_) async => null);

      final success = await authService.deleteAccount();

      expect(success, true);
    });
  });

  group('Google Sign in /', () {
    test('Success', () async {
      final _googleSignInService = MockGoogleSignInService();
      final authService = FirebaseAuthService(
          firebaseAuth: auth, testingService: _googleSignInService);
      final credential = Auth.GoogleAuthProvider.credential(
        idToken: 'abcd1234',
        accessToken: 'abcd1234',
      );

      when(_googleSignInService.getFirebaseCredential())
          .thenAnswer((_) async => credential);

      when(auth.signInWithCredential(credential))
          .thenAnswer((_) async => userCredential);

      final obtainedUser = await authService.signInWithGoogle();

      expect(firebaseUser, obtainedUser);
    });

    test('Cancelled by user', () async {
      final authService = FirebaseAuthService(firebaseAuth: auth);
      when(googleSignIn.signIn()).thenAnswer((_) async => null);

      expect(
          await authService.signInWithGoogle(googleLogin: googleSignIn), null);
    });
  });

  group('Facebook sign in /', () {
    test('Success', () async {
      final _facebookSignInService = MockFacebookSignInService();
      final authService = FirebaseAuthService(
          firebaseAuth: auth, testingService: _facebookSignInService);

      final credential = Auth.FacebookAuthProvider.credential('abcd1234');

      when(_facebookSignInService.getFirebaseCredential())
          .thenAnswer((_) async => credential);

      when(auth.signInWithCredential(credential))
          .thenAnswer((_) async => userCredential);

      final obtainedUser = await authService.signInWithFacebook();

      expect(firebaseUser, obtainedUser);
    });

    test('Cancelled by user', () async {
      final _facebookSignInService = MockFacebookSignInService();
      final authService = FirebaseAuthService(
          firebaseAuth: auth, testingService: _facebookSignInService);

      when(_facebookSignInService.getFirebaseCredential())
          .thenAnswer((_) async => null);

      expect(await authService.signInWithFacebook(), null);
    });
  });

  group('Apple sign in /', () {
    test('Success', () async {
      final _appleSignInService = MockAppleSignInService();
      final authService = FirebaseAuthService(
          firebaseAuth: auth, testingService: _appleSignInService);

      final credential = Auth.OAuthProvider('apple.com').credential(
        idToken: 'abcd1234',
        rawNonce: 'abcd1234',
      );

      when(_appleSignInService.getFirebaseCredential())
          .thenAnswer((_) async => credential);

      when(auth.signInWithCredential(credential))
          .thenAnswer((_) async => userCredential);

      final obtainedUser = await authService.signInWithApple();

      expect(firebaseUser, obtainedUser);
    });

    test('Cancelled by user', () async {
      final _appleSignInService = MockAppleSignInService();
      final authService = FirebaseAuthService(
          firebaseAuth: auth, testingService: _appleSignInService);

      when(_appleSignInService.getFirebaseCredential())
          .thenAnswer((_) async => null);

      expect(await authService.signInWithApple(), null);
    });
  });
}
