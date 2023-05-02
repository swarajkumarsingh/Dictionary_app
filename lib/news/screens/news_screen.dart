import 'package:dictionary/news/services/news_services.dart';
import 'package:flutter/material.dart';

import '../../utils/tts.dart';
import '../../utils/navigator.dart';
import '../../utils/url_launcher.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen(
      {super.key,
      required this.image,
      required this.title,
      required this.description,
      required this.link,
      required this.author,
      required this.publishedAt,
      required this.content});

  final String author;
  final String content;
  final String description;
  final String image;
  final String link;
  final String publishedAt;
  final String title;

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

enum PlayStatus { playing, paused }

class _NewsScreenState extends State<NewsScreen> {
  PlayStatus _status = PlayStatus.paused;

  @override
  void initState() {
    tts.init();
    super.initState();
  }

  @override
  void dispose() {
    tts.stop();
    super.dispose();
  }

  IconData _getIcon() {
    switch (_status) {
      case PlayStatus.playing:
        return Icons.pause;
      case PlayStatus.paused:
      default:
        return Icons.play_arrow;
    }
  }

  void _toggleStatus() {
    setState(() {
      _status = _status == PlayStatus.playing
          ? PlayStatus.paused
          : PlayStatus.playing;
    });
  }

  Future<void> _toggleIconWhenAudioCompleted() async {
    tts.getTTS.setCompletionHandler(() async {
      await tts.stop();
      _toggleStatus();
    });
  }

  Future<void> _startNewsAudioImple() async {
    String content =
        "${widget.title}.  ${widget.description} news reported by ${widget.author} more on this news click the link below";

    _toggleStatus();
    await tts.speak(content);
  }

  Future<void> _startNewsAudio() async {
    if (_status == PlayStatus.playing) {
      await tts.pause();
      return _toggleStatus();
    }

    await _toggleIconWhenAudioCompleted();

    await _startNewsAudioImple();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.black),
        ),
        leading: InkWell(
          onTap: () => appRouter.pop(),
          child: const Icon(
            Icons.keyboard_backspace_outlined,
            size: 30,
            color: Colors.black,
          ),
        ),
        actions: [
          InkWell(
            onTap: () async => await newServices.shareApp(),
            child: Container(
              margin: const EdgeInsets.only(right: 16),
              child: const Icon(
                Icons.share_outlined,
                size: 25,
                color: Colors.black,
              ),
            ),
          ),
          InkWell(
            onTap: () async => await newServices.shareApp(),
            child: Container(
              margin: const EdgeInsets.only(right: 16),
              child: const Icon(
                Icons.more_vert_outlined,
                size: 25,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: Image.network(widget.image),
              ),
              const SizedBox(height: 20),
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Date: ${widget.publishedAt}",
                style: const TextStyle(
                    color: Color.fromARGB(255, 81, 81, 81), fontSize: 15),
              ),
              Text(
                "Author: ${widget.author}",
                style: const TextStyle(
                    color: Color.fromARGB(255, 81, 81, 81), fontSize: 15),
              ),
              const SizedBox(height: 20),
              Text(
                widget.description,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const Divider(),
              InkWell(
                onTap: () => urlLauncher.launchURL(widget.link),
                child: RichText(
                  text: TextSpan(
                    text: 'More on this news: ',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: widget.link,
                        style: const TextStyle(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Speak"),
        tooltip: "Speak",
        backgroundColor: const Color.fromARGB(255, 198, 197, 197),
        onPressed: () async => _startNewsAudio(),
        icon: Icon(_getIcon(), color: Colors.black),
      ),
    );
  }
}
