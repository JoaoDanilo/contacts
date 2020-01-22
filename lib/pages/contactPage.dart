import 'dart:io';

import 'package:contacts/helpers/contactHelper.dart';
import 'package:flutter/material.dart';

class ContactPage extends StatefulWidget {

  final Contact contact;

  ContactPage({this.contact});

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  bool _userEdited = false;
  Contact _editedContact;

  Widget main() {
    return Scaffold(
      appBar: _appBar(),
      floatingActionButton: _floatButton(),
      body: _body(),
    );
  }

  Widget _appBar(){
    return AppBar(
      backgroundColor: Colors.red,
      title: Text(_editedContact.name ?? "New contact"),
      centerTitle: true,
    );
  }

  Widget _floatButton() {
    return FloatingActionButton(
      backgroundColor: Colors.red,
      child: Icon(Icons.save),
      onPressed: (){},

    );
  }

  Widget _body() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          GestureDetector(
            child:  Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: _editedContact.img != null ? FileImage(File(_editedContact.img)): AssetImage("images/person.png")
                        ),
                      ),
                    ),
          ),
          TextField(
            decoration: InputDecoration(labelText: "Name"),
            controller: _nameController,
            onChanged: (text){
              _userEdited = true;
              setState(() {
                _editedContact.name = text;
              });
            },
          ),
          TextField(
            decoration: InputDecoration(labelText: "Email"),
            keyboardType: TextInputType.emailAddress,
            controller: _emailController,
            onChanged: (text){
              _userEdited = true;
              _editedContact.email = text;              
            },
          ),
          TextField(
            decoration: InputDecoration(labelText: "Phone"),
            keyboardType: TextInputType.phone,
            controller: _phoneController,
            onChanged: (text){
              _userEdited = true;
              _editedContact.phone = text;              
            },
          ),
        ],
      ),
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
      
      _nameController.text = _editedContact.name;
      _emailController.text = _editedContact.email;
      _phoneController.text = _editedContact.phone;
    }
  }
}