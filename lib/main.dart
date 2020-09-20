import 'package:flutter/material.dart';
import 'edit_property.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  String emailValidator(email){
    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
    return emailValid ? null : "Please enter a valid email address";
  }

  String phoneValidator(phoneNumber){
    // assuming 10 digit US phone numbers
    bool phoneValid = RegExp(r"^(?:[+0]9)?[0-9]{10}$").hasMatch(phoneNumber);
    return phoneValid ? null : "Please enter a valid 10 digit phone number";
  }

  String novalidate(input){
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Profile Page Demo',
      debugShowCheckedModeBanner: false,
      initialRoute: '/editprofile',
      routes: {
        '/editprofile': (context) => EditProfile(title: 'Edit Profile'),
        '/editname': (context) => EditProperty(question: 'What\'s your name?', labels: ['First Name', 'Last Name'], hintText: 'Enter name', validator: novalidate,),
        '/editphone': (context) => EditProperty(question: 'What\'s your phone number?', labels: ['Your phone number'], hintText: 'Enter your phone number', validator: phoneValidator,),
        '/editemail': (context) => EditProperty(question: 'What\'s your email?', labels: ['Your email address'], hintText: 'Enter your email address', validator: emailValidator),
        '/editintro': (context) => EditProperty(question: 'What type of passenger are you?', labels: ['Write a little bit about yourself. Do you like chatting? Are you a smoker? Do you bring pets with you? Etc.'], hintText: 'Tell us about yourself', validator: novalidate,),
      }
    );
  }
}

class EditProfile extends StatefulWidget {
  EditProfile({Key key, this.title}) : super(key: key);

  final String title;
  final List<Map> userProperties = [
    {
      "property": "name", // firstName lastName?
      "label": "Name",
      "route": '/editname',
    },
    {
      "property": "phone",
      "label": "Phone",
      "route": '/editphone',
    },
    {
      "property": "email",
      "label": "Email",
      "route": '/editemail',
    },
    {
      "property": "intro",
      "label": "Tell us about yourself",
      "route": '/editintro',
    },
  ];


  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  // Default User info
  Map user = {
    "firstName": "Adam",
    "lastName": "Gyarmati",
    "phone": "1234567890",
    "email": "adam@gmail.com",
    "intro": "Hi, my name is Adam. I live in San Francisco and enjoy coding and rock climbing.",
  };

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
                          backgroundImage: NetworkImage('https://bit.ly/32M6lH5'),
                          radius: 80.0
                      ),
                    )
                ),
                Column(
                  children: widget.userProperties.map((userProperty) => UserProperty(
                    property: userProperty["property"],
                    label: userProperty["label"],
                    route: userProperty["route"],
                    parent: this
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

  final _EditProfileState parent;

  final String property;
  final String label;
  final String route;

  UserProperty({
    this.property,
    this.parent,
    this.label: "",
    this.route: "",
  });

  @override
  _UserPropertyState createState() => _UserPropertyState();
}

class _UserPropertyState extends State<UserProperty> {

  formatPhoneNumber(phoneNumber){
    String formattedPhoneNumber = "(" + phoneNumber.substring(0,3) + ") " +
        phoneNumber.substring(3,6) + "-" +phoneNumber.substring(6,phoneNumber.length);
    return formattedPhoneNumber;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          children: <Widget>[
            FlatButton(
              padding: EdgeInsets.all(0.0),
              onPressed: () async {
                // pass current state as a list, so that pages with multiple values (e.g. name) can build multiple form fields
                dynamic currentValues = widget.property == "name" ? [widget.parent.user["firstName"], widget.parent.user["lastName"]] : [widget.parent.user[widget.property]];
                dynamic userInput = await Navigator.pushNamed(context, '${widget.route}', arguments: currentValues);
                widget.parent.setState((){
                  if (widget.property == "name"){
                    widget.parent.user["firstName"] = userInput[0];
                    widget.parent.user["lastName"] = userInput[1];
                  } else {
                    widget.parent.user[widget.property] = userInput[0];
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
                              '${widget.label}',
                              style: TextStyle(
                                  color: Colors.grey[400],
                                  fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            widget.property == "name" ?
                              '${widget.parent.user["firstName"]} ${widget.parent.user["lastName"]}' :
                              widget.property == "phone" ?
                                formatPhoneNumber(widget.parent.user[widget.property]) :
                                widget.parent.user[widget.property],
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


