// Mocks generated by Mockito 5.0.12 from annotations
// in somnio_firebase_authentication/test/auth/sign_in_services/facebook_sign_in_service_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:flutter_facebook_auth/flutter_facebook_auth.dart' as _i3;
import 'package:flutter_facebook_auth_platform_interface/flutter_facebook_auth_platform_interface.dart'
    as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeLoginResult extends _i1.Fake implements _i2.LoginResult {}

class _FakeDateTime extends _i1.Fake implements DateTime {}

/// A class which mocks [FacebookAuth].
///
/// See the documentation for Mockito's code generation for more information.
class MockFacebookAuth extends _i1.Mock implements _i3.FacebookAuth {
  MockFacebookAuth() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.AccessToken?> get accessToken =>
      (super.noSuchMethod(Invocation.getter(#accessToken),
              returnValue: Future<_i2.AccessToken?>.value())
          as _i4.Future<_i2.AccessToken?>);
  @override
  _i4.Future<_i2.FacebookPermissions?> get permissions =>
      (super.noSuchMethod(Invocation.getter(#permissions),
              returnValue: Future<_i2.FacebookPermissions?>.value())
          as _i4.Future<_i2.FacebookPermissions?>);
  @override
  bool get isWebSdkInitialized =>
      (super.noSuchMethod(Invocation.getter(#isWebSdkInitialized),
          returnValue: false) as bool);
  @override
  _i4.Future<bool> get isAutoLogAppEventsEnabled =>
      (super.noSuchMethod(Invocation.getter(#isAutoLogAppEventsEnabled),
          returnValue: Future<bool>.value(false)) as _i4.Future<bool>);
  @override
  _i4.Future<_i2.LoginResult> expressLogin() =>
      (super.noSuchMethod(Invocation.method(#expressLogin, []),
              returnValue: Future<_i2.LoginResult>.value(_FakeLoginResult()))
          as _i4.Future<_i2.LoginResult>);
  @override
  _i4.Future<Map<String, dynamic>> getUserData(
          {String? fields = r'name,email,picture.width(200)'}) =>
      (super.noSuchMethod(
              Invocation.method(#getUserData, [], {#fields: fields}),
              returnValue:
                  Future<Map<String, dynamic>>.value(<String, dynamic>{}))
          as _i4.Future<Map<String, dynamic>>);
  @override
  _i4.Future<void> logOut() =>
      (super.noSuchMethod(Invocation.method(#logOut, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i4.Future<void>);
  @override
  _i4.Future<_i2.LoginResult> login(
          {List<String>? permissions = const [r'email', r'public_profile'],
          _i2.LoginBehavior? loginBehavior = _i2.LoginBehavior.dialogOnly}) =>
      (super.noSuchMethod(
              Invocation.method(#login, [],
                  {#permissions: permissions, #loginBehavior: loginBehavior}),
              returnValue: Future<_i2.LoginResult>.value(_FakeLoginResult()))
          as _i4.Future<_i2.LoginResult>);
  @override
  void webInitialize(
          {String? appId, bool? cookie, bool? xfbml, String? version}) =>
      super.noSuchMethod(
          Invocation.method(#webInitialize, [], {
            #appId: appId,
            #cookie: cookie,
            #xfbml: xfbml,
            #version: version
          }),
          returnValueForMissingStub: null);
  @override
  _i4.Future<void> autoLogAppEventsEnabled(bool? enabled) => (super
      .noSuchMethod(Invocation.method(#autoLogAppEventsEnabled, [enabled]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i4.Future<void>);
}

/// A class which mocks [LoginResult].
///
/// See the documentation for Mockito's code generation for more information.
class MockLoginResult extends _i1.Mock implements _i2.LoginResult {
  MockLoginResult() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.LoginStatus get status => (super.noSuchMethod(Invocation.getter(#status),
      returnValue: _i2.LoginStatus.success) as _i2.LoginStatus);
}

/// A class which mocks [AccessToken].
///
/// See the documentation for Mockito's code generation for more information.
class MockAccessToken extends _i1.Mock implements _i2.AccessToken {
  MockAccessToken() {
    _i1.throwOnMissingStub(this);
  }

  @override
  DateTime get expires => (super.noSuchMethod(Invocation.getter(#expires),
      returnValue: _FakeDateTime()) as DateTime);
  @override
  DateTime get lastRefresh =>
      (super.noSuchMethod(Invocation.getter(#lastRefresh),
          returnValue: _FakeDateTime()) as DateTime);
  @override
  String get userId =>
      (super.noSuchMethod(Invocation.getter(#userId), returnValue: '')
          as String);
  @override
  String get token =>
      (super.noSuchMethod(Invocation.getter(#token), returnValue: '')
          as String);
  @override
  String get applicationId =>
      (super.noSuchMethod(Invocation.getter(#applicationId), returnValue: '')
          as String);
  @override
  bool get isExpired =>
      (super.noSuchMethod(Invocation.getter(#isExpired), returnValue: false)
          as bool);
  @override
  Map<String, dynamic> toJson() =>
      (super.noSuchMethod(Invocation.method(#toJson, []),
          returnValue: <String, dynamic>{}) as Map<String, dynamic>);
}
