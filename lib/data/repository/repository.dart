import '../model/song.dart';
import 'package:music_app/data/source/source.dart';

abstract interface class Repository{
  Future<List<Song>?> loadData();
}

class DefaultRepository implements Repository{
  final _localDataSource = LocalDataSource();
  final _remoteDataSource = RemoteDataSource();

  @override
  Future<List<Song>?> loadData() async {
    List<Song> songs = [];
    await _remoteDataSource.loadData().then((remoteSongs) async {
      if(remoteSongs == null) {
        _localDataSource.loadData().then((localSongs) {
          if(localSongs != null) {
            songs.addAll(localSongs);
          }
        });
      } else{
        songs.addAll(remoteSongs);
      }
    });
    return songs;
  }
}