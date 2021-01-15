/*
 * @Author: Charley
 * @Date: 2021-01-16 02:58:43
 * @LastEditors: Charley
 * @LastEditTime: 2021-01-16 04:02:04
 * @FilePath: /sample/lib/main.dart
 * @Description: In User Settings Edit
 */
import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uni_links/uni_links.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sample',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Sample'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String appLink;

  String uniLink;

  final _appLinks = AppLinks(
    // Called when a new uri has been redirected to the app
    onAppLink: (Uri uri) {
      // Do something (navigation, ...)
      print("url:$uri");
    },
  );

  @override
  void initState() {
    super.initState();
    getApplink();
    getUniLinks();
  }

  void getApplink() async {
    Uri appLinkUrl = await _appLinks.getInitialAppLink();
    setState(() {
      appLink = appLinkUrl.toString();
    });
  }

  void getUniLinks() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      String initialLink = await getInitialLink();
      // Parse the link and warn the user, if it is not correct,
      // but keep in mind it could be `null`.
      setState(() {
        uniLink = initialLink;
      });
    } on PlatformException {
      // Handle exception by warning the user their action did not succeed
      // return?
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("appLink:$appLink"),
              Text("uniLink:$uniLink"),
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
