import 'package:equatable/equatable.dart';

class DeepLinkEntity extends Equatable {

  final String path;
  final Map<String, String> queryParams;
  final bool hasEmptyPath;

  const DeepLinkEntity({
    required this.path,
    required this.queryParams,
    required this.hasEmptyPath
  });

  factory DeepLinkEntity.fromUri(Uri uri) {
    return DeepLinkEntity(
      path: uri.path,
      queryParams: uri.queryParameters,
      hasEmptyPath: uri.hasEmptyPath
    );
  }

  @override
  List<Object?> get props => [
    path, 
    queryParams,
    hasEmptyPath
  ];
}