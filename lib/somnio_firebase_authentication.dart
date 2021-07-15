library somnio_firebase_authentication;

export 'src/sign_in_services/google/google_sign_in_service.dart';
export 'src/sign_in_services/facebook/facebook_sign_in_service.dart';
export 'src/sign_in_services/apple/apple_sign_in_service.dart';
export 'src/sign_in_services/apple/apple_credentials.dart';
export 'package:firebase_auth/firebase_auth.dart';
export 'src/auth_service.dart';
export 'src/firebase_auth_service.dart';

export 'src/exceptions/credentials/credentials.dart';
export 'src/exceptions/credentials/credentials_invalid_credential.dart';
export 'src/exceptions/credentials/credentials_operation_not_allowed.dart';
export 'src/exceptions/credentials/credentials_user_disabled.dart';
export 'src/exceptions/credentials/credentials_wrong_password.dart';

export 'src/exceptions/delete_account/delete_account.dart';
export 'src/exceptions/delete_account/delete_account_requires_recent_login.dart';

export 'src/exceptions/sign_in/sign_in.dart';
export 'src/exceptions/sign_in/sign_in_invalid_email.dart';
export 'src/exceptions/sign_in/sign_in_operation_not_allowed.dart';
export 'src/exceptions/sign_in/sign_in_user_disabled.dart';
export 'src/exceptions/sign_in/sign_in_user_not_found.dart';
export 'src/exceptions/sign_in/sign_in_wrong_password.dart';

export 'src/exceptions/sign_in_anonymously/anonymous_sign_in.dart';
export 'src/exceptions/sign_in_anonymously/anonymous_sign_in_operation_not_allowed.dart';

export 'src/exceptions/sign_up/sign_up.dart';
export 'src/exceptions/sign_up/sign_up_email_already_in_use.dart';
export 'src/exceptions/sign_up/sign_up_invalid_email.dart';
export 'src/exceptions/sign_up/sign_up_operation_not_allowed.dart';
export 'src/exceptions/sign_up/sign_up_weak_password.dart';

export 'src/exceptions/password_reset/password_reset.dart';
export 'src/exceptions/password_reset/password_reset_invalid_email.dart';
export 'src/exceptions/password_reset/password_reset_user_not_found.dart';

export 'src/exceptions/unexpected.dart';
