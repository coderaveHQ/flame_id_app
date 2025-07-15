import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dartz/dartz.dart';

import 'package:flame_id_app/src/features/deep_links/domain/usecases/deep_links_stream_usecase.dart';
import 'package:flame_id_app/core/error/failures/failure.dart';
import 'package:flame_id_app/src/features/deep_links/domain/entities/deep_link_entity.dart';

part 'deep_links_stream_provider.g.dart';

@riverpod
Stream<Either<Failure, DeepLinkEntity>> deepLinksStream(Ref ref) {
  final DeepLinksStreamUsecase deepLinksStreamUsecase = ref.watch(deepLinksStreamUsecaseProvider);
  return deepLinksStreamUsecase();
}