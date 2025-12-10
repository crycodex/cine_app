import 'package:cine_app/config/constants/movie_genres.dart';

String getGenreName(int genreId) {
  return movieGenres[genreId] ?? 'Desconocido';
}

List<String> getGenName(List<int> genreids){
  return genreids.map((id) => getGenreName(id)).toList();
}