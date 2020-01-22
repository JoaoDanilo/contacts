import 'dart:io';
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
                return _contactCard(context, index);
              },
            );
  }

  Widget _contactCard(BuildContext context, int index){
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            children: <Widget>[
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: contacts[index].img != null ? FileImage(File(contacts[index].img)): AssetImage("images/person.png")
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      contacts[index].name ?? "",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      contacts[index].email ?? "",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      contacts[index].phone ?? "",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
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

    helper.getAll().then((list){
      setState(() {
        contacts = list;
      });      
    });
  }
}