import 'package:flame_id_app/core/error/failures/auth_failure.dart';

abstract class AuthApiFailure extends AuthFailure {

  const AuthApiFailure({
    required super.title,
    required super.description,
    super.code,
    super.httpStatus,
    super.stackTrace
  });
}

class UnknownApiFailure extends AuthApiFailure {

  const UnknownApiFailure({
    super.code, 
    super.httpStatus, 
    super.stackTrace
  })
      : super(
          title: 'Unbekannter API-Fehler',
          description: 'Ein unbekannter Fehler von der Authentifizierungs-API ist aufgetreten.'
        );
}

class AnonymousProviderDisabledFailure extends AuthApiFailure {
  const AnonymousProviderDisabledFailure()
      : super(
          code: 'anonymous_provider_disabled',
          httpStatus: '403',
          title: 'Anonyme Anmeldung deaktiviert',
          description: 'Anonyme Anmeldungen sind auf diesem Server deaktiviert.',
        );
}

class BadCodeVerifierFailure extends AuthApiFailure {
  const BadCodeVerifierFailure()
      : super(
          code: 'bad_code_verifier',
          httpStatus: '400',
          title: 'Ungültiger Code-Verifier',
          description: 'Der angegebene Code-Verifier stimmt nicht mit dem erwarteten überein. Bitte überprüfe deine Client-Implementierung.'
        );
}

class BadJsonFailure extends AuthApiFailure {
  const BadJsonFailure()
      : super(
          code: 'bad_json',
          httpStatus: '400',
          title: 'Ungültiges JSON',
          description: 'Der HTTP-Anfragekörper enthält kein gültiges JSON-Format.'
        );
}

class BadJwtFailure extends AuthApiFailure {
  const BadJwtFailure()
      : super(
          code: 'bad_jwt',
          httpStatus: '401',
          title: 'Ungültiger JWT',
          description: 'Der im Authorization-Header gesendete JWT ist ungültig.'
        );
}

class BadOauthCallbackFailure extends AuthApiFailure {
  const BadOauthCallbackFailure()
      : super(
          code: 'bad_oauth_callback',
          httpStatus: '400',
          title: 'Ungültiger OAuth-Callback',
          description: 'Der OAuth-Callback vom Anbieter enthält nicht alle erforderlichen Attribute.'
        );
}

class BadOauthStateFailure extends AuthApiFailure {
  const BadOauthStateFailure()
      : super(
          code: 'bad_oauth_state',
          httpStatus: '400',
          title: 'Ungültiger OAuth-Status',
          description: 'Der OAuth-Status ist nicht im korrekten Format. Bitte überprüfe die Integration des OAuth-Anbieters.'
        );
}

class CaptchaFailedFailure extends AuthApiFailure {
  const CaptchaFailedFailure()
      : super(
          code: 'captcha_failed',
          httpStatus: '400',
          title: 'CAPTCHA-Fehler',
          description: 'Die CAPTCHA-Überprüfung konnte nicht erfolgreich abgeschlossen werden. Bitte überprüfe deine CAPTCHA-Integration.'
        );
}

class ConflictFailure extends AuthApiFailure {
  const ConflictFailure()
      : super(
          code: 'conflict',
          httpStatus: '409',
          title: 'Datenbankkonflikt',
          description: 'Ein Datenbankkonflikt ist aufgetreten, möglicherweise durch gleichzeitige Anfragen.'
        );
}

class EmailAddressInvalidFailure extends AuthApiFailure {
  const EmailAddressInvalidFailure()
      : super(
          code: 'email_address_invalid',
          httpStatus: '400',
          title: 'Ungültige E-Mail-Adresse',
          description: 'Beispiel- oder Testdomains werden nicht unterstützt. Bitte verwende eine andere E-Mail-Adresse.'
        );
}

class EmailAddressNotAuthorizedFailure extends AuthApiFailure {
  const EmailAddressNotAuthorizedFailure()
      : super(
          code: 'email_address_not_authorized',
          httpStatus: '403',
          title: 'E-Mail-Versand nicht autorisiert',
          description: 'Der E-Mail-Versand ist für diese Adresse nicht erlaubt. Richte einen benutzerdefinierten SMTP-Anbieter ein.'
        );
}

class EmailConflictIdentityNotDeletableFailure extends AuthApiFailure {
  const EmailConflictIdentityNotDeletableFailure()
      : super(
          code: 'email_conflict_identity_not_deletable',
          httpStatus: '409',
          title: 'E-Mail-Konflikt',
          description: 'Das Entfernen dieser Identität würde zu einem E-Mail-Konflikt führen. Bitte migriere die Benutzerdaten zu einem Konto.'
        );
}

class EmailExistsFailure extends AuthApiFailure {
  const EmailExistsFailure()
      : super(
          code: 'email_exists',
          httpStatus: '400',
          title: 'E-Mail bereits vorhanden',
          description: 'Die E-Mail-Adresse existiert bereits im System.'
        );
}

class EmailNotConfirmedFailure extends AuthApiFailure {
  const EmailNotConfirmedFailure()
      : super(
          code: 'email_not_confirmed',
          httpStatus: '403',
          title: 'E-Mail nicht bestätigt',
          description: 'Die Anmeldung ist nicht möglich, da die E-Mail-Adresse nicht bestätigt wurde.'
        );
}

class EmailProviderDisabledFailure extends AuthApiFailure {
  const EmailProviderDisabledFailure()
      : super(
          code: 'email_provider_disabled',
          httpStatus: '501',
          title: 'E-Mail-Anmeldung deaktiviert',
          description: 'Anmeldungen mit E-Mail und Passwort sind deaktiviert.'
        );
}

class FlowStateExpiredFailure extends AuthApiFailure {
  const FlowStateExpiredFailure()
      : super(
          code: 'flow_state_expired',
          httpStatus: '400',
          title: 'PKCE-Flow abgelaufen',
          description: 'Der PKCE-Flow-Status ist abgelaufen. Bitte melde dich erneut an.'
        );
}

class FlowStateNotFoundFailure extends AuthApiFailure {
  const FlowStateNotFoundFailure()
      : super(
          code: 'flow_state_not_found',
          httpStatus: '404',
          title: 'PKCE-Flow nicht gefunden',
          description: 'Der PKCE-Flow-Status existiert nicht mehr. Bitte melde dich erneut an.'
        );
}

class HookPayloadInvalidContentTypeFailure extends AuthApiFailure {
  const HookPayloadInvalidContentTypeFailure()
      : super(
          code: 'hook_payload_invalid_content_type',
          httpStatus: '400',
          title: 'Ungültiger Hook-Content-Type',
          description: 'Die Payload vom Auth-Server hat keinen gültigen Content-Type-Header.'
        );
}

class HookPayloadOverSizeLimitFailure extends AuthApiFailure {
  const HookPayloadOverSizeLimitFailure()
      : super(
          code: 'hook_payload_over_size_limit',
          httpStatus: '413',
          title: 'Hook-Payload zu groß',
          description: 'Die Payload vom Auth-Server überschreitet die maximale Größenbeschränkung.'
        );
}

class HookTimeoutFailure extends AuthApiFailure {
  const HookTimeoutFailure()
      : super(
          code: 'hook_timeout',
          httpStatus: '504',
          title: 'Hook-Timeout',
          description: 'Der Hook konnte innerhalb der maximalen Zeit nicht erreicht werden.'
        );
}

class HookTimeoutAfterRetryFailure extends AuthApiFailure {
  const HookTimeoutAfterRetryFailure()
      : super(
          code: 'hook_timeout_after_retry',
          httpStatus: '504',
          title: 'Hook-Timeout nach Wiederholung',
          description: 'Der Hook konnte nach maximaler Anzahl an Wiederholungen nicht erreicht werden.'
        );
}

class IdentityAlreadyExistsFailure extends AuthApiFailure {
  const IdentityAlreadyExistsFailure()
      : super(
          code: 'identity_already_exists',
          httpStatus: '409',
          title: 'Identität bereits vorhanden',
          description: 'Die Identität ist bereits mit einem Benutzer verknüpft.'
        );
}

class IdentityNotFoundFailure extends AuthApiFailure {
  const IdentityNotFoundFailure()
      : super(
          code: 'identity_not_found',
          httpStatus: '404',
          title: 'Identität nicht gefunden',
          description: 'Die Identität, auf die sich die API-Anfrage bezieht, existiert nicht.'
        );
}

class InsufficientAalFailure extends AuthApiFailure {
  const InsufficientAalFailure()
      : super(
          code: 'insufficient_aal',
          httpStatus: '403',
          title: 'Unzureichendes Authentifizierungsniveau',
          description: 'Der Benutzer muss ein höheres Authentifizierungsniveau haben. Bitte löse eine MFA-Herausforderung.'
        );
}

class InvalidCredentialsFailure extends AuthApiFailure {
  const InvalidCredentialsFailure()
      : super(
          code: 'invalid_credentials',
          httpStatus: '401',
          title: 'Ungültige Zugangsdaten',
          description: 'Die Anmeldedaten oder der Grant-Typ wurden nicht erkannt.'
        );
}

class InviteNotFoundFailure extends AuthApiFailure {
  const InviteNotFoundFailure()
      : super(
          code: 'invite_not_found',
          httpStatus: '404',
          title: 'Einladung nicht gefunden',
          description: 'Die Einladung ist abgelaufen oder wurde bereits verwendet.'
        );
}

class ManualLinkingDisabledFailure extends AuthApiFailure {
  const ManualLinkingDisabledFailure()
      : super(
          code: 'manual_linking_disabled',
          httpStatus: '501',
          title: 'Manuelles Verknüpfen deaktiviert',
          description: 'Das manuelle Verknüpfen von Identitäten ist auf dem Auth-Server deaktiviert.'
        );
}

class MfaChallengeExpiredFailure extends AuthApiFailure {
  const MfaChallengeExpiredFailure()
      : super(
          code: 'mfa_challenge_expired',
          httpStatus: '400',
          title: 'MFA-Herausforderung abgelaufen',
          description: 'Die MFA-Herausforderung ist abgelaufen. Bitte fordere eine neue Herausforderung an.'
        );
}

class MfaFactorNameConflictFailure extends AuthApiFailure {
  const MfaFactorNameConflictFailure()
      : super(
          code: 'mfa_factor_name_conflict',
          httpStatus: '409',
          title: 'MFA-Faktorname-Konflikt',
          description: 'MFA-Faktoren eines Benutzers dürfen nicht denselben Namen haben.'
        );
}

class MfaFactorNotFoundFailure extends AuthApiFailure {
  const MfaFactorNotFoundFailure()
      : super(
          code: 'mfa_factor_not_found',
          httpStatus: '404',
          title: 'MFA-Faktor nicht gefunden',
          description: 'Der MFA-Faktor existiert nicht mehr.'
        );
}

class MfaIpAddressMismatchFailure extends AuthApiFailure {
  const MfaIpAddressMismatchFailure()
      : super(
          code: 'mfa_ip_address_mismatch',
          httpStatus: '400',
          title: 'MFA-IP-Adressen-Konflikt',
          description: 'Der MFA-Registrierungsprozess muss mit derselben IP-Adresse begonnen und beendet werden.'
        );
}

class MfaPhoneEnrollNotEnabledFailure extends AuthApiFailure {
  const MfaPhoneEnrollNotEnabledFailure()
      : super(
          code: 'mfa_phone_enroll_not_enabled',
          httpStatus: '501',
          title: 'MFA-Telefonregistrierung deaktiviert',
          description: 'Die Registrierung von MFA-Telefonfaktoren ist deaktiviert.'
        );
}

class MfaPhoneVerifyNotEnabledFailure extends AuthApiFailure {
  const MfaPhoneVerifyNotEnabledFailure()
      : super(
          code: 'mfa_phone_verify_not_enabled',
          httpStatus: '501',
          title: 'MFA-Telefonverifizierung deaktiviert',
          description: 'Die Verifizierung von MFA-Telefonfaktoren ist deaktiviert.'
        );
}

class MfaTotpEnrollNotEnabledFailure extends AuthApiFailure {
  const MfaTotpEnrollNotEnabledFailure()
      : super(
          code: 'mfa_totp_enroll_not_enabled',
          httpStatus: '501',
          title: 'MFA-TOTP-Registrierung deaktiviert',
          description: 'Die Registrierung von MFA-TOTP-Faktoren ist deaktiviert.'
        );
}

class MfaTotpVerifyNotEnabledFailure extends AuthApiFailure {
  const MfaTotpVerifyNotEnabledFailure()
      : super(
          code: 'mfa_totp_verify_not_enabled',
          httpStatus: '501',
          title: 'MFA-TOTP-Verifizierung deaktiviert',
          description: 'Die Verifizierung von MFA-TOTP-Faktoren ist deaktiviert.'
        );
}

class MfaVerificationFailedFailure extends AuthApiFailure {
  const MfaVerificationFailedFailure()
      : super(
          code: 'mfa_verification_failed',
          httpStatus: '400',
          title: 'MFA-Verifizierung fehlgeschlagen',
          description: 'Die MFA-Herausforderung konnte nicht verifiziert werden. Falscher TOTP-Code.'
        );
}

class MfaVerificationRejectedFailure extends AuthApiFailure {
  const MfaVerificationRejectedFailure()
      : super(
          code: 'mfa_verification_rejected',
          httpStatus: '400',
          title: 'MFA-Verifizierung abgelehnt',
          description: 'Die MFA-Verifizierung wurde abgelehnt. Überprüfe den MFA-Verifizierungs-Hook.'
        );
}

class MfaVerifiedFactorExistsFailure extends AuthApiFailure {
  const MfaVerifiedFactorExistsFailure()
      : super(
          code: 'mfa_verified_factor_exists',
          httpStatus: '409',
          title: 'Verifizierter MFA-Faktor vorhanden',
          description: 'Ein verifizierter Telefonfaktor existiert bereits. Entferne den bestehenden Faktor.'
        );
}

class MfaWebAuthnEnrollNotEnabledFailure extends AuthApiFailure {
  const MfaWebAuthnEnrollNotEnabledFailure()
      : super(
          code: 'mfa_web_authn_enroll_not_enabled',
          httpStatus: '501',
          title: 'MFA-WebAuthn-Registrierung deaktiviert',
          description: 'Die Registrierung von MFA-WebAuthn-Faktoren ist deaktiviert.'
        );
}

class MfaWebAuthnVerifyNotEnabledFailure extends AuthApiFailure {
  const MfaWebAuthnVerifyNotEnabledFailure()
      : super(
          code: 'mfa_web_authn_verify_not_enabled',
          httpStatus: '501',
          title: 'MFA-WebAuthn-Verifizierung deaktiviert',
          description: 'Die Verifizierung von MFA-WebAuthn-Faktoren ist deaktiviert.'
        );
}

class NoAuthorizationFailure extends AuthApiFailure {
  const NoAuthorizationFailure()
      : super(
          code: 'no_authorization',
          httpStatus: '401',
          title: 'Keine Autorisierung',
          description: 'Die HTTP-Anfrage erfordert einen Authorization-Header, der nicht bereitgestellt wurde.'
        );
}

class NotAdminFailure extends AuthApiFailure {
  const NotAdminFailure()
      : super(
          code: 'not_admin',
          httpStatus: '403',
          title: 'Kein Admin',
          description: 'Der Benutzer ist kein Admin und hat keine ausreichenden Berechtigungen.'
        );
}

class OauthProviderNotSupportedFailure extends AuthApiFailure {
  const OauthProviderNotSupportedFailure()
      : super(
          code: 'oauth_provider_not_supported',
          httpStatus: '501',
          title: 'OAuth-Anbieter nicht unterstützt',
          description: 'Der verwendete OAuth-Anbieter ist auf dem Auth-Server deaktiviert.'
        );
}

class OtpDisabledFailure extends AuthApiFailure {
  const OtpDisabledFailure()
      : super(
          code: 'otp_disabled',
          httpStatus: '501',
          title: 'OTP-Anmeldung deaktiviert',
          description: 'Die Anmeldung mit OTP (Magic Link, E-Mail-OTP) ist deaktiviert.'
        );
}

class OtpExpiredFailure extends AuthApiFailure {
  const OtpExpiredFailure()
      : super(
          code: 'otp_expired',
          httpStatus: '400',
          title: 'OTP abgelaufen',
          description: 'Der OTP-Code für diese Anmeldung ist abgelaufen. Bitte melde dich erneut an.'
        );
}

class OverEmailSendRateLimitFailure extends AuthApiFailure {
  const OverEmailSendRateLimitFailure()
      : super(
          code: 'over_email_send_rate_limit',
          httpStatus: '429',
          title: 'E-Mail-Ratenbegrenzung überschritten',
          description: 'Zu viele E-Mails wurden an diese Adresse gesendet. Bitte warte eine Weile.'
        );
}

class OverRequestRateLimitFailure extends AuthApiFailure {
  const OverRequestRateLimitFailure()
      : super(
          code: 'over_request_rate_limit',
          httpStatus: '429',
          title: 'Anfrageratenbegrenzung überschritten',
          description: 'Zu viele Anfragen von dieser IP-Adresse. Bitte versuche es in ein paar Minuten erneut.'
        );
}

class OverSmsSendRateLimitFailure extends AuthApiFailure {
  const OverSmsSendRateLimitFailure()
      : super(
          code: 'over_sms_send_rate_limit',
          httpStatus: '429',
          title: 'SMS-Ratenbegrenzung überschritten',
          description: 'Zu viele SMS wurden an diese Nummer gesendet. Bitte warte eine Weile.'
        );
}

class PhoneExistsFailure extends AuthApiFailure {
  const PhoneExistsFailure()
      : super(
          code: 'phone_exists',
          httpStatus: '400',
          title: 'Telefonnummer bereits vorhanden',
          description: 'Die Telefonnummer existiert bereits im System.'
        );
}

class PhoneNotConfirmedFailure extends AuthApiFailure {
  const PhoneNotConfirmedFailure()
      : super(
          code: 'phone_not_confirmed',
          httpStatus: '403',
          title: 'Telefonnummer nicht bestätigt',
          description: 'Die Anmeldung ist nicht möglich, da die Telefonnummer nicht bestätigt wurde.'
        );
}

class PhoneProviderDisabledFailure extends AuthApiFailure {
  const PhoneProviderDisabledFailure()
      : super(
          code: 'phone_provider_disabled',
          httpStatus: '501',
          title: 'Telefonanmeldung deaktiviert',
          description: 'Anmeldungen mit Telefonnummer und Passwort sind deaktiviert.'
        );
}

class ProviderDisabledFailure extends AuthApiFailure {
  const ProviderDisabledFailure()
      : super(
          code: 'provider_disabled',
          httpStatus: '501',
          title: 'Anbieter deaktiviert',
          description: 'Der OAuth-Anbieter ist für die Nutzung deaktiviert. Überprüfe die Serverkonfiguration.'
        );
}

class ProviderEmailNeedsVerificationFailure extends AuthApiFailure {
  const ProviderEmailNeedsVerificationFailure()
      : super(
          code: 'provider_email_needs_verification',
          httpStatus: '403',
          title: 'E-Mail-Verifizierung erforderlich',
          description: 'Die E-Mail-Adresse des OAuth-Anbieters muss verifiziert werden.'
        );
}

class ReauthenticationNeededFailure extends AuthApiFailure {
  const ReauthenticationNeededFailure()
      : super(
          code: 'reauthentication_needed',
          httpStatus: '403',
          title: 'Neuauthentifizierung erforderlich',
          description: 'Der Benutzer muss sich erneut authentifizieren, um das Passwort zu ändern.'
        );
}

class ReauthenticationNotValidFailure extends AuthApiFailure {
  const ReauthenticationNotValidFailure()
      : super(
          code: 'reauthentication_not_valid',
          httpStatus: '400',
          title: 'Ungültige Neuauthentifizierung',
          description: 'Die Verifizierung der Neuauthentifizierung ist fehlgeschlagen. Bitte gib einen neuen Code ein.'
        );
}

class RefreshTokenAlreadyUsedFailure extends AuthApiFailure {
  const RefreshTokenAlreadyUsedFailure()
      : super(
          code: 'refresh_token_already_used',
          httpStatus: '401',
          title: 'Refresh-Token bereits verwendet',
          description: 'Der Refresh-Token wurde widerrufen und liegt außerhalb des Wiederverwendungsintervalls.'
        );
}

class RefreshTokenNotFoundFailure extends AuthApiFailure {
  const RefreshTokenNotFoundFailure()
      : super(
          code: 'refresh_token_not_found',
          httpStatus: '404',
          title: 'Refresh-Token nicht gefunden',
          description: 'Die Sitzung mit dem Refresh-Token wurde nicht gefunden.'
        );
}

class RequestTimeoutFailure extends AuthApiFailure {
  const RequestTimeoutFailure()
      : super(
          code: 'request_timeout',
          httpStatus: '504',
          title: 'Anfrage-Timeout',
          description: 'Die Verarbeitung der Anfrage hat zu lange gedauert. Bitte versuche es erneut.'
        );
}

class SamePasswordFailure extends AuthApiFailure {
  const SamePasswordFailure()
      : super(
          code: 'same_password',
          httpStatus: '400',
          title: 'Gleiches Passwort',
          description: 'Das neue Passwort muss sich vom aktuellen Passwort unterscheiden.'
        );
}

class SamlAssertionNoEmailFailure extends AuthApiFailure {
  const SamlAssertionNoEmailFailure()
      : super(
          code: 'saml_assertion_no_email',
          httpStatus: '400',
          title: 'Kein E-Mail in SAML-Assertion',
          description: 'Die SAML-Assertion enthält keine E-Mail-Adresse, die erforderlich ist.'
        );
}

class SamlAssertionNoUserIdFailure extends AuthApiFailure {
  const SamlAssertionNoUserIdFailure()
      : super(
          code: 'saml_assertion_no_user_id',
          httpStatus: '400',
          title: 'Kein Benutzer-ID in SAML-Assertion',
          description: 'Die SAML-Assertion enthält keine Benutzer-ID (NameID), die erforderlich ist.'
        );
}

class SamlEntityIdMismatchFailure extends AuthApiFailure {
  const SamlEntityIdMismatchFailure()
      : super(
          code: 'saml_entity_id_mismatch',
          httpStatus: '409',
          title: 'SAML-Entity-ID-Konflikt',
          description: 'Die Entity-ID im Update stimmt nicht mit der in der Datenbank überein.'
        );
}

class SamlIdpAlreadyExistsFailure extends AuthApiFailure {
  const SamlIdpAlreadyExistsFailure()
      : super(
          code: 'saml_idp_already_exists',
          httpStatus: '409',
          title: 'SAML-Anbieter bereits vorhanden',
          description: 'Der SAML-Anbieter wurde bereits hinzugefügt.'
        );
}

class SamlIdpNotFoundFailure extends AuthApiFailure {
  const SamlIdpNotFoundFailure()
      : super(
          code: 'saml_idp_not_found',
          httpStatus: '404',
          title: 'SAML-Anbieter nicht gefunden',
          description: 'Der SAML-Anbieter wurde nicht gefunden. Überprüfe die Anbieterkonfiguration.'
        );
}

class SamlMetadataFetchFailedFailure extends AuthApiFailure {
  const SamlMetadataFetchFailedFailure()
      : super(
          code: 'saml_metadata_fetch_failed',
          httpStatus: '500',
          title: 'SAML-Metadatenabruf fehlgeschlagen',
          description: 'Die Metadaten des SAML-Anbieters konnten nicht abgerufen werden.'
        );
}

class SamlProviderDisabledFailure extends AuthApiFailure {
  const SamlProviderDisabledFailure()
      : super(
          code: 'saml_provider_disabled',
          httpStatus: '501',
          title: 'SAML-Anbieter deaktiviert',
          description: 'Die Nutzung von Enterprise SSO mit SAML 2.0 ist auf dem Auth-Server deaktiviert.'
        );
}

class SamlRelayStateExpiredFailure extends AuthApiFailure {
  const SamlRelayStateExpiredFailure()
      : super(
          code: 'saml_relay_state_expired',
          httpStatus: '400',
          title: 'SAML-Relay-State abgelaufen',
          description: 'Der SAML-Relay-State ist abgelaufen. Bitte melde dich erneut an.'
        );
}

class SamlRelayStateNotFoundFailure extends AuthApiFailure {
  const SamlRelayStateNotFoundFailure()
      : super(
          code: 'saml_relay_state_not_found',
          httpStatus: '404',
          title: 'SAML-Relay-State nicht gefunden',
          description: 'Der SAML-Relay-State existiert nicht mehr. Bitte melde dich erneut an.'
        );
}

class SessionNotFoundFailure extends AuthApiFailure {
  const SessionNotFoundFailure()
      : super(
          code: 'session_not_found',
          httpStatus: '404',
          title: 'Sitzung nicht gefunden',
          description: 'Die Sitzung existiert nicht mehr. Bitte melde dich erneut an.'
        );
}

class SignupDisabledFailure extends AuthApiFailure {
  const SignupDisabledFailure()
      : super(
          code: 'signup_disabled',
          httpStatus: '501',
          title: 'Registrierung deaktiviert',
          description: 'Die Erstellung neuer Konten ist auf dem Server deaktiviert.'
        );
}

class SingleIdentityNotDeletableFailure extends AuthApiFailure {
  const SingleIdentityNotDeletableFailure()
      : super(
          code: 'single_identity_not_deletable',
          httpStatus: '409',
          title: 'Einzelne Identität nicht löschbar',
          description: 'Die einzige Identität eines Benutzers kann nicht entfernt werden.'
        );
}

class SmsSendFailedFailure extends AuthApiFailure {
  const SmsSendFailedFailure()
      : super(
          code: 'sms_send_failed',
          httpStatus: '500',
          title: 'SMS-Versand fehlgeschlagen',
          description: 'Das Senden der SMS ist fehlgeschlagen. Überprüfe die Konfiguration deines SMS-Anbieters.'
        );
}

class SsoDomainAlreadyExistsFailure extends AuthApiFailure {
  const SsoDomainAlreadyExistsFailure()
      : super(
          code: 'sso_domain_already_exists',
          httpStatus: '409',
          title: 'SSO-Domain bereits vorhanden',
          description: 'Es kann nur eine SSO-Domain pro SSO-Identitätsanbieter registriert werden.'
        );
}

class SsoProviderNotFoundFailure extends AuthApiFailure {
  const SsoProviderNotFoundFailure()
      : super(
          code: 'sso_provider_not_found',
          httpStatus: '404',
          title: 'SSO-Anbieter nicht gefunden',
          description: 'Der SSO-Anbieter wurde nicht gefunden. Überprüfe die Argumente in der Anfrage.'
        );
}

class TooManyEnrolledMfaFactorsFailure extends AuthApiFailure {
  const TooManyEnrolledMfaFactorsFailure()
      : super(
          code: 'too_many_enrolled_mfa_factors',
          httpStatus: '400',
          title: 'Zu viele MFA-Faktoren',
          description: 'Ein Benutzer kann nur eine begrenzte Anzahl an MFA-Faktoren registrieren.'
        );
}

class UnexpectedAudienceFailure extends AuthApiFailure {
  const UnexpectedAudienceFailure()
      : super(
          code: 'unexpected_audience',
          httpStatus: '401',
          title: 'Unerwartete Zielgruppe',
          description: 'Der X-JWT-AUD-Claim der Anfrage stimmt nicht mit der Zielgruppe des JWT überein.'
        );
}

class UnexpectedFailureFailure extends AuthApiFailure {
  const UnexpectedFailureFailure()
      : super(
          code: 'unexpected_failure',
          httpStatus: '500',
          title: 'Unerwarteter Fehler',
          description: 'Ein unerwarteter Fehler ist aufgetreten. Der Auth-Dienst ist möglicherweise beeinträchtigt.'
        );
}

class UserAlreadyExistsFailure extends AuthApiFailure {
  const UserAlreadyExistsFailure()
      : super(
          code: 'user_already_exists',
          httpStatus: '400',
          title: 'Benutzer bereits vorhanden',
          description: 'Ein Benutzer mit dieser E-Mail-Adresse oder Telefonnummer existiert bereits.'
        );
}

class UserBannedFailure extends AuthApiFailure {
  const UserBannedFailure()
      : super(
          code: 'user_banned',
          httpStatus: '403',
          title: 'Benutzerkonto deaktiviert',
          description: 'Dieses Benutzerkonto wurde deaktiviert.'
        );
}

class UserNotFoundFailure extends AuthApiFailure {
  const UserNotFoundFailure()
      : super(
          code: 'user_not_found',
          httpStatus: '404',
          title: 'Benutzerkonto nicht gefunden',
          description: 'Der Benutzer, auf den sich die API-Anfrage bezieht, existiert nicht.'
        );
}

class UserSsoManagedFailure extends AuthApiFailure {
  const UserSsoManagedFailure()
      : super(
          code: 'user_sso_managed',
          httpStatus: '403',
          title: 'SSO-verwalteter Benutzer',
          description: 'Bestimmte Benutzerfelder können bei SSO-Benutzern nicht aktualisiert werden.'
        );
}

class ValidationFailedFailure extends AuthApiFailure {
  const ValidationFailedFailure()
      : super(
          code: 'validation_failed',
          httpStatus: '400',
          title: 'Validierung fehlgeschlagen',
          description: 'Die bereitgestellten Parameter entsprechen nicht dem erwarteten Format.'
        );
}