import 'package:dictionary/common/loader.dart';
import 'package:dictionary/common/string_extension.dart';
import 'package:dictionary/constants/color.dart';
import 'package:dictionary/dictionary/screens/dictionary_screen.dart';
import 'package:dictionary/dictionary/services/dictionary_services_impl.dart';
import 'package:dictionary/utils/navigator.dart';
import 'package:dictionary/utils/spaces.dart';
import 'package:dictionary/utils/tts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/dictionary.dart';

class DictionaryDetailScreen extends StatelessWidget {
  const DictionaryDetailScreen({super.key, required this.prompt});
  final String prompt;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => appRouter.push(const DictionaryScreen()),
          icon: Icon(
            Icons.arrow_back_outlined,
            size: 30,
            weight: 30,
            color: colors.black,
          ),
        ),
        elevation: 0,
      ),
      body: FutureBuilder<Dictionary?>(
        future: dictionaryServicesImpl.get(prompt),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            Dictionary dictionary = snapshot.data;
            return WidgetTree(
              dictionary: dictionary,
              prompt: prompt,
            );
          }
          if (snapshot.hasError) {
            return const Center(child: Text("Error connecting to server"));
          }
          return const Loader();
        },
      ),
    );
  }
}

class WidgetTree extends StatelessWidget {
  const WidgetTree({
    super.key,
    required this.prompt,
    required this.dictionary,
  });
  final Dictionary dictionary;
  final String prompt;

  @override
  Widget build(BuildContext context) {
    // Total nums of meanings
    int totalResults = 0;
    for (var i = 0; i < dictionary.meanings.length; i++) {
      totalResults = totalResults + dictionary.meanings[i].definitions.length;
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              prompt.capitalize,
              style: GoogleFonts.libreBaskerville(
                textStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 35,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ...dictionary.phonetics
                    .map(
                      (e) => Text(
                        e.text,
                        style: TextStyle(
                          color: colors.blue,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                    .toList(),
                IconButton(
                  onPressed: () => tts.speak(prompt),
                  icon: Icon(
                    Icons.volume_up_outlined,
                    color: colors.blue,
                  ),
                ),
              ],
            ),
            const VerticalSpace(height: 10),
            Row(
              children: [
                ...dictionary.meanings
                    .map(
                      (e) => Container(
                        width: 50,
                        height: 30,
                        margin: const EdgeInsets.only(right: 10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          border: Border.all(
                            color: colors.blue,
                            width: 2,
                          ),
                        ),
                        child: Text(
                          e.partOfSpeech,
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                    )
                    .toList()
              ],
            ),
            const VerticalSpace(height: 20),
            Row(
              children: [
                Text(
                  "Definations".toUpperCase(),
                  style: TextStyle(
                    color: colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const HorizontalSpace(width: 5),
                Text(
                  totalResults.toString(),
                  style: TextStyle(
                    color: colors.grey,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const VerticalSpace(height: 10),
            DictionaryListTileWidget(dictionary: dictionary),
            // Example(dictionary: dictionary),
            Text(
              "Source Url",
              style: TextStyle(
                color: colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            Row(
              children: [
                Text(
                  "•",
                  style: TextStyle(
                    color: colors.black,
                    fontSize: 18,
                  ),
                ),
                const HorizontalSpace(width: 10),
                Text(
                  dictionary.sourceUrls[0],
                  style: TextStyle(
                    color: colors.blue,
                    decoration: TextDecoration.underline,
                    fontSize: 18,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class Example extends StatefulWidget {
  const Example({
    super.key,
    required this.dictionary,
  });

  final Dictionary dictionary;

  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < widget.dictionary.meanings.length; i++)
          ListView.builder(
            itemCount: widget.dictionary.meanings[i].definitions.length,
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemBuilder: (context, index) {
              return ListTile(
                leading: const Text(
                  "•",
                ),
                minLeadingWidth: 10,
                title: Text(
                  widget.dictionary.meanings[0].definitions[index].definition,
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.volume_up_outlined),
                  onPressed: () {
                    tts.speak(
                      widget
                          .dictionary.meanings[i].definitions[index].definition,
                    );
                  },
                ),
              );
            },
          ),
      ],
    );
  }
}

class DictionaryListTileWidget extends StatelessWidget {
  const DictionaryListTileWidget({
    super.key,
    required this.dictionary,
  });

  final Dictionary dictionary;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: dictionary.meanings[0].definitions.length,
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      itemBuilder: (context, index) {
        // dictionary.meanings[0].definitions[index].definition,
        return ListTile(
          leading: const Text(
            "•",
            style: TextStyle(
              fontSize: 30,
            ),
          ),
          minLeadingWidth: 10,
          title: Text(
            dictionary.meanings[0].definitions[index].definition,
          ),
          trailing: IconButton(
            icon: const Icon(Icons.volume_up_outlined),
            onPressed: () {
              tts.speak(
                dictionary.meanings[0].definitions[index].definition,
              );
            },
          ),
        );
      },
    );
  }
}
