import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class LanguageTranslation extends StatefulWidget {
  const LanguageTranslation({super.key});

  @override
  State<LanguageTranslation> createState() => _LanguageTranslationState();
}

class _LanguageTranslationState extends State<LanguageTranslation> {
  var languages = ['Urdu', 'English', 'Arabic'];
  var originLanguage = 'From';
  var destinationLanguage = 'To';
  var output = "";
  TextEditingController languageController = TextEditingController();
  FocusNode textFieldFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    textFieldFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    textFieldFocusNode.dispose();
    languageController.dispose();
    super.dispose();
  }

  void translate(String src, String dest, String input) async {
    GoogleTranslator translator = GoogleTranslator();
    var translation = await translator.translate(input, from: src, to: dest);
    setState(() {
      output = translation.text.toString();
    });
    if (src == '--' || dest == '--') {
      setState(() {
        output = 'Fail to translate';
      });
    }
  }

  String getlanguageCode(String language) {
    if (language == "English") {
      return 'en';
    } else if (language == "Urdu") {
      return 'ur';
    } else if (language == "Arabic") {
      return 'ar';
    }
    return "--";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff10223d),
      appBar: AppBar(
        title: Text("Language Translator"),
        centerTitle: true,
        backgroundColor: Color(0xff10223d),
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 24),
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 800),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Card(
                        color: Color(0xff1a2e4d),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Wrap(
                                alignment: WrapAlignment.start,
                                spacing: 12,
                                runSpacing: 12,
                                children: [
                                  SizedBox(
                                    width: 240,
                                    child: DropdownButtonFormField<String>(
                                      value: languages.contains(originLanguage)
                                          ? originLanguage
                                          : null,
                                      dropdownColor: Colors.white,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white.withOpacity(
                                          0.1,
                                        ),
                                        labelText: 'From',
                                        labelStyle: TextStyle(
                                          color: Colors.white,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          borderSide: BorderSide(
                                            color: Colors.white24,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          borderSide: BorderSide(
                                            color: Colors.white70,
                                          ),
                                        ),
                                      ),
                                      icon: Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Colors.white,
                                      ),
                                      items: languages
                                          .map(
                                            (lang) => DropdownMenuItem<String>(
                                              value: lang,
                                              child: Text(lang),
                                            ),
                                          )
                                          .toList(),
                                      onChanged: (v) {
                                        setState(() => originLanguage = v!);
                                      },
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      if (languages.contains(originLanguage) &&
                                          languages.contains(
                                            destinationLanguage,
                                          )) {
                                        setState(() {
                                          final tmp = originLanguage;
                                          originLanguage = destinationLanguage;
                                          destinationLanguage = tmp;
                                        });
                                      }
                                    },
                                    icon: Icon(
                                      Icons.swap_horiz,
                                      color: Colors.white,
                                    ),
                                    tooltip: 'Swap languages',
                                  ),
                                  SizedBox(
                                    width: 240,
                                    child: DropdownButtonFormField<String>(
                                      value:
                                          languages.contains(
                                            destinationLanguage,
                                          )
                                          ? destinationLanguage
                                          : null,
                                      dropdownColor: Colors.white,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white.withOpacity(
                                          0.1,
                                        ),
                                        labelText: 'To',
                                        labelStyle: TextStyle(
                                          color: Colors.white,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          borderSide: BorderSide(
                                            color: Colors.white24,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          borderSide: BorderSide(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      icon: Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Colors.white,
                                      ),
                                      items: languages
                                          .map(
                                            (lang) => DropdownMenuItem<String>(
                                              value: lang,
                                              child: Text(lang),
                                            ),
                                          )
                                          .toList(),
                                      onChanged: (v) {
                                        setState(
                                          () => destinationLanguage = v!,
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16),
                              TextFormField(
                                controller: languageController,
                                focusNode: textFieldFocusNode,
                                cursorColor: Colors.white,
                                style: TextStyle(color: Colors.white),
                                minLines: 3,
                                maxLines: 6,
                                decoration: InputDecoration(
                                  hintText: 'Type text to translate...',
                                  hintStyle: TextStyle(color: Colors.white70),
                                  filled: true,
                                  fillColor: Colors.white.withOpacity(0.06),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                      color: Colors.white24,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                      color: Colors.white70,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 16),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: textFieldFocusNode.hasFocus
                                        ? Colors.white
                                        : Color(0xff2b3c5a),
                                    padding: EdgeInsets.symmetric(vertical: 14),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  onPressed: () {
                                    translate(
                                      getlanguageCode(originLanguage),
                                      getlanguageCode(destinationLanguage),
                                      languageController.text.toString(),
                                    );
                                  },
                                  icon: Icon(Icons.translate),
                                  label: Text('Translate'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      if (output.isNotEmpty)
                        Card(
                          color: Color(0xff1a2e4d),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  'Translation',
                                  style: TextStyle(color: Colors.white70),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  output,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    height: 1.4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
