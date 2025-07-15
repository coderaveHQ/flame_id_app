import 'package:app_links/app_links.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:flame_id_app/src/features/deep_links/data/datasources/deep_links_datasource_impl.dart';

part 'deep_links_datasource.g.dart';

@riverpod
DeepLinksDatasource deepLinksDatasource(Ref ref) {
  return DeepLinksDatasourceImpl(AppLinks());
}

abstract class DeepLinksDatasource {

  Stream<Uri> get uriLinksStream;
}