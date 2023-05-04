import '../../common/drop_menu.dart';
import '../../constants/color.dart';
import '../widget/news_widgets.dart';
import '../../utils/snackbar.dart';
import '../../utils/url_launcher.dart';

import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../../utils/tts.dart';
import '../../utils/navigator.dart';

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

  Future<void> shareApp() async {
    try {
      const urlPreview = "https://github.com/swarajkumarsingh/S_Dictionary";
      await Share.share(
          "GaadiDho is an Instant Bike Washing & Shining Subscription Service. GaadhiDho provides monthly subscription for Bike Wash, We are opening our Bike Washing Points on every 5 km to provide instant bike washing service.Free Download it from Google PlayStore  \n\n$urlPreview");
    } catch (e) {
      showSnackBar(msg: "Unable to share, Please try again later.");
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
            onTap: () async => await shareApp(),
            child: Container(
              margin: const EdgeInsets.only(right: 16),
              child: const Icon(
                Icons.share_outlined,
                size: 25,
                color: Colors.black,
              ),
            ),
          ),
          const DropMenu(),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NewsImageWidget(widget: widget),
              const SizedBox(height: 20),
              NewsTitleWidget(widget: widget),
              const SizedBox(height: 20),
              NewsPublishedAtWidget(widget: widget),
              NewsAuthorWidget(widget: widget),
              const SizedBox(height: 20),
              NewsDescWidget(widget: widget),
              const Divider(),
              MoreOnThisNewsWidget(widget: widget)
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
