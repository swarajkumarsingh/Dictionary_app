// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:dictionary/common/text_field.dart';
import 'package:dictionary/constants/color.dart';
import 'package:dictionary/dictionary/screens/dictionary_detail_screen.dart';
import 'package:dictionary/utils/navigator.dart';
import 'package:dictionary/utils/sf.dart';
import 'package:dictionary/utils/spaces.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DictionaryScreen extends StatefulWidget {
  const DictionaryScreen({super.key});

  @override
  State<DictionaryScreen> createState() => _DictionaryScreenState();
}

class _DictionaryScreenState extends State<DictionaryScreen> {
  List<String> _dictionaryHistory = [];
  final _promptController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    _dictionaryHistory = await sf.getDictionaryHistory();
    setState(() {});
  }

  Future<void> _pushToDictionaryDetailsScreen(String prompt) async {
    _promptController.clear();
    await sf.saveDictionaryHistory(prompt);
    await _init();
    appRouter.push(DictionaryDetailScreen(prompt: prompt));
  }

  @override
  void dispose() {
    _promptController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => appRouter.pop(),
          icon: const Icon(
            Icons.arrow_back_outlined,
            size: 30,
            color: Colors.black,
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Dictionary",
                  style: GoogleFonts.libreBaskerville(
                    textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                const VerticalSpace(height: 20),
                NameTextField(
                  text: "search here",
                  controller: _promptController,
                  iconData: Icons.search_outlined,
                  function: () async => await _pushToDictionaryDetailsScreen(
                    _promptController.text,
                  ),
                ),
                const VerticalSpace(height: 30),
                Row(
                  children: [
                    Text(
                      "Recent",
                      style: GoogleFonts.libreBaskerville(
                        textStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    Expanded(child: Container()),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colors.white,
                        foregroundColor: colors.red,
                        shadowColor: colors.red,
                      ),
                      onPressed: () async {
                        _promptController.clear();
                        await sf.clearDictionaryHistory();
                        await _init();
                      },
                      label: const Text("Clean"),
                      icon: Icon(
                        Icons.delete_outlined,
                        color: colors.red,
                      ),
                    )
                  ],
                ),
                const VerticalSpace(height: 20),
                _dictionaryHistory.isNotEmpty
                    ? ListView.separated(
                        itemCount: _dictionaryHistory.length,
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        separatorBuilder: (context, index) {
                          return const VerticalSpace(height: 10);
                        },
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () async =>
                                await _pushToDictionaryDetailsScreen(
                              _dictionaryHistory[index],
                            ),
                            child: Text(
                              _dictionaryHistory[index],
                              style: GoogleFonts.libreBaskerville(
                                textStyle: const TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    : const Text("Empty History")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
