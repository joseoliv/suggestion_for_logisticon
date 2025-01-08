import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Flutter code sample for [DataTable].

void main() => runApp(const SuggestionForLogisticon());

class SuggestionForLogisticon extends StatelessWidget {
  const SuggestionForLogisticon({super.key});

  @override
  Widget build(BuildContext context) {
    const List<String> sentences = [
      'If Socrates is not human, then Socrates is not mortal',
      'If Socrates is human, then Socrates is mortal',
      'Socrates is human',
      'If Socrates is not mortal, then Socrates is not human',
      // a long sentence
      'If Socrates is not mortal and Socrates lives in Greece, '
          'then Socrates is not human or Socrates did not live in Athenas'
    ];

    const List<String> premisses = [
      /// premisses of aristotelian syllogism
      'If Socrates is mortal, then Socrates is human',
      'Socrates is mortal',
    ];
    const chooseWhat =
        'Choose the correct conclusion for the following deduction';
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.ebGaramondTextTheme(
          Theme.of(context).textTheme,
        ),
        scrollbarTheme: ScrollbarThemeData(
          thumbVisibility: WidgetStateProperty.all(true),
          thumbColor:
              WidgetStateProperty.all(const Color.fromARGB(255, 158, 158, 158)),
          thickness: WidgetStateProperty.all(8.0),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('Logisticon suggestion')),
        //body: const DataTableExample(),
        body: const DeductionQuestionWidget(
          chooseWhat: chooseWhat,
          premisses: premisses,
          sentences: sentences,
        ),
      ),
    );
  }
}

const premissesShadowColor = Color.fromARGB(255, 91, 170, 153);
const sentencesShadowColor = Color.fromARGB(255, 91, 130, 170);

class DeductionQuestionWidget extends StatefulWidget {
  const DeductionQuestionWidget(
      {super.key,
      required this.chooseWhat,
      required this.premisses,
      required this.sentences});
  final List<String> sentences;
  final List<String> premisses;
  final String chooseWhat;

  @override
  State<DeductionQuestionWidget> createState() =>
      _DeductionQuestionWidgetState();
}

class _DeductionQuestionWidgetState extends State<DeductionQuestionWidget> {
  // List of random sentences to display

  final ScrollController _scrollbarController = ScrollController();
  late Color backgroundColor;
  late Offset distance = const Offset(5, 5);
  final blur = 15.0;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    const distance = Offset(5, 5);
    const blur = 15.0;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          //flex: 5,
          child: Scrollbar(
            controller: _scrollbarController,
            thumbVisibility: true,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ScrollConfiguration(
                behavior:
                    ScrollConfiguration.of(context).copyWith(scrollbars: false),
                child: ListView(
                  controller: _scrollbarController,
                  //primary: false,
                  shrinkWrap: true,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: blur,
                            offset: -distance, // changes position of shadow
                            color: Colors.white.withAlpha(200),
                            spreadRadius: -5,
                          ),
                          const BoxShadow(
                            blurRadius: blur,
                            offset: distance, // changes position of shadow
                            color: premissesShadowColor, //Color(0xFFA7A9AF),
                            spreadRadius: -5,
                          ),
                        ],
                      ),
                      margin: const EdgeInsets.fromLTRB(10, 10, 20, 10),
                      padding: const EdgeInsets.all(10),
                      child: _buildPremisses(),
                    ),
                    Container(
                      /// the border should have color blue
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: blur,
                            offset: -distance, // changes position of shadow
                            color: Colors.white,
                            spreadRadius: 1,
                          ),
                          const BoxShadow(
                            blurRadius: blur,
                            offset: distance, // changes position of shadow
                            color: sentencesShadowColor,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      margin: const EdgeInsets.fromLTRB(10, 10, 20, 10),
                      padding: const EdgeInsets.all(10),
                      child: _buildSentenceList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        _buildOptions(context),
        // Expanded(
        //   child: _buildOptions(context),
        // ),
      ],
    );
  }

  Widget _buildOptions(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              /// a grey border of 10px
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    blurRadius: blur,
                    offset: -distance, // changes position of shadow
                    color: Colors.white,
                    spreadRadius: 1,
                  ),
                  BoxShadow(
                    blurRadius: blur,
                    offset: distance, // changes position of shadow
                    color: const Color.fromARGB(255, 136, 91, 170),
                    spreadRadius: 1,
                  ),
                ],
              ),
              //margin: const EdgeInsets.fromLTRB(10, 10, 20, 10),
              padding: const EdgeInsets.all(10),
              child: const SizedBox(
                height: 70,
                child: Column(
                  children: [
                    Text('0/0   25% Correct', style: TextStyle(fontSize: 12)),
                    Text('Current Combo: 1', style: TextStyle(fontSize: 12)),
                    Text('Your best:     0', style: TextStyle(fontSize: 12)),
                  ],
                ),
              ),
            ),
            ShadowButton(
              onPressed: () {},
              backgroundColor: Colors.lightBlueAccent,
              shadowColor: const Color.fromARGB(255, 72, 1, 1),
              child: const Text('Verify'),
            ),
            const Row(
              children: [
                ShadowIcon(
                  icon: Icon(
                    Icons.question_mark_outlined,
                    color: Colors.blueGrey,
                    //size: 20,
                  ),
                  backgroundColor: Colors.lightGreenAccent,
                  iconColor: Colors.black87,
                  shadowColor:

                      /// the complement of lightGreenAccent
                      Color.fromARGB(255, 80, 34, 1),
                ),
                SizedBox(width: 15),
                ShadowIcon(
                  icon: Icon(Icons.history_outlined, color: Colors.black45),
                  backgroundColor: Color.fromARGB(255, 216, 150, 104),
                  iconColor: Colors.black45,
                  shadowColor: Color.fromARGB(255, 6, 24, 37),
                ),
                SizedBox(width: 10),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPremisses() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.chooseWhat,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        ListView.separated(
          shrinkWrap: true,
          itemCount: widget.premisses.length,
          separatorBuilder: (context, index) => Divider(
            height: 1,
            color: Colors.grey[200],
            thickness: 1,
            // indent: MediaQuery.of(context).size.width * 0.05, // 10% indent
            // endIndent: MediaQuery.of(context).size.width * 0.1, // 10% endIndent
          ),
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
            child:

                /// put the background of this row in a light grey color
                Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  /// use (a), (b), (c), ... base on index
                  '(${[
                    'i',
                    'ii',
                    'iii',
                    'iv',
                    'v',
                    'vi',
                    'vii',
                    'viii',
                    'ix',
                    'x'
                  ][index]})',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    widget.premisses[index],
                    style: const TextStyle(fontSize: 16),
                    maxLines: 2,
                    overflow: TextOverflow.visible,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSentenceList() {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: widget.sentences.length,
      separatorBuilder: (context, index) => Divider(
        height: 1,
        color: Colors.grey[200],
        thickness: 1,
        // indent: MediaQuery.of(context).size.width * 0.05, // 10% indent
        // endIndent: MediaQuery.of(context).size.width * 0.1, // 10% endIndent
      ),
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
        child:

            /// put the background of this row in a light grey color
            Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              /// use (a), (b), (c), ... base on index
              "(${String.fromCharCode(97 + index)})",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                widget.sentences[index],
                style: const TextStyle(fontSize: 16),
                maxLines: 2,
                overflow: TextOverflow.visible,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ShadowButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Widget child;
  final Color? backgroundColor;
  final Color? shadowColor;

  const ShadowButton(
      {super.key,
      required this.onPressed,
      required this.child,
      this.backgroundColor,
      this.shadowColor});

  @override
  State<ShadowButton> createState() => _ShadowButtonState();
}

class _ShadowButtonState extends State<ShadowButton> {
  @override
  Widget build(BuildContext context) {
    final backgroundColor =
        widget.backgroundColor ?? Theme.of(context).scaffoldBackgroundColor;
    final shadowColor =
        widget.shadowColor ?? const Color.fromARGB(255, 61, 61, 60);
    const distance = Offset(5, 5);
    const blur = 15.0;
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8), // Rounded corners
          boxShadow: [
            BoxShadow(
              blurRadius: blur,
              offset: -distance, // changes position of shadow
              color: Colors.white.withAlpha(200),
              spreadRadius: -5,
            ),
            BoxShadow(
              blurRadius: blur,
              offset: distance, // changes position of shadow
              color: shadowColor, //Color(0xFFA7A9AF),
              spreadRadius: -5,
            ),
          ],
        ),
        child: widget.child,
      ),
    );
  }
}

class ShadowIcon extends StatefulWidget {
  final Color? backgroundColor;
  final Color? shadowColor;
  final Color? iconColor;
  final Icon icon;
  const ShadowIcon(
      {super.key,
      this.backgroundColor,
      this.shadowColor,
      this.iconColor,
      required this.icon});

  @override
  State<ShadowIcon> createState() => _ShadowIconState();
}

class _ShadowIconState extends State<ShadowIcon> {
  @override
  Widget build(BuildContext context) {
    final backgroundColor =
        widget.backgroundColor ?? Theme.of(context).scaffoldBackgroundColor;
    final shadowColor =
        widget.shadowColor ?? const Color.fromARGB(255, 227, 172, 99);
    const distance = Offset(5, 5);
    const blur = 15.0;
    final iconColor = widget.iconColor ?? Colors.brown[300];

    return Container(
      width: 35,
      height: 35,
      //padding: const EdgeInsets.all(0.0),
      decoration: BoxDecoration(
        color: backgroundColor, // Sepia background color
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            blurRadius: blur,
            offset: -distance, // changes position of shadow
            color: Colors.white.withAlpha(200),
            spreadRadius: -5,
          ),
          BoxShadow(
            blurRadius: blur,
            offset: distance, // changes position of shadow
            color: shadowColor, //Color(0xFFA7A9AF),
            spreadRadius: -5,
          ),
        ],
      ),
      child: FittedBox(
        child: IconButton(
          icon: widget.icon,
          color: iconColor,
          onPressed: () {
            // Add your onPressed code here!
          },
        ),
      ),
    );
  }
}
