import 'package:flame_id_app/core/error/failures/supabase/supabase_auth_failure.dart';

class SupabaseAuthApiFailure extends SupabaseAuthFailure {

  const SupabaseAuthApiFailure({
    super.code,
    super.httpStatus,
    required super.title,
    required super.description,
    super.stackTrace
  });

  const SupabaseAuthApiFailure.unknown({
    super.code,
    super.httpStatus,
    super.stackTrace
  }) : super(
         title: 'Unbekannter API-Fehler',
         description: 'Ein unbekannter Fehler von der Authentifizierungs-API ist aufgetreten.');

  const SupabaseAuthApiFailure.anonymousProviderDisabled({
    super.code = 'anonymous_provider_disabled',
    super.httpStatus = '403',
    super.stackTrace
  }) : super(
         title: 'Anonyme Anmeldung deaktiviert',
         description: 'Anonyme Anmeldungen sind auf diesem Server deaktiviert.');

  const SupabaseAuthApiFailure.badCodeVerifier({
    super.code = 'bad_code_verifier',
    super.httpStatus = '400',
    super.stackTrace
  }) : super(
         title: 'Ungültiger Code-Verifier',
         description: 'Der angegebene Code-Verifier stimmt nicht mit dem erwarteten überein. Bitte überprüfen Sie Ihre Client-Implementierung.');

  const SupabaseAuthApiFailure.badJson({
    super.code = 'bad_json',
    super.httpStatus = '400',
    super.stackTrace
  }) : super(
         title: 'Ungültiges JSON',
         description: 'Der HTTP-Anfragekörper enthält kein gültiges JSON-Format.');

  const SupabaseAuthApiFailure.badJwt({
    super.code = 'bad_jwt',
    super.httpStatus = '401',
    super.stackTrace
  }) : super(
         title: 'Ungültiger JWT',
         description: 'Der im Authorization-Header gesendete JWT ist ungültig.');

  const SupabaseAuthApiFailure.badOauthCallback({
    super.code = 'bad_oauth_callback',
    super.httpStatus = '400',
    super.stackTrace
  }) : super(
         title: 'Ungültiger OAuth-Callback',
         description: 'Der OAuth-Callback vom Anbieter enthält nicht alle erforderlichen Attribute.');

  const SupabaseAuthApiFailure.badOauthState({
    super.code = 'bad_oauth_state',
    super.httpStatus = '400',
    super.stackTrace
  }) : super(
         title: 'Ungültiger OAuth-Status',
         description: 'Der OAuth-Status ist nicht im korrekten Format. Bitte überprüfen Sie die Integration des OAuth-Anbieters.');

  const SupabaseAuthApiFailure.captchaFailed({
    super.code = 'captcha_failed',
    super.httpStatus = '400',
    super.stackTrace
  }) : super(
         title: 'CAPTCHA-Fehler',
         description: 'Die CAPTCHA-Überprüfung konnte nicht erfolgreich abgeschlossen werden. Bitte überprüfen Sie Ihre CAPTCHA-Integration.');

  const SupabaseAuthApiFailure.conflict({
    super.code = 'conflict',
    super.httpStatus = '409',
    super.stackTrace
  }) : super(
         title: 'Datenbankkonflikt',
         description: 'Ein Datenbankkonflikt ist aufgetreten, möglicherweise durch gleichzeitige Anfragen.');

  const SupabaseAuthApiFailure.emailAddressInvalid({
    super.code = 'email_address_invalid',
    super.httpStatus = '400',
    super.stackTrace
  }) : super(
         title: 'Ungültige E-Mail-Adresse',
         description: 'Beispiel- oder Testdomains werden nicht unterstützt. Bitte verwenden Sie eine andere E-Mail-Adresse.');

  const SupabaseAuthApiFailure.emailAddressNotAuthorized({
    super.code = 'email_address_not_authorized',
    super.httpStatus = '403',
    super.stackTrace
  }) : super(
         title: 'E-Mail-Versand nicht autorisiert',
         description: 'Der E-Mail-Versand ist für diese Adresse nicht erlaubt. Richten Sie einen benutzerdefinierten SMTP-Anbieter ein.');

  const SupabaseAuthApiFailure.emailConflictIdentityNotDeletable({
    super.code = 'email_conflict_identity_not_deletable',
    super.httpStatus = '409',
    super.stackTrace
  }) : super(
         title: 'E-Mail-Konflikt',
         description: 'Das Entfernen dieser Identität würde zu einem E-Mail-Konflikt führen. Bitte migrieren Sie die Benutzerdaten zu einem Konto.');

  const SupabaseAuthApiFailure.emailExists({
    super.code = 'email_exists',
    super.httpStatus = '400',
    super.stackTrace
  }) : super(
         title: 'E-Mail bereits vorhanden',
         description: 'Die E-Mail-Adresse existiert bereits im System.');

  const SupabaseAuthApiFailure.emailNotConfirmed({
    super.code = 'email_not_confirmed',
    super.httpStatus = '403',
    super.stackTrace
  }) : super(
         title: 'E-Mail nicht bestätigt',
         description: 'Die Anmeldung ist nicht möglich, da die E-Mail-Adresse nicht bestätigt wurde.');

  const SupabaseAuthApiFailure.emailProviderDisabled({
    super.code = 'email_provider_disabled',
    super.httpStatus = '501',
    super.stackTrace
  }) : super(
         title: 'E-Mail-Anmeldung deaktiviert',
         description: 'Anmeldungen mit E-Mail und Passwort sind deaktiviert.');

  const SupabaseAuthApiFailure.flowStateExpired({
    super.code = 'flow_state_expired',
    super.httpStatus = '400',
    super.stackTrace
  }) : super(
         title: 'PKCE-Flow abgelaufen',
         description: 'Der PKCE-Flow-Status ist abgelaufen. Bitte melden Sie sich erneut an.');

  const SupabaseAuthApiFailure.flowStateNotFound({
    super.code = 'flow_state_not_found',
    super.httpStatus = '404',
    super.stackTrace
  }) : super(
         title: 'PKCE-Flow nicht gefunden',
         description: 'Der PKCE-Flow-Status existiert nicht mehr. Bitte melden Sie sich erneut an.');

  const SupabaseAuthApiFailure.hookPayloadInvalidContentType({
    super.code = 'hook_payload_invalid_content_type',
    super.httpStatus = '400',
    super.stackTrace
  }) : super(
         title: 'Ungültiger Hook-Content-Type',
         description: 'Die Payload vom Auth-Server hat keinen gültigen Content-Type-Header.');

  const SupabaseAuthApiFailure.hookPayloadOverSizeLimit({
    super.code = 'hook_payload_over_size_limit',
    super.httpStatus = '413',
    super.stackTrace
  }) : super(
         title: 'Hook-Payload zu groß',
         description: 'Die Payload vom Auth-Server überschreitet die maximale Größenbeschränkung.');

  const SupabaseAuthApiFailure.hookTimeout({
    super.code = 'hook_timeout',
    super.httpStatus = '504',
    super.stackTrace
  }) : super(
         title: 'Hook-Timeout',
         description: 'Der Hook konnte innerhalb der maximalen Zeit nicht erreicht werden.');

  const SupabaseAuthApiFailure.hookTimeoutAfterRetry({
    super.code = 'hook_timeout_after_retry',
    super.httpStatus = '504',
    super.stackTrace
  }) : super(
         title: 'Hook-Timeout nach Wiederholung',
         description: 'Der Hook konnte nach maximaler Anzahl an Wiederholungen nicht erreicht werden.');

  const SupabaseAuthApiFailure.identityAlreadyExists({
    super.code = 'identity_already_exists',
    super.httpStatus = '409',
    super.stackTrace
  }) : super(
         title: 'Identität bereits vorhanden',
         description: 'Die Identität ist bereits mit einem Benutzer verknüpft.');

  const SupabaseAuthApiFailure.identityNotFound({
    super.code = 'identity_not_found',
    super.httpStatus = '404',
    super.stackTrace
  }) : super(
         title: 'Identität nicht gefunden',
         description: 'Die Identität, auf die sich die API-Anfrage bezieht, existiert nicht.');

  const SupabaseAuthApiFailure.insufficientAal({
    super.code = 'insufficient_aal',
    super.httpStatus = '403',
    super.stackTrace
  }) : super(
         title: 'Unzureichendes Authentifizierungsniveau',
         description: 'Der Benutzer muss ein höheres Authentifizierungsniveau haben. Bitte lösen Sie eine MFA-Herausforderung.');

  const SupabaseAuthApiFailure.invalidCredentials({
    super.code = 'invalid_credentials',
    super.httpStatus = '401',
    super.stackTrace
  }) : super(
         title: 'Ungültige Zugangsdaten',
         description: 'Die Anmeldedaten oder der Grant-Typ wurden nicht erkannt.');

  const SupabaseAuthApiFailure.inviteNotFound({
    super.code = 'invite_not_found',
    super.httpStatus = '404',
    super.stackTrace
  }) : super(
         title: 'Einladung nicht gefunden',
         description: 'Die Einladung ist abgelaufen oder wurde bereits verwendet.');

  const SupabaseAuthApiFailure.manualLinkingDisabled({
    super.code = 'manual_linking_disabled',
    super.httpStatus = '501',
    super.stackTrace
  }) : super(
         title: 'Manuelles Verknüpfen deaktiviert',
         description: 'Das manuelle Verknüpfen von Identitäten ist auf dem Auth-Server deaktiviert.');

  const SupabaseAuthApiFailure.mfaChallengeExpired({
    super.code = 'mfa_challenge_expired',
    super.httpStatus = '400',
    super.stackTrace
  }) : super(
         title: 'MFA-Herausforderung abgelaufen',
         description: 'Die MFA-Herausforderung ist abgelaufen. Bitte fordern Sie eine neue Herausforderung an.');

  const SupabaseAuthApiFailure.mfaFactorNameConflict({
    super.code = 'mfa_factor_name_conflict',
    super.httpStatus = '409',
    super.stackTrace
  }) : super(
         title: 'MFA-Faktorname-Konflikt',
         description: 'MFA-Faktoren eines Benutzers dürfen nicht denselben Namen haben.');

  const SupabaseAuthApiFailure.mfaFactorNotFound({
    super.code = 'mfa_factor_not_found',
    super.httpStatus = '404',
    super.stackTrace
  }) : super(
         title: 'MFA-Faktor nicht gefunden',
         description: 'Der MFA-Faktor existiert nicht mehr.');

  const SupabaseAuthApiFailure.mfaIpAddressMismatch({
    super.code = 'mfa_ip_address_mismatch',
    super.httpStatus = '400',
    super.stackTrace
  }) : super(
         title: 'MFA-IP-Adressen-Konflikt',
         description: 'Der MFA-Registrierungsprozess muss mit derselben IP-Adresse begonnen und beendet werden.');

  const SupabaseAuthApiFailure.mfaPhoneEnrollNotEnabled({
    super.code = 'mfa_phone_enroll_not_enabled',
    super.httpStatus = '501',
    super.stackTrace
  }) : super(
         title: 'MFA-Telefonregistrierung deaktiviert',
         description: 'Die Registrierung von MFA-Telefonfaktoren ist deaktiviert.');

  const SupabaseAuthApiFailure.mfaPhoneVerifyNotEnabled({
    super.code = 'mfa_phone_verify_not_enabled',
    super.httpStatus = '501',
    super.stackTrace
  }) : super(
         title: 'MFA-Telefonverifizierung deaktiviert',
         description: 'Die Verifizierung von MFA-Telefonfaktoren ist deaktiviert.');

  const SupabaseAuthApiFailure.mfaTotpEnrollNotEnabled({
    super.code = 'mfa_totp_enroll_not_enabled',
    super.httpStatus = '501',
    super.stackTrace
  }) : super(
         title: 'MFA-TOTP-Registrierung deaktiviert',
         description: 'Die Registrierung von MFA-TOTP-Faktoren ist deaktiviert.');

  const SupabaseAuthApiFailure.mfaTotpVerifyNotEnabled({
    super.code = 'mfa_totp_verify_not_enabled',
    super.httpStatus = '501',
    super.stackTrace
  }) : super(
         title: 'MFA-TOTP-Verifizierung deaktiviert',
         description: 'Die Verifizierung von MFA-TOTP-Faktoren ist deaktiviert.');

  const SupabaseAuthApiFailure.mfaVerificationFailed({
    super.code = 'mfa_verification_failed',
    super.httpStatus = '400',
    super.stackTrace
  }) : super(
         title: 'MFA-Verifizierung fehlgeschlagen',
         description: 'Die MFA-Herausforderung konnte nicht verifiziert werden. Falscher TOTP-Code.');

  const SupabaseAuthApiFailure.mfaVerificationRejected({
    super.code = 'mfa_verification_rejected',
    super.httpStatus = '400',
    super.stackTrace
  }) : super(
         title: 'MFA-Verifizierung abgelehnt',
         description: 'Die MFA-Verifizierung wurde abgelehnt. Überprüfen Sie den MFA-Verifizierungs-Hook.');

  const SupabaseAuthApiFailure.mfaVerifiedFactorExists({
    super.code = 'mfa_verified_factor_exists',
    super.httpStatus = '409',
    super.stackTrace
  }) : super(
         title: 'Verifizierter MFA-Faktor vorhanden',
         description: 'Ein verifizierter Telefonfaktor existiert bereits. Entfernen Sie den bestehenden Faktor, um fortzufahren.');

  const SupabaseAuthApiFailure.mfaWebAuthnEnrollNotEnabled({
    super.code = 'mfa_web_authn_enroll_not_enabled',
    super.httpStatus = '501',
    super.stackTrace
  }) : super(
         title: 'MFA-WebAuthn-Registrierung deaktiviert',
         description: 'Die Registrierung von MFA-WebAuthn-Faktoren ist deaktiviert.');

  const SupabaseAuthApiFailure.mfaWebAuthnVerifyNotEnabled({
    super.code = 'mfa_web_authn_verify_not_enabled',
    super.httpStatus = '501',
    super.stackTrace
  }) : super(
         title: 'MFA-WebAuthn-Verifizierung deaktiviert',
         description: 'Die Verifizierung von MFA-WebAuthn-Faktoren ist deaktiviert.');

  const SupabaseAuthApiFailure.noAuthorization({
    super.code = 'no_authorization',
    super.httpStatus = '401',
    super.stackTrace
  }) : super(
         title: 'Keine Autorisierung',
         description: 'Die HTTP-Anfrage erfordert einen Authorization-Header, der nicht bereitgestellt wurde.');

  const SupabaseAuthApiFailure.notAdmin({
    super.code = 'not_admin',
    super.httpStatus = '403',
    super.stackTrace
  }) : super(
         title: 'Kein Admin',
         description: 'Der Benutzer ist kein Admin und hat keine ausreichenden Berechtigungen.');

  const SupabaseAuthApiFailure.oauthProviderNotSupported({
    super.code = 'oauth_provider_not_supported',
    super.httpStatus = '501',
    super.stackTrace
  }) : super(
         title: 'OAuth-Anbieter nicht unterstützt',
         description: 'Der verwendete OAuth-Anbieter ist auf dem Auth-Server deaktiviert.');

  const SupabaseAuthApiFailure.otpDisabled({
    super.code = 'otp_disabled',
    super.httpStatus = '501',
    super.stackTrace
  }) : super(
         title: 'OTP-Anmeldung deaktiviert',
         description: 'Die Anmeldung mit OTP (Magic Link, E-Mail-OTP) ist deaktiviert.');

  const SupabaseAuthApiFailure.otpExpired({
    super.code = 'otp_expired',
    super.httpStatus = '400',
    super.stackTrace
  }) : super(
         title: 'OTP abgelaufen',
         description: 'Der OTP-Code für diese Anmeldung ist abgelaufen. Bitte melden Sie sich erneut an.');

  const SupabaseAuthApiFailure.overEmailSendRateLimit({
    super.code = 'over_email_send_rate_limit',
    super.httpStatus = '429',
    super.stackTrace
  }) : super(
         title: 'E-Mail-Ratenbegrenzung überschritten',
         description: 'Zu viele E-Mails wurden an diese Adresse gesendet. Bitte warten Sie eine Weile und versuchen Sie es erneut.');

  const SupabaseAuthApiFailure.overRequestRateLimit({
    super.code = 'over_request_rate_limit',
    super.httpStatus = '429',
    super.stackTrace
  }) : super(
         title: 'Anfrageratenbegrenzung überschritten',
         description: 'Zu viele Anfragen von dieser IP-Adresse. Bitte versuchen Sie es in ein paar Minuten erneut.');

  const SupabaseAuthApiFailure.overSmsSendRateLimit({
    super.code = 'over_sms_send_rate_limit',
    super.httpStatus = '429',
    super.stackTrace
  }) : super(
         title: 'SMS-Ratenbegrenzung überschritten',
         description: 'Zu viele SMS wurden an diese Nummer gesendet. Bitte warten Sie eine Weile und versuchen Sie es erneut.');

  const SupabaseAuthApiFailure.phoneExists({
    super.code = 'phone_exists',
    super.httpStatus = '400',
    super.stackTrace
  }) : super(
         title: 'Telefonnummer bereits vorhanden',
         description: 'Die Telefonnummer existiert bereits im System.');

  const SupabaseAuthApiFailure.phoneNotConfirmed({
    super.code = 'phone_not_confirmed',
    super.httpStatus = '403',
    super.stackTrace
  }) : super(
         title: 'Telefonnummer nicht bestätigt',
         description: 'Die Anmeldung ist nicht möglich, da die Telefonnummer nicht bestätigt wurde.');

  const SupabaseAuthApiFailure.phoneProviderDisabled({
    super.code = 'phone_provider_disabled',
    super.httpStatus = '501',
    super.stackTrace
  }) : super(
         title: 'Telefonanmeldung deaktiviert',
         description: 'Anmeldungen mit Telefonnummer und Passwort sind deaktiviert.');

  const SupabaseAuthApiFailure.providerDisabled({
    super.code = 'provider_disabled',
    super.httpStatus = '501',
    super.stackTrace
  }) : super(
         title: 'Anbieter deaktiviert',
         description: 'Der OAuth-Anbieter ist für die Nutzung deaktiviert. Überprüfen Sie die Serverkonfiguration.');

  const SupabaseAuthApiFailure.providerEmailNeedsVerification({
    super.code = 'provider_email_needs_verification',
    super.httpStatus = '403',
    super.stackTrace
  }) : super(
         title: 'E-Mail-Verifizierung erforderlich',
         description: 'Die E-Mail-Adresse des OAuth-Anbieters muss verifiziert werden.');

  const SupabaseAuthApiFailure.reauthenticationNeeded({
    super.code = 'reauthentication_needed',
    super.httpStatus = '403',
    super.stackTrace
  }) : super(
         title: 'Neuauthentifizierung erforderlich',
         description: 'Der Benutzer muss sich erneut authentifizieren, um das Passwort zu ändern.');

  const SupabaseAuthApiFailure.reauthenticationNotValid({
    super.code = 'reauthentication_not_valid',
    super.httpStatus = '400',
    super.stackTrace
  }) : super(
         title: 'Ungültige Neuauthentifizierung',
         description: 'Die Verifizierung der Neuauthentifizierung ist fehlgeschlagen. Bitte geben Sie einen neuen Code ein.');

  const SupabaseAuthApiFailure.refreshTokenAlreadyUsed({
    super.code = 'refresh_token_already_used',
    super.httpStatus = '401',
    super.stackTrace
  }) : super(
         title: 'Refresh-Token bereits verwendet',
         description: 'Der Refresh-Token wurde widerrufen und liegt außerhalb des Wiederverwendungsintervalls.');

  const SupabaseAuthApiFailure.refreshTokenNotFound({
    super.code = 'refresh_token_not_found',
    super.httpStatus = '404',
    super.stackTrace
  }) : super(
         title: 'Refresh-Token nicht gefunden',
         description: 'Die Sitzung mit dem Refresh-Token wurde nicht gefunden.');

  const SupabaseAuthApiFailure.requestTimeout({
    super.code = 'request_timeout',
    super.httpStatus = '504',
    super.stackTrace
  }) : super(
         title: 'Anfrage-Timeout',
         description: 'Die Verarbeitung der Anfrage hat zu lange gedauert. Bitte versuchen Sie es erneut.');

  const SupabaseAuthApiFailure.samePassword({
    super.code = 'same_password',
    super.httpStatus = '400',
    super.stackTrace
  }) : super(
         title: 'Gleiches Passwort',
         description: 'Das neue Passwort muss sich vom aktuellen Passwort unterscheiden.');

  const SupabaseAuthApiFailure.samlAssertionNoEmail({
    super.code = 'saml_assertion_no_email',
    super.httpStatus = '400',
    super.stackTrace
  }) : super(
         title: 'Kein E-Mail in SAML-Assertion',
         description: 'Die SAML-Assertion enthält keine E-Mail-Adresse, die erforderlich ist.');

  const SupabaseAuthApiFailure.samlAssertionNoUserId({
    super.code = 'saml_assertion_no_user_id',
    super.httpStatus = '400',
    super.stackTrace
  }) : super(
         title: 'Kein Benutzer-ID in SAML-Assertion',
         description: 'Die SAML-Assertion enthält keine Benutzer-ID (NameID), die erforderlich ist.');

  const SupabaseAuthApiFailure.samlEntityIdMismatch({
    super.code = 'saml_entity_id_mismatch',
    super.httpStatus = '409',
    super.stackTrace
  }) : super(
         title: 'SAML-Entity-ID-Konflikt',
         description: 'Die Entity-ID im Update stimmt nicht mit der in der Datenbank überein. Erstellen Sie stattdessen einen neuen Anbieter.');

  const SupabaseAuthApiFailure.samlIdpAlreadyExists({
    super.code = 'saml_idp_already_exists',
    super.httpStatus = '409',
    super.stackTrace
  }) : super(
         title: 'SAML-Anbieter bereits vorhanden',
         description: 'Der SAML-Anbieter wurde bereits hinzugefügt.');

  const SupabaseAuthApiFailure.samlIdpNotFound({
    super.code = 'saml_idp_not_found',
    super.httpStatus = '404',
    super.stackTrace
  }) : super(
         title: 'SAML-Anbieter nicht gefunden',
         description: 'Der SAML-Anbieter wurde nicht gefunden. Überprüfen Sie die Anbieterkonfiguration.');

  const SupabaseAuthApiFailure.samlMetadataFetchFailed({
    super.code = 'saml_metadata_fetch_failed',
    super.httpStatus = '500',
    super.stackTrace
  }) : super(
         title: 'SAML-Metadatenabruf fehlgeschlagen',
         description: 'Die Metadaten des SAML-Anbieters konnten nicht abgerufen werden.');

  const SupabaseAuthApiFailure.samlProviderDisabled({
    super.code = 'saml_provider_disabled',
    super.httpStatus = '501',
    super.stackTrace
  }) : super(
         title: 'SAML-Anbieter deaktiviert',
         description: 'Die Nutzung von Enterprise SSO mit SAML 2.0 ist auf dem Auth-Server deaktiviert.');

  const SupabaseAuthApiFailure.samlRelayStateExpired({
    super.code = 'saml_relay_state_expired',
    super.httpStatus = '400',
    super.stackTrace
  }) : super(
         title: 'SAML-Relay-State abgelaufen',
         description: 'Der SAML-Relay-State ist abgelaufen. Bitte melden Sie sich erneut an.');

  const SupabaseAuthApiFailure.samlRelayStateNotFound({
    super.code = 'saml_relay_state_not_found',
    super.httpStatus = '404',
    super.stackTrace
  }) : super(
         title: 'SAML-Relay-State nicht gefunden',
         description: 'Der SAML-Relay-State existiert nicht mehr. Bitte melden Sie sich erneut an.');

  const SupabaseAuthApiFailure.sessionExpired({
    super.code = 'session_expired',
    super.httpStatus = '401',
    super.stackTrace
  }) : super(
         title: 'Sitzung abgelaufen',
         description: 'Die Sitzung ist abgelaufen. Bitte melden Sie sich erneut an.');

  const SupabaseAuthApiFailure.sessionNotFound({
    super.code = 'session_not_found',
    super.httpStatus = '404',
    super.stackTrace
  }) : super(
         title: 'Sitzung nicht gefunden',
         description: 'Die Sitzung existiert nicht mehr. Bitte melden Sie sich erneut an.');

  const SupabaseAuthApiFailure.signupDisabled({
    super.code = 'signup_disabled',
    super.httpStatus = '501',
    super.stackTrace
  }) : super(
         title: 'Registrierung deaktiviert',
         description: 'Die Erstellung neuer Konten ist auf dem Server deaktiviert.');

  const SupabaseAuthApiFailure.singleIdentityNotDeletable({
    super.code = 'single_identity_not_deletable',
    super.httpStatus = '409',
    super.stackTrace
  }) : super(
         title: 'Einzelne Identität nicht löschbar',
         description: 'Die einzige Identität eines Benutzers kann nicht entfernt werden.');

  const SupabaseAuthApiFailure.smsSendFailed({
    super.code = 'sms_send_failed',
    super.httpStatus = '500',
    super.stackTrace
  }) : super(
         title: 'SMS-Versand fehlgeschlagen',
         description: 'Das Senden der SMS ist fehlgeschlagen. Überprüfen Sie die Konfiguration Ihres SMS-Anbieters.');

  const SupabaseAuthApiFailure.ssoDomainAlreadyExists({
    super.code = 'sso_domain_already_exists',
    super.httpStatus = '409',
    super.stackTrace
  }) : super(
         title: 'SSO-Domain bereits vorhanden',
         description: 'Es kann nur eine SSO-Domain pro SSO-Identitätsanbieter registriert werden.');

  const SupabaseAuthApiFailure.ssoProviderNotFound({
    super.code = 'sso_provider_not_found',
    super.httpStatus = '404',
    super.stackTrace
  }) : super(
         title: 'SSO-Anbieter nicht gefunden',
         description: 'Der SSO-Anbieter wurde nicht gefunden. Überprüfen Sie die Argumente in der Anfrage.');

  const SupabaseAuthApiFailure.tooManyEnrolledMfaFactors({
    super.code = 'too_many_enrolled_mfa_factors',
    super.httpStatus = '400',
    super.stackTrace
  }) : super(
         title: 'Zu viele MFA-Faktoren',
         description: 'Ein Benutzer kann nur eine begrenzte Anzahl an MFA-Faktoren registrieren.');

  const SupabaseAuthApiFailure.unexpectedAudience({
    super.code = 'unexpected_audience',
    super.httpStatus = '401',
    super.stackTrace
  }) : super(
         title: 'Unerwartete Zielgruppe',
         description: 'Der X-JWT-AUD-Claim der Anfrage stimmt nicht mit der Zielgruppe des JWT überein.');

  const SupabaseAuthApiFailure.unexpectedFailure({
    super.code = 'unexpected_failure',
    super.httpStatus = '500',
    super.stackTrace
  }) : super(
         title: 'Unerwarteter Fehler',
         description: 'Ein unerwarteter Fehler ist aufgetreten. Der Auth-Dienst ist möglicherweise beeinträchtigt.');

  const SupabaseAuthApiFailure.userAlreadyExists({
    super.code = 'user_already_exists',
    super.httpStatus = '400',
    super.stackTrace
  }) : super(
         title: 'Benutzer bereits vorhanden',
         description: 'Ein Benutzer mit dieser E-Mail-Adresse oder Telefonnummer existiert bereits.');

  const SupabaseAuthApiFailure.userBanned({
    super.code = 'user_banned',
    super.httpStatus = '403',
    super.stackTrace
  }) : super(
         title: 'Benutzerkonto deaktiviert',
         description: 'Dieses Benutzerkonto wurde deaktiviert.');

  const SupabaseAuthApiFailure.userNotFound({
    super.code = 'user_not_found',
    super.httpStatus = '404',
    super.stackTrace
  }) : super(
         title: 'Benutzerkonto nicht gefunden',
         description: 'Der Benutzer, auf den sich die API-Anfrage bezieht, existiert nicht.');

  const SupabaseAuthApiFailure.userSsoManaged({
    super.code = 'user_sso_managed',
    super.httpStatus = '403',
    super.stackTrace
  }) : super(
         title: 'SSO-verwalteter Benutzer',
         description: 'Bestimmte Benutzerfelder können bei SSO-Benutzern nicht aktualisiert werden.');

  const SupabaseAuthApiFailure.validationFailed({
    super.code = 'validation_failed',
    super.httpStatus = '400',
    super.stackTrace
  }) : super(
         title: 'Validierung fehlgeschlagen',
         description: 'Die bereitgestellten Parameter entsprechen nicht dem erwarteten Format.');

  static SupabaseAuthApiFailure? getBySupabaseCode(String? code) {
    return switch (code) {
      'anonymous_provider_disabled' => const SupabaseAuthApiFailure.anonymousProviderDisabled(),
      'bad_code_verifier' => const SupabaseAuthApiFailure.badCodeVerifier(),
      'bad_json' => const SupabaseAuthApiFailure.badJson(),
      'bad_jwt' => const SupabaseAuthApiFailure.badJwt(),
      'bad_oauth_callback' => const SupabaseAuthApiFailure.badOauthCallback(),
      'bad_oauth_state' => const SupabaseAuthApiFailure.badOauthState(),
      'captcha_failed' => const SupabaseAuthApiFailure.captchaFailed(),
      'conflict' => const SupabaseAuthApiFailure.conflict(),
      'email_address_invalid' => const SupabaseAuthApiFailure.emailAddressInvalid(),
      'email_address_not_authorized' => const SupabaseAuthApiFailure.emailAddressNotAuthorized(),
      'email_conflict_identity_not_deletable' => const SupabaseAuthApiFailure.emailConflictIdentityNotDeletable(),
      'email_exists' => const SupabaseAuthApiFailure.emailExists(),
      'email_not_confirmed' => const SupabaseAuthApiFailure.emailNotConfirmed(),
      'email_provider_disabled' => const SupabaseAuthApiFailure.emailProviderDisabled(),
      'flow_state_expired' => const SupabaseAuthApiFailure.flowStateExpired(),
      'flow_state_not_found' => const SupabaseAuthApiFailure.flowStateNotFound(),
      'hook_payload_invalid_content_type' => const SupabaseAuthApiFailure.hookPayloadInvalidContentType(),
      'hook_payload_over_size_limit' => const SupabaseAuthApiFailure.hookPayloadOverSizeLimit(),
      'hook_timeout' => const SupabaseAuthApiFailure.hookTimeout(),
      'hook_timeout_after_retry' => const SupabaseAuthApiFailure.hookTimeoutAfterRetry(),
      'identity_already_exists' => const SupabaseAuthApiFailure.identityAlreadyExists(),
      'identity_not_found' => const SupabaseAuthApiFailure.identityNotFound(),
      'insufficient_aal' => const SupabaseAuthApiFailure.insufficientAal(),
      'invalid_credentials' => const SupabaseAuthApiFailure.invalidCredentials(),
      'invite_not_found' => const SupabaseAuthApiFailure.inviteNotFound(),
      'manual_linking_disabled' => const SupabaseAuthApiFailure.manualLinkingDisabled(),
      'mfa_challenge_expired' => const SupabaseAuthApiFailure.mfaChallengeExpired(),
      'mfa_factor_name_conflict' => const SupabaseAuthApiFailure.mfaFactorNameConflict(),
      'mfa_factor_not_found' => const SupabaseAuthApiFailure.mfaFactorNotFound(),
      'mfa_ip_address_mismatch' => const SupabaseAuthApiFailure.mfaIpAddressMismatch(),
      'mfa_phone_enroll_not_enabled' => const SupabaseAuthApiFailure.mfaPhoneEnrollNotEnabled(),
      'mfa_phone_verify_not_enabled' => const SupabaseAuthApiFailure.mfaPhoneVerifyNotEnabled(),
      'mfa_totp_enroll_not_enabled' => const SupabaseAuthApiFailure.mfaTotpEnrollNotEnabled(),
      'mfa_totp_verify_not_enabled' => const SupabaseAuthApiFailure.mfaTotpVerifyNotEnabled(),
      'mfa_verification_failed' => const SupabaseAuthApiFailure.mfaVerificationFailed(),
      'mfa_verification_rejected' => const SupabaseAuthApiFailure.mfaVerificationRejected(),
      'mfa_verified_factor_exists' => const SupabaseAuthApiFailure.mfaVerifiedFactorExists(),
      'mfa_web_authn_enroll_not_enabled' => const SupabaseAuthApiFailure.mfaWebAuthnEnrollNotEnabled(),
      'mfa_web_authn_verify_not_enabled' => const SupabaseAuthApiFailure.mfaWebAuthnVerifyNotEnabled(),
      'no_authorization' => const SupabaseAuthApiFailure.noAuthorization(),
      'not_admin' => const SupabaseAuthApiFailure.notAdmin(),
      'oauth_provider_not_supported' => const SupabaseAuthApiFailure.oauthProviderNotSupported(),
      'otp_disabled' => const SupabaseAuthApiFailure.otpDisabled(),
      'otp_expired' => const SupabaseAuthApiFailure.otpExpired(),
      'over_email_send_rate_limit' => const SupabaseAuthApiFailure.overEmailSendRateLimit(),
      'over_request_rate_limit' => const SupabaseAuthApiFailure.overRequestRateLimit(),
      'over_sms_send_rate_limit' => const SupabaseAuthApiFailure.overSmsSendRateLimit(),
      'phone_exists' => const SupabaseAuthApiFailure.phoneExists(),
      'phone_not_confirmed' => const SupabaseAuthApiFailure.phoneNotConfirmed(),
      'phone_provider_disabled' => const SupabaseAuthApiFailure.phoneProviderDisabled(),
      'provider_disabled' => const SupabaseAuthApiFailure.providerDisabled(),
      'provider_email_needs_verification' => const SupabaseAuthApiFailure.providerEmailNeedsVerification(),
      'reauthentication_needed' => const SupabaseAuthApiFailure.reauthenticationNeeded(),
      'reauthentication_not_valid' => const SupabaseAuthApiFailure.reauthenticationNotValid(),
      'refresh_token_already_used' => const SupabaseAuthApiFailure.refreshTokenAlreadyUsed(),
      'refresh_token_not_found' => const SupabaseAuthApiFailure.refreshTokenNotFound(),
      'request_timeout' => const SupabaseAuthApiFailure.requestTimeout(),
      'same_password' => const SupabaseAuthApiFailure.samePassword(),
      'saml_assertion_no_email' => const SupabaseAuthApiFailure.samlAssertionNoEmail(),
      'saml_assertion_no_user_id' => const SupabaseAuthApiFailure.samlAssertionNoUserId(),
      'saml_entity_id_mismatch' => const SupabaseAuthApiFailure.samlEntityIdMismatch(),
      'saml_idp_already_exists' => const SupabaseAuthApiFailure.samlIdpAlreadyExists(),
      'saml_idp_not_found' => const SupabaseAuthApiFailure.samlIdpNotFound(),
      'saml_metadata_fetch_failed' => const SupabaseAuthApiFailure.samlMetadataFetchFailed(),
      'saml_provider_disabled' => const SupabaseAuthApiFailure.samlProviderDisabled(),
      'saml_relay_state_expired' => const SupabaseAuthApiFailure.samlRelayStateExpired(),
      'saml_relay_state_not_found' => const SupabaseAuthApiFailure.samlRelayStateNotFound(),
      'session_expired' => const SupabaseAuthApiFailure.sessionExpired(),
      'session_not_found' => const SupabaseAuthApiFailure.sessionNotFound(),
      'signup_disabled' => const SupabaseAuthApiFailure.signupDisabled(),
      'single_identity_not_deletable' => const SupabaseAuthApiFailure.singleIdentityNotDeletable(),
      'sms_send_failed' => const SupabaseAuthApiFailure.smsSendFailed(),
      'sso_domain_already_exists' => const SupabaseAuthApiFailure.ssoDomainAlreadyExists(),
      'sso_provider_not_found' => const SupabaseAuthApiFailure.ssoProviderNotFound(),
      'too_many_enrolled_mfa_factors' => const SupabaseAuthApiFailure.tooManyEnrolledMfaFactors(),
      'unexpected_audience' => const SupabaseAuthApiFailure.unexpectedAudience(),
      'unexpected_failure' => const SupabaseAuthApiFailure.unexpectedFailure(),
      'user_already_exists' => const SupabaseAuthApiFailure.userAlreadyExists(),
      'user_banned' => const SupabaseAuthApiFailure.userBanned(),
      'user_not_found' => const SupabaseAuthApiFailure.userNotFound(),
      'user_sso_managed' => const SupabaseAuthApiFailure.userSsoManaged(),
      'validation_failed' => const SupabaseAuthApiFailure.validationFailed(),
      _ => null
    };
  }
}