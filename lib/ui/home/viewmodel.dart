import 'dart:async';

import 'package:music_app/data/repository/repository.dart';

import '../../data/model/song.dart';

class MusicAppViewModel {
  StreamController<List<Song>> songStream = StreamController();

  void loadSongs(){
    final repository = DefaultRepository();
    repository.loadData().then((value) => songStream.add(value!));
  }
}