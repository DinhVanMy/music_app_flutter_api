import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:music_app/data/model/song.dart';
import 'package:http/http.dart' as http;

abstract interface class DataSource{
  Future<List<Song>?> loadData();
}

class RemoteDataSource implements DataSource {
  @override
  Future<List<Song>?> loadData() async {
    const url = 'https://thantrieu.com/resources/braniumapis/songs.json';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if(response.statusCode==200) {
      final bodyContent = utf8.decode(response.bodyBytes);
      var songWrapper = jsonDecode(bodyContent) as Map;
      var songList = songWrapper['songs'] as List;
      List<Song> songs = songList.map((song) => Song.fromJson(song)).toList();
      return songs;
    }
    else {
      return null;
    }
  }
}

class LocalDataSource implements DataSource{
  @override
  Future<List<Song>?> loadData() async {
    final String response = await rootBundle.loadString("assets/songs.json");
    final jsonBody = jsonDecode(response) as Map;
    final songList = jsonBody['songs'] as List;
    List<Song> songs = songList.map((song) => Song.fromJson(song)).toList();
    return songs;
  }
}
