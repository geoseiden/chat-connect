import 'package:country_code_picker/country_localizations.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "No Save",
      supportedLocales: [Locale("en", "US")],
      localizationsDelegates: [CountryLocalizations.delegate],
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _controller = TextEditingController(text: '+');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 40, 30, 0),
          child: Image.asset("images/logo_dark.png"),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
          child: TextField(
            controller: _controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
                prefixIconColor: Colors.white,
                labelText: "Enter phone number With country code",
                border: OutlineInputBorder()),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
          child: Center(
            child: ElevatedButton.icon(
              icon: const Icon(
                Icons.send,
              ),
              label: const Text('Open In Whatsapp'),
              onPressed: () {
                sendMessage(context);
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
          ),
        ),
      ]),
    ));
  }

  final snackbar = const SnackBar(
    content: Text("Enter valid mobile number"),
    backgroundColor: Colors.red,
  );

  void sendMessage(context) {
    var txt = _controller.text;
    if (txt.length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    } else {
      _launchURL(txt);
    }
  }

  // ignore: prefer_final_fields
  var _url = "whatsapp://send?phone=";
  void _launchURL(txt) async => await canLaunch(_url + txt)
      ? await launch(_url + txt):
      ScaffoldMessenger.of(context).showSnackBar(
  const SnackBar(
    duration: Duration(seconds: 5),
    content: Text("Can't find Wahtsapp"),
    backgroundColor: Colors.red,
  )
);
}
