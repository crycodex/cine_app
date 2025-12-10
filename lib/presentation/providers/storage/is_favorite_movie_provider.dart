import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cine_app/presentation/providers/storage/local_storage_provider.dart';

final isFavoriteMovieProvider = FutureProvider.family.autoDispose<bool, int>((
  ref,
  movieId,
) {
  final localStorageRepository = ref.watch(localStorageRepositoryProvider);
  return localStorageRepository.isFavoriteMovie(movieId);
});
