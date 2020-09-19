import 'package:flutter/material.dart';
import 'edit_property.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Profile Page Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/editprofile',
      routes: {
        '/editprofile': (context) => EditProfile(title: 'Edit Profile'),
        '/editname': (context) => EditProperty(question: 'What\'s your name?', labels: ['First Name', 'Last Name'], hintText: 'Enter name'),
        '/editphone': (context) => EditProperty(question: 'What\'s your phone number?', labels: ['Your phone number'], hintText: 'Enter your phone number'),
        '/editemail': (context) => EditProperty(question: 'What\'s your email?', labels: ['Your email address'], hintText: 'Enter your email address'),
        '/editintro': (context) => EditProperty(question: 'What type of passenger are you?', labels: ['Write a little bit about yourself. Do you like chatting? Are you a smoker? Do you bring pets with you? Etc.'], hintText: 'Tell us about yourself',),
      }
    );
  }
}

class EditProfile extends StatefulWidget {
  EditProfile({Key key, this.title}) : super(key: key);

  final String title;
  final List<Map> userProperties = [
    {
      "name": "Name",
      "route": '/editname',
      "defaultValues": ["Mark", "Smith"]
    },
    {
      "name": "Phone",
      "route": '/editphone',
      "fields": ["Your phone number"],
      "defaultValues": ["123-456-789"]
    },
    {
      "name": "Email",
      "route": '/editemail',
      "fields": ["Your email address"],
      "defaultValues": ["a@b.com"]
    },
    {
      "name": "Tell us about yourself",
      "route": '/editintro',
      "fields": ["TMAY text"],
      "defaultValues": ["I'm funny"]
    },
  ];


  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

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
                    '${widget.title}',
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
                          backgroundImage: NetworkImage('https://vignette.wikia.nocookie.net/bojackhorseman/images/6/65/Therobin.png/revision/latest/window-crop/width/200/x-offset/0/y-offset/0/window-width/471/window-height/471?cb=20190201040318'),
                          radius: 80.0
                      ),
                    )
                ),
                Column(
                  children: widget.userProperties.map((property) => UserProperty(
                    propertyName: property["name"],
                    route: property["route"],
                    values: property["defaultValues"]
                  )).toList(),
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
  List<String> values;
  final String route;

  UserProperty({
    this.propertyName: "",
    this.route: "",
    this.values
  });

  @override
  _UserPropertyState createState() => _UserPropertyState();
}

class _UserPropertyState extends State<UserProperty> {

  List<String> currentValues = ["",""];

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          children: <Widget>[
            FlatButton(
              padding: EdgeInsets.all(0.0),
              onPressed: () async {
                dynamic userInput = await Navigator.pushNamed(context, '${widget.route}', arguments: currentValues);
                print(userInput);
                setState(() {
                  if (userInput != null){ // prevent updating when pressing back button
                    currentValues = userInput;
                  }
                });
              },
              splashColor: Colors.transparent,
              child: Row(
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
                            widget.propertyName == 'Name' ? '${currentValues[0]} ${currentValues[1]}' : '${currentValues[0]}',
                            style: TextStyle(
                              fontWeight: FontWeight.w900
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: Colors.grey[400],
                  ),
                ],
              ),
            ),
            Divider(
                color: Colors.grey[400]
            )
          ],
        ),
    );
  }
}


