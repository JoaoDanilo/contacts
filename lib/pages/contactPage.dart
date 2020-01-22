import 'package:contacts/helpers/contactHelper.dart';
import 'package:flutter/material.dart';

class ContactPage extends StatefulWidget {

  final Contact contact;

  ContactPage({this.contact});

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {

  Contact _editedContact;

  Widget main() {
    return Scaffold(
      appBar: _appBar(),
      floatingActionButton: _floatButton(),
    );
  }

  Widget _appBar(){
    return AppBar(
      backgroundColor: Colors.red,
      title: Text(_editedContact.name ?? "New contact"),
    );
  }

  Widget _floatButton() {
    return FloatingActionButton(
      backgroundColor: Colors.red,
      child: Icon(Icons.save),
      onPressed: (){},

    );
  }

  @override
  Widget build(BuildContext context) {
    return main();
  }

  @override
  void initState() {
    super.initState();

    if(widget.contact == null){
      _editedContact = Contact();
    }
    else {
      _editedContact = Contact.fromMap(widget.contact.toMap());
    }
  }
}