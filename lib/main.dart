import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Profile Page Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Edit Profile'),
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

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 48, 24, 48),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Edit Profile',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 30.0,
                      color: Colors.blue[800],
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.all(16.0),
                    child: CircleAvatar(
                      radius: 87.0,
                      backgroundColor: Colors.blue[800],
                      child: CircleAvatar(
                          backgroundImage: NetworkImage('https://i.ytimg.com/vi/XSqi5s3rfqk/maxresdefault.jpg'),
                          radius: 80.0
                      ),
                    )
                ),
                UserProperty(
                  propertyName: "Name",
                  propertyValue: "Pickle Rick",
                ),
                UserProperty(
                  propertyName: "Phone",
                  propertyValue: "(123)-456-7890",
                ),
                UserProperty(
                  propertyName: "Email",
                  propertyValue: "rick@morty.com",
                ),
                UserProperty(
                  propertyName: "Tell us about yourself",
                  propertyValue: "Because I don’t respect therapy; because I’m a scientist; because I invent, transform, create, and destroy for a living, and when I don’t like something about the world, I change it.",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UserProperty extends StatefulWidget {
  final String propertyName;
  final String propertyValue;

  UserProperty({
    this.propertyName: "",
    this.propertyValue: ""
  });

  @override
  _UserPropertyState createState() => _UserPropertyState();
}

class _UserPropertyState extends State<UserProperty> {

  String textValue = 'defaultProperty';

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(4, 8, 4, 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                          child: Text(
                            '${widget.propertyName}',
                            style: TextStyle(
                                color: Colors.grey[400],
                                fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          '${widget.propertyValue}',
                          style: TextStyle(
                            fontWeight: FontWeight.w900
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.chevron_right,
                    color: Colors.grey[400],
                  ),
                )
              ],
            ),
            Divider(
                color: Colors.grey[400]
            )
          ],
        ),
    );
  }
}


