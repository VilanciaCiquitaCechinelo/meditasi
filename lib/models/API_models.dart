// deklraasi tipe data

import '../controllers/API_controller.dart';

class Track {
  final String name;
  final List<String> artists;

  Track({required this.name, required this.artists});
}

Future<List<Track>> getTopTracks() async {
  final response = await fetchWebApi(
      'v1/me/top/tracks?time_range=short_term&limit=5', 'GET', null
  );

  final topTracks = List<Map<String, dynamic>>.from(response['items']);
  return topTracks.map((track) {
    final name = track['name'];
    final artists = List<Map<String, dynamic>>.from(track['artists'])
        .map((artist) => artist['name'].toString()) // Cast artist names to String
        .toList();
    return Track(name: name, artists: artists);
  }).toList();
}
