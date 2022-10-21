import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hellow_world/aplikasi_wisata.dart';
import 'package:hellow_world/expanded_example.dart';
import 'package:hellow_world/expanded_flexible.dart';
import 'package:hellow_world/main_screen.dart';
import 'package:hellow_world/media_query.dart';
import 'package:hellow_world/param_throw.dart';
import 'package:hellow_world/responsive_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        navigatorKey: navigatorKey,
        // scrollBehavior: MyCustomScrollBehavior(),
        theme: ThemeData(
          primarySwatch: Colors.blue,
          // fontFamily: 'Oswald',
        ),
        home: DemoPage());
  }
}

class DemoPage extends StatelessWidget {
  DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    // STILL BUGGY ??
    // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown]);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        title: const Heading(text: 'HELLOW WORLD!'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Center(
              child: BiggerText(text: 'hellow kworld!'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Icon(Icons.share),
                Icon(Icons.thumb_up),
                Icon(Icons.thumb_down),
              ],
            ),
            ComponenstExamples(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.keyboard_arrow_right),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MainScreen(),
              ));
        },
      ),
    );
  }
}

// class MyCustomScrollBehavior extends MaterialScrollBehavior {
//   // Override behavior methods and getters like dragDevices
//   @override
//   Set<PointerDeviceKind> get dragDevices => {
//         PointerDeviceKind.touch,
//         PointerDeviceKind.mouse,
//       };
//   // MediaQuery.of(navigatorKey.currentContext!).size.width > 600
//   //     ? {
//   //         PointerDeviceKind.touch,
//   //         PointerDeviceKind.mouse,
//   //       }
//   //     : {PointerDeviceKind.touch};
// }

class Heading extends StatelessWidget {
  final String text;

  // const Heading({required this.text});

  const Heading({Key? key, required this.text})
      : super(
          key: key,
        );
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class ComponenstExamples extends StatefulWidget {
  ComponenstExamples({Key? key}) : super(key: key);

  @override
  State<ComponenstExamples> createState() => _ComponenstExamplesState();
}

class _ComponenstExamplesState extends State<ComponenstExamples> {
  String? language;
  bool lightOn = false;
  String _name = '';
  bool agree = false;
  List<int> numberList = <int>[1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  String message = "Message for screen 2";

  TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Custom Font: Oswald',
          style: TextStyle(
            fontFamily: 'Oswald',
            fontSize: 30,
          ),
        ),
        DropdownButton<String>(
          items: const <DropdownMenuItem<String>>[
            DropdownMenuItem<String>(
              value: 'Dart',
              child: Text('Dart'),
            ),
            DropdownMenuItem<String>(
              value: 'Kotlin',
              child: Text('Kotlin'),
            ),
            DropdownMenuItem<String>(
              value: 'Swift',
              child: Text('Swift'),
            ),
          ],
          value: language,
          hint: Text('Select Language'),
          onChanged: (String? value) {
            setState(() {
              language = value;
            });
          },
        ),
        // TEXT INPUT AND DIALOG
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Write your name here...',
                  labelText: 'Your Name',
                ),
                onChanged: (String value) {
                  setState(() {
                    _name = value;
                  });
                },
                // onSubmitted: (String value) {
                //   setState(() {
                //     _name = value;
                //   });
                // },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: Text('Hello, $_name'),
                        );
                      });
                },
                child: Text('Submit'),
              )
            ],
          ),
        ),
        // SWITCH AND SNACKBAR
        Switch(
            value: lightOn,
            onChanged: (bool value) {
              setState(() {
                lightOn = value;
              });

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(lightOn ? 'Light On' : 'Light Off'),
                  duration: Duration(seconds: 1),
                ),
              );
            }),
        // RADIO BUTTON AND SNACKBAR
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Radio<String>(
                value: 'Dart',
                groupValue: language,
                onChanged: (String? value) {
                  setState(() {
                    language = value;
                    showSnackbar();
                  });
                },
              ),
              title: Text('Dart'),
            ),
            ListTile(
              leading: Radio<String>(
                value: 'Kotlin',
                groupValue: language,
                onChanged: (String? value) {
                  setState(() {
                    language = value;
                    showSnackbar();
                  });
                },
              ),
              title: Text('Kotlin'),
            ),
            ListTile(
              leading: Radio<String>(
                value: 'Swift',
                groupValue: language,
                onChanged: (String? value) {
                  setState(() {
                    language = value;
                    showSnackbar();
                  });
                },
              ),
              title: Text('Swift'),
            ),
          ],
        ),
        // CHECKBOX
        ListTile(
          leading: Checkbox(
            value: agree,
            tristate: false,
            onChanged: (bool? value) {
              setState(() {
                agree = value!;
              });
            },
          ),
          title: Text('Agree / Disagree'),
        ),
        // IMAGES EXAMPLES
        Center(
          child: Image.network(
            'https://picsum.photos/200/300',
            width: 200,
            height: 200,
          ),
        ),
        Center(
          child:
              Image.asset('assets/images/image1.png', width: 200, height: 200),
        ),

        SizedBox(
          height: 30,
        ),
        // CONTOH EXPANDED
        ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ExpandedExamplePage(),
                  ));
            },
            child: Text('EXPANDED EXAMPLE')),
        // CONTOH EXPANDED FLEXIBLE
        ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ExpandedFlexiblePage(),
                  ));
            },
            child: Text('EXPANDED FLEXIBLE EXAMPLE')),
        // CONTOH KIRIM PARAM KE HALMANA LAIN
        ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ParamThrowPage(
                      message: message,
                    ),
                  ));
            },
            child: Text('PARAM THROW EXAMPLE')),
        // CONTOH MEDIA QUERY
        ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MediaQueryPage(),
                  ));
            },
            child: Text('MEDIA QUERY EXAMPLE')),
        // CONTOH RESPONSEIVE PAGE
        ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResponsivePage(),
                  ));
            },
            child: Text('RESPONSEIVE PAGE EXAMPLE')),
        // APLIKASI WISATA SIMPLE
        ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AplikasiWisataPage(),
                  ));
            },
            child: Text('APLIKASI WISATA SIMPLE')),
        SizedBox(
          height: 30,
        ),
        // LIST TILES
        Container(
          height: 100,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: numberList.map((number) {
              return Container(
                height: 250,
                width: 250,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  border: Border.all(color: Colors.black),
                ),
                child: Center(
                  child: Text(
                    '$number', // Ditampilkan sesuai item
                    style: TextStyle(fontSize: 50),
                  ),
                ),
              );
            }).toList(), //numberList.map((number) {});
          ),
        ),
        // LIST BUILDER
        Container(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 250,
                width: 250,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  border: Border.all(color: Colors.black),
                ),
                child: Center(
                  child: Text(
                    '${numberList[index]}',
                    style: TextStyle(fontSize: 50),
                  ),
                ),
              );
            },
            itemCount: numberList.length,
          ),
        ),
        Divider(),
        // LIST SEPARATED
        Container(
          height: 100,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 250,
                width: 250,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  border: Border.all(color: Colors.black),
                ),
                child: Center(
                  child: Text(
                    '${numberList[index]}',
                    style: TextStyle(fontSize: 50),
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Container(
                width: 10,
              );
            },
            itemCount: numberList.length,
          ),
        ),
      ],
    );
  }

  void showSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$language selected'),
        duration: Duration(seconds: 1),
      ),
    );
  }
}

class BiggerText extends StatefulWidget {
  final String text;

  const BiggerText({required this.text});

  @override
  _BiggerTextState createState() => _BiggerTextState();
}

class _BiggerTextState extends State<BiggerText> {
  double _textSize = 16.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.red,
            border: Border.all(color: Colors.green, width: 3),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(widget.text, style: TextStyle(fontSize: _textSize)),
        ),
        ElevatedButton(
          child: const Text("Perbesar"),
          onPressed: () {
            setState(() {
              _textSize = 32.0;
            });
          },
        )
      ],
    );
  }
}
