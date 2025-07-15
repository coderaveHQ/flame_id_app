import 'package:dartz/dartz.dart';

import 'package:flame_id_app/core/error/failures/failure.dart';
import 'package:flame_id_app/src/features/deep_links/data/datasources/deep_links_datasource.dart';
import 'package:flame_id_app/src/features/deep_links/domain/entities/deep_link_entity.dart';
import 'package:flame_id_app/src/features/deep_links/domain/repositories/deep_links_repository.dart';

class DeepLinksRepositoryImpl implements DeepLinksRepository {
  
  final DeepLinksDatasource _datasource;

  const DeepLinksRepositoryImpl(this._datasource);

  @override
  Stream<Either<Failure, DeepLinkEntity>> get deepLinksStream {
    return _datasource.uriLinksStream.map((uri) {
      final DeepLinkEntity entity = DeepLinkEntity.fromUri(uri);
      return Right(entity);
    });
  }
}