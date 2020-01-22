
import 'package:flutter/material.dart';
import 'package:contacts/helpers/contactHelper.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  ContactHelper helper = ContactHelper();
  List<Contact> contacts = List();


  Widget main() {
    return Scaffold(
      appBar: _appBar(),
      backgroundColor: Colors.white,
      floatingActionButton: _floatButton(),
      body: _body(),
    );
  }

  Widget _appBar() {
    return  AppBar(
              title: Text("Contacts"),
              backgroundColor: Colors.red,
              centerTitle: true,
            );
  }

  Widget _floatButton() {
    return  FloatingActionButton(
              onPressed: (){},
              child: Icon(Icons.add),
              backgroundColor: Colors.red,
            );
  }

  Widget _body() {
    return  ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: contacts.length,
              itemBuilder:  (context, index){

                            },
            );
  }

  @override
  Widget build(BuildContext context) {
    return main();
  }

  @override
  void initState() {
    super.initState();
    helper.getAll().then((list){
      setState(() {
        contacts = list;
      });      
    });
  }
}