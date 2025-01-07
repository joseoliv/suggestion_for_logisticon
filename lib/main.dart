import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Flutter code sample for [DataTable].

void main() => runApp(const SuggestionForLogisticon());

class SuggestionForLogisticon extends StatelessWidget {
  const SuggestionForLogisticon({super.key});

  @override
  Widget build(BuildContext context) {
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
        body: DeductionQuestionWidget(),
      ),
    );
  }
}

const premissesShadowColor = Color.fromARGB(255, 91, 170, 153);
const sentencesShadowColor = Color.fromARGB(255, 91, 130, 170);

class DeductionQuestionWidget extends StatelessWidget {
  // List of random sentences to display
  final List<String> sentences = [
    "The quick brown fox jumps over the lazy dog.",
    "Life is what happens when you're busy making other plans.",
    "To be yourself in a world that is constantly trying to make you something else is the greatest accomplishment.",
    "If you cannot do great things, do small things in a great way.",
    "The only limit to our realization of tomorrow is our doubts of today."
  ];

  final List<String> premisses = [
    /// premisses of aristotelian syllogism
    'All mammals are warm-blooded animals.',
    'All humans are mammals.',
  ];

  DeductionQuestionWidget({super.key});

  final ScrollController _scrollbarController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    const distance = Offset(5, 5);
    const blur = 15.0;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
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
      height: 150,
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: Column(
            // shrinkWrap: true,
            // primary: false,
            //controller: _scrollbarOptionsController,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ShadowButton(
                    onPressed: () {},
                    child: const Text('Add'),
                  ),
                  ShadowButton(
                    onPressed: () {},
                    child: const Text('Edit'),
                  ),
                  ShadowButton(
                    onPressed: () {},
                    child: const Text('Delete'),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ShadowButton(
                    onPressed: () {},
                    child: const Text('Save'),
                  ),
                  ShadowButton(
                    onPressed: () {},
                    child: const Text('Cancel'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPremisses() {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: premisses.length,
      separatorBuilder: (context, index) => Divider(
        height: 1,
        color: Colors.grey[200],
        thickness: 1,
        // indent: MediaQuery.of(context).size.width * 0.05, // 10% indent
        // endIndent: MediaQuery.of(context).size.width * 0.1, // 10% endIndent
      ),
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
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
                premisses[index],
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

  Widget _buildSentenceList() {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: sentences.length,
      separatorBuilder: (context, index) => Divider(
        height: 1,
        color: Colors.grey[200],
        thickness: 1,
        // indent: MediaQuery.of(context).size.width * 0.05, // 10% indent
        // endIndent: MediaQuery.of(context).size.width * 0.1, // 10% endIndent
      ),
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
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
                sentences[index],
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

class DataTableExample extends StatefulWidget {
  const DataTableExample({super.key});

  @override
  State<DataTableExample> createState() => _DataTableExampleState();
}

class _DataTableExampleState extends State<DataTableExample> {
  static const int numItems = 20;
  List<bool> selected = List<bool>.generate(numItems, (int index) => false);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: DataTable(
        columns: const <DataColumn>[
          DataColumn(
            label: Text('  '),
          ),
        ],
        rows: List<DataRow>.generate(
          numItems,
          (int index) => DataRow(
            cells: <DataCell>[DataCell(Text('Row $index'))],
          ),
        ),
      ),
    );
  }
}

class ShadowButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;

  const ShadowButton({super.key, required this.onPressed, required this.child});

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    const distance = Offset(5, 5);
    const blur = 15.0;
    return GestureDetector(
      onTap: onPressed,
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
            const BoxShadow(
              blurRadius: blur,
              offset: distance, // changes position of shadow
              color: Color.fromARGB(255, 227, 172, 99), //Color(0xFFA7A9AF),
              spreadRadius: -5,
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}
