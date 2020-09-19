import 'package:flutter/material.dart';

class EditProperty extends StatefulWidget {

  final String question;
  final String currentValue;
  final List<String> labels;
  final String hintText;

  EditProperty({
    this.question: "",
    this.labels,
    this.currentValue: "",
    this.hintText
  });

  @override
  _EditPropertyState createState() => _EditPropertyState();
}

class _EditPropertyState extends State<EditProperty> {

  final formKey = GlobalKey<FormState>();
  List<String> userInput = ["",""];

  void submit(){
    formKey.currentState.save();
    print(userInput);
    Navigator.pop(context, userInput);
  }

  @override
  Widget build(BuildContext context) {

    final List<String> currentValues = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 48, 8, 16),
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                  onPressed: (){
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 48),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          '${widget.question}',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 30.0,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12, 16, 12, 16),
                      child: Form(
                        key: formKey,
                        child: Row(
                          children:
                          widget.labels.asMap().entries.map((entry) =>
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                                child: Container(
                                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1.0,
                                          color: Colors.grey[300]
                                      )
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          '${entry.value}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey[400],
                                          ),
                                        ),
                                      ),
                                      TextFormField(
                                        initialValue: currentValues[entry.key],
                                        onSaved: (input) => userInput[entry.key] = input,
//                                          controller: textFieldController,
                                        maxLines: null,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18
                                        ),
                                        decoration: InputDecoration(
                                            isDense:true,
                                            border: InputBorder.none,
                                            hintText: widget.hintText
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ).toList()
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: RaisedButton(
                          onPressed: () {
                            submit();
                          },
                          color: Colors.black,
                          textColor: Colors.white,
                          elevation: 8,
                          splashColor: Colors.transparent,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                                'Update',
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
