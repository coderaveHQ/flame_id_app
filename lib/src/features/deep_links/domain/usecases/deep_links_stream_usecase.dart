import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:flame_id_app/src/features/deep_links/domain/entities/deep_link_entity.dart';
import 'package:flame_id_app/src/features/deep_links/domain/repositories/deep_links_repository.dart';
import 'package:flame_id_app/core/error/failures/failure.dart';

part 'deep_links_stream_usecase.g.dart';

@riverpod
DeepLinksStreamUsecase deepLinksStreamUsecase(Ref ref) {
  final DeepLinksRepository deepLinksRepository = ref.watch(deepLinksRepositoryProvider);
  return DeepLinksStreamUsecase(deepLinksRepository);
}

class DeepLinksStreamUsecase {

  final DeepLinksRepository _deepLinksRepository;
  
  const DeepLinksStreamUsecase(this._deepLinksRepository);

  Stream<Either<Failure, DeepLinkEntity>> call() {
    return _deepLinksRepository.deepLinksStream;
  }
}