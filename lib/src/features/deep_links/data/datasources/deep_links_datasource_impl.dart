import 'package:app_links/app_links.dart';

import 'package:flame_id_app/src/features/deep_links/data/datasources/deep_links_datasource.dart';

class DeepLinksDatasourceImpl implements DeepLinksDatasource {
  
  const DeepLinksDatasourceImpl(this._appLinks);

  final AppLinks _appLinks;

  @override
  Stream<Uri> get uriLinksStream => _appLinks.uriLinkStream;
}