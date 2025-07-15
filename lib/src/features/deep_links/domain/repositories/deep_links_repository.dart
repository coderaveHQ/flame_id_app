import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:flame_id_app/core/error/failures/failure.dart';
import 'package:flame_id_app/src/features/deep_links/data/datasources/deep_links_datasource.dart';
import 'package:flame_id_app/src/features/deep_links/data/repositories/deep_links_repository_impl.dart';
import 'package:flame_id_app/src/features/deep_links/domain/entities/deep_link_entity.dart';

part 'deep_links_repository.g.dart';

@riverpod
DeepLinksRepository deepLinksRepository(Ref ref) {
  final DeepLinksDatasource deepLinksDatasource = ref.watch(deepLinksDatasourceProvider);
  return DeepLinksRepositoryImpl(deepLinksDatasource);
}

abstract class DeepLinksRepository {

  Stream<Either<Failure, DeepLinkEntity>> get deepLinksStream;
}