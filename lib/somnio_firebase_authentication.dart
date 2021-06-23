library somnio_firebase_authentication;

import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

import 'src/sign_in_services/apple/apple_sign_in_service.dart';
import 'src/sign_in_services/facebook/facebook_sign_in_service.dart';
// import 'src/sign_in_services/google/google_sign_in_service.dart';
import 'src/sign_in_services/sign_in_service.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

export 'src/sign_in_services/google/google_sign_in_service.dart';

part 'src/auth_service.dart';
part 'src/firebase_auth_service.dart';
