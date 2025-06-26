import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:flame_id_app/core/error/failures/auth_api_failure.dart';
import 'package:flame_id_app/core/error/failures/auth_retryable_failure.dart';
import 'package:flame_id_app/core/error/failures/auth_session_failure.dart';
import 'package:flame_id_app/core/error/failures/auth_unknown_failure.dart';
import 'package:flame_id_app/core/error/failures/auth_weak_password_failure.dart';
import 'package:flame_id_app/core/error/failures/failure.dart';

class AuthFailure extends Failure {

  final String? code;
  final String? httpStatus;

  const AuthFailure({
    this.code,
    this.httpStatus,
    required super.title,
    required super.description,
    super.stackTrace
  });

  const AuthFailure.unknown({
    this.code, 
    this.httpStatus, 
    super.stackTrace
  })
      : super(
          title: 'Unbekannter Authentifizierungsfehler',
          description: 'Ein unbekannter Fehler bei der Authentifizierung ist aufgetreten'
        );

  static AuthFailure fromAuthException(AuthException e) {
    if (e is AuthApiException && e.statusCode != null) {
      final AuthFailure? failure = getBySupabaseCode(e.code);
      return failure?.copyWith(httpStatus: e.statusCode) ?? UnknownApiFailure(httpStatus: e.statusCode);
    }

    return switch (e) {
      AuthUnknownException() => const AuthUnknownFailure(),
      AuthWeakPasswordException() => const AuthWeakPasswordFailure(),
      AuthRetryableFetchException() => const AuthRetryableFailure(),
      AuthSessionMissingException() => const AuthSessionFailure(),
      _ => const AuthFailure.unknown()
    };
  }

  AuthFailure copyWith({
    String? code, 
    String? httpStatus, 
    String? title, 
    String? description, 
    StackTrace? stackTrace
  }) {
    return AuthFailure(
      code: code ?? this.code,
      httpStatus: httpStatus ?? this.httpStatus,
      title: title ?? this.title,
      description: description ?? this.description,
      stackTrace: stackTrace ?? this.stackTrace
    );
  }

  static AuthFailure? getBySupabaseCode(String? code) {
    return switch (code) {
      'anonymous_provider_disabled' => const AnonymousProviderDisabledFailure(),
      'bad_code_verifier' => const BadCodeVerifierFailure(),
      'bad_json' => const BadJsonFailure(),
      'bad_jwt' => const BadJwtFailure(),
      'bad_oauth_callback' => const BadOauthCallbackFailure(),
      'bad_oauth_state' => const BadOauthStateFailure(),
      'captcha_failed' => const CaptchaFailedFailure(),
      'conflict' => const ConflictFailure(),
      'email_address_invalid' => const EmailAddressInvalidFailure(),
      'email_address_not_authorized' => const EmailAddressNotAuthorizedFailure(),
      'email_conflict_identity_not_deletable' => const EmailConflictIdentityNotDeletableFailure(),
      'email_exists' => const EmailExistsFailure(),
      'email_not_confirmed' => const EmailNotConfirmedFailure(),
      'email_provider_disabled' => const EmailProviderDisabledFailure(),
      'flow_state_expired' => const FlowStateExpiredFailure(),
      'flow_state_not_found' => const FlowStateNotFoundFailure(),
      'hook_payload_invalid_content_type' => const HookPayloadInvalidContentTypeFailure(),
      'hook_payload_over_size_limit' => const HookPayloadOverSizeLimitFailure(),
      'hook_timeout' => const HookTimeoutFailure(),
      'hook_timeout_after_retry' => const HookTimeoutAfterRetryFailure(),
      'identity_already_exists' => const IdentityAlreadyExistsFailure(),
      'identity_not_found' => const IdentityNotFoundFailure(),
      'insufficient_aal' => const InsufficientAalFailure(),
      'invalid_credentials' => const InvalidCredentialsFailure(),
      'invite_not_found' => const InviteNotFoundFailure(),
      'manual_linking_disabled' => const ManualLinkingDisabledFailure(),
      'mfa_challenge_expired' => const MfaChallengeExpiredFailure(),
      'mfa_factor_name_conflict' => const MfaFactorNameConflictFailure(),
      'mfa_factor_not_found' => const MfaFactorNotFoundFailure(),
      'mfa_ip_address_mismatch' => const MfaIpAddressMismatchFailure(),
      'mfa_phone_enroll_not_enabled' => const MfaPhoneEnrollNotEnabledFailure(),
      'mfa_phone_verify_not_enabled' => const MfaPhoneVerifyNotEnabledFailure(),
      'mfa_totp_enroll_not_enabled' => const MfaTotpEnrollNotEnabledFailure(),
      'mfa_totp_verify_not_enabled' => const MfaTotpVerifyNotEnabledFailure(),
      'mfa_verification_failed' => const MfaVerificationFailedFailure(),
      'mfa_verification_rejected' => const MfaVerificationRejectedFailure(),
      'mfa_verified_factor_exists' => const MfaVerifiedFactorExistsFailure(),
      'mfa_web_authn_enroll_not_enabled' => const MfaWebAuthnEnrollNotEnabledFailure(),
      'mfa_web_authn_verify_not_enabled' => const MfaWebAuthnVerifyNotEnabledFailure(),
      'no_authorization' => const NoAuthorizationFailure(),
      'not_admin' => const NotAdminFailure(),
      'oauth_provider_not_supported' => const OauthProviderNotSupportedFailure(),
      'otp_disabled' => const OtpDisabledFailure(),
      'otp_expired' => const OtpExpiredFailure(),
      'over_email_send_rate_limit' => const OverEmailSendRateLimitFailure(),
      'over_request_rate_limit' => const OverRequestRateLimitFailure(),
      'over_sms_send_rate_limit' => const OverSmsSendRateLimitFailure(),
      'phone_exists' => const PhoneExistsFailure(),
      'phone_not_confirmed' => const PhoneNotConfirmedFailure(),
      'phone_provider_disabled' => const PhoneProviderDisabledFailure(),
      'provider_disabled' => const ProviderDisabledFailure(),
      'provider_email_needs_verification' => const ProviderEmailNeedsVerificationFailure(),
      'reauthentication_needed' => const ReauthenticationNeededFailure(),
      'reauthentication_not_valid' => const ReauthenticationNotValidFailure(),
      'refresh_token_already_used' => const RefreshTokenAlreadyUsedFailure(),
      'refresh_token_not_found' => const RefreshTokenNotFoundFailure(),
      'request_timeout' => const RequestTimeoutFailure(),
      'same_password' => const SamePasswordFailure(),
      'saml_assertion_no_email' => const SamlAssertionNoEmailFailure(),
      'saml_assertion_no_user_id' => const SamlAssertionNoUserIdFailure(),
      'saml_entity_id_mismatch' => const SamlEntityIdMismatchFailure(),
      'saml_idp_already_exists' => const SamlIdpAlreadyExistsFailure(),
      'saml_idp_not_found' => const SamlIdpNotFoundFailure(),
      'saml_metadata_fetch_failed' => const SamlMetadataFetchFailedFailure(),
      'saml_provider_disabled' => const SamlProviderDisabledFailure(),
      'saml_relay_state_expired' => const SamlRelayStateExpiredFailure(),
      'saml_relay_state_not_found' => const SamlRelayStateNotFoundFailure(),
      'session_not_found' => const SessionNotFoundFailure(),
      'signup_disabled' => const SignupDisabledFailure(),
      'single_identity_not_deletable' => const SingleIdentityNotDeletableFailure(),
      'sms_send_failed' => const SmsSendFailedFailure(),
      'sso_domain_already_exists' => const SsoDomainAlreadyExistsFailure(),
      'sso_provider_not_found' => const SsoProviderNotFoundFailure(),
      'too_many_enrolled_mfa_factors' => const TooManyEnrolledMfaFactorsFailure(),
      'unexpected_audience' => const UnexpectedAudienceFailure(),
      'unexpected_failure' => const UnexpectedFailureFailure(),
      'user_already_exists' => const UserAlreadyExistsFailure(),
      'user_banned' => const UserBannedFailure(),
      'user_not_found' => const UserNotFoundFailure(),
      'user_sso_managed' => const UserSsoManagedFailure(),
      'validation_failed' => const ValidationFailedFailure(),
      _ => null,
    };
  }
}