import 'dart:io';
import 'package:flutter/material.dart';
import 'package:contacts/helpers/contactHelper.dart';
import 'package:url_launcher/url_launcher.dart';

import 'contactPage.dart';

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
              child: Icon(Icons.add),
              backgroundColor: Colors.red,
              onPressed: (){
                showContactPage();
              },
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
                    image: contacts[index].img != null ? FileImage(File(contacts[index].img)): AssetImage("images/person.png"),
                    fit: BoxFit.cover
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
      onTap: () {
        // showContactPage(contact: contacts[index]);
        showOptions(context, index);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return main();
  }

  void showContactPage({Contact contact}) async {
    final recContact = await Navigator.push(context, MaterialPageRoute(builder: (context) => ContactPage(contact: contact)));

    if(recContact != null){
      if(contact != null) {
        await helper.updateContact(recContact);
      }
      else{
        await helper.saveContact(recContact);
      }
      getAllConctacs();
    }
  }

  void showOptions(BuildContext context, int index){
    showModalBottomSheet(
      context: context,
      builder: (context){
        return BottomSheet(
          onClosing: (){},
          builder: (context){
            return Container(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10),
                    child:  FlatButton(
                              child: Text("Call", style: TextStyle(color: Colors.red, fontSize: 20)),
                              onPressed: (){
                                launch("tel:${contacts[index].phone}");
                                Navigator.pop(context);
                              },
                            ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child:  FlatButton(
                              child: Text("Edit", style: TextStyle(color: Colors.red, fontSize: 20)),
                              onPressed: (){
                                Navigator.pop(context);
                                showContactPage(contact: contacts[index]);

                              },
                            ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child:  FlatButton(
                              child: Text("Delete", style: TextStyle(color: Colors.red, fontSize: 20)),
                              onPressed: (){
                                helper.deleteContact(contacts[index].id);
                                setState(() {
                                  contacts.removeAt(index);
                                });
                                Navigator.pop(context);
                              },
                            ),
                  ),
                  
                ],
              ),
            );
          },
        );
      }
    );
  }

  void getAllConctacs() {
    helper.getAll().then((list){
      setState(() {
        contacts = list;
      });      
    });
  }

  @override
  void initState() {
    super.initState();
    getAllConctacs();
  }
}