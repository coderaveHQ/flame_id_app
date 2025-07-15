import 'package:flutter/foundation.dart';

import 'package:flame_id_app/core/utils/env.dart';
import 'package:flame_id_app/core/services/router.dart';

class RedirectUrls {

  static String get _deepLinkScheme => 'dev.coderave.flameidapp';

  static String get magicLink => _buildRedirectUrlForPlatform(SplashRoute.fullPath);
  static String get resetPassword => _buildRedirectUrlForPlatform(SplashRoute.fullPath);
  static String get changeEmail => _buildRedirectUrlForPlatform(SplashRoute.fullPath);
  static String get verifyInvite => _buildRedirectUrlForPlatform('${ SplashRoute.fullPath }?invite-verified');

  static String _buildRedirectUrlForPlatform(String host) {
    host = host.substring(1);

    if (kIsWeb) {
      return kDebugMode
        ? 'http://${ Env.debugApiIpAddress }:8080/$host'
        : 'https://flame-id.coderave.dev/$host';
    }

    return '$_deepLinkScheme://$host';
  }
}