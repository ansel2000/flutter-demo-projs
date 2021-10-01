import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'components/custom_list_tile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MusicPlayer(),
    );
  }
}

class MusicPlayer extends StatefulWidget {
  @override
  _MusicPlayer createState() => _MusicPlayer();
}

class _MusicPlayer extends State<MusicPlayer> {
  List musicList = [
    {
      'title': "Sun and His Daughter",
      'singer': "Eugenio Mininni",
      'url':
          "https://assets.mixkit.co/music/preview/mixkit-sun-and-his-daughter-580.mp3",
      'coverUrl':
          "https://s3-eu-west-1.amazonaws.com/images.castcall.blue-compass.com/portfolio/1561/1561528x300.webp"
    },
    {
      'title': "Sleepy Cat",
      'singer': "Alejandri Magana",
      'url': "https://assets.mixkit.co/music/preview/mixkit-sleepy-cat-135.mp3",
      'coverUrl':
          "https://d1csarkz8obe9u.cloudfront.net/posterpreviews/rap-mixtape-cover-art-design-template-ca79baae8c3ee8f1112ae28f7bfaa1e0.jpg?ts=1592629635"
    },
    {
      'title': "Sun and His Daughter",
      'singer': "Eugenio Mininni",
      'url':
          "https://assets.mixkit.co/music/preview/mixkit-sun-and-his-daughter-580.mp3",
      'coverUrl':
          "https://s3-eu-west-1.amazonaws.com/images.castcall.blue-compass.com/portfolio/1561/1561528x300.webp"
    },
    {
      'title': "Sleepy Cat",
      'singer': "Alejandri Magana",
      'url': "https://assets.mixkit.co/music/preview/mixkit-sleepy-cat-135.mp3",
      'coverUrl':
          "https://d1csarkz8obe9u.cloudfront.net/posterpreviews/rap-mixtape-cover-art-design-template-ca79baae8c3ee8f1112ae28f7bfaa1e0.jpg?ts=1592629635"
    },
    {
      'title': "Sun and His Daughter",
      'singer': "Eugenio Mininni",
      'url':
          "https://assets.mixkit.co/music/preview/mixkit-sun-and-his-daughter-580.mp3",
      'coverUrl':
          "https://s3-eu-west-1.amazonaws.com/images.castcall.blue-compass.com/portfolio/1561/1561528x300.webp"
    },
    {
      'title': "Sleepy Cat",
      'singer': "Alejandri Magana",
      'url': "https://assets.mixkit.co/music/preview/mixkit-sleepy-cat-135.mp3",
      'coverUrl':
          "https://d1csarkz8obe9u.cloudfront.net/posterpreviews/rap-mixtape-cover-art-design-template-ca79baae8c3ee8f1112ae28f7bfaa1e0.jpg?ts=1592629635"
    },
  ];

  String currentTitle = "Sleepy Cat";
  String currentCover =
      "https://d1csarkz8obe9u.cloudfront.net/posterpreviews/rap-mixtape-cover-art-design-template-ca79baae8c3ee8f1112ae28f7bfaa1e0.jpg?ts=1592629635";
  String currentSinger = "Alejandri Magana";
  IconData btnIcon = Icons.play_arrow;

  AudioPlayer audioPlayer = new AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);
  bool isPlaying = false;
  String currentSong = "";

  Duration duration = new Duration();
  Duration position = new Duration();

  void playMusic(String url) async {
    if (isPlaying && currentSong != url) {
      audioPlayer.pause();
      int result = await audioPlayer.play(url);
      if (result == 1) {
        setState(() {
          currentSong = url;
        });
      }
    } else if (!isPlaying) {
      int result = await audioPlayer.play(url);
      if (result == 1) {
        setState(() {
          isPlaying = true;
          btnIcon = Icons.play_arrow;
        });
      }
    }
    audioPlayer.onDurationChanged.listen((event) {
      setState(() {
        duration = event;
      });
    });

    audioPlayer.onAudioPositionChanged.listen((event) {
      setState(() {
        position = event;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "My Playlist",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
      ),
      body: Column(children: [
        Expanded(
          child: ListView.builder(
              itemCount: musicList.length,
              itemBuilder: (context, index) => customListTile(
                    onTap: () {
                      playMusic(musicList[index]['url']);
                      setState(() {
                        currentTitle = musicList[index]['title'];
                        currentCover = musicList[index]['coverUrl'];
                        currentSinger = musicList[index]['singer'];
                      });
                    },
                    title: musicList[index]['title'],
                    singer: musicList[index]['singer'],
                    cover: musicList[index]['coverUrl'],
                  )),
        ),
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
              color: Color(0x55212121),
              blurRadius: 8.0,
            ),
          ]),
          child: Column(
            children: [
              Slider.adaptive(
                value: position.inSeconds.toDouble(),
                min: 0.0,
                max: duration.inSeconds.toDouble(),
                onChanged: (value) async {
                  await audioPlayer.seek(Duration(seconds: value.toInt()));
                  await audioPlayer.resume();
                },
              ),
              Padding(
                padding:
                    const EdgeInsets.only(bottom: 8.0, left: 12.0, right: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 60.0,
                      width: 60.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                        image:
                            DecorationImage(image: NetworkImage(currentCover)),
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            currentTitle,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            currentSinger,
                            style:
                                TextStyle(color: Colors.grey, fontSize: 16.0),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        if (isPlaying) {
                          audioPlayer.pause();
                          setState(() {
                            btnIcon = Icons.play_arrow;
                            isPlaying = false;
                          });
                        } else {
                          audioPlayer.resume();
                          setState(() {
                            btnIcon = Icons.pause;
                            isPlaying = true;
                          });
                        }
                      },
                      iconSize: 42.0,
                      icon: Icon(btnIcon),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
