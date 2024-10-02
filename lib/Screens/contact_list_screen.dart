import 'package:flutter/material.dart';
import '../db/db_helper.dart';
import '../models/contact.dart';

class ContactListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des contacts'),
        backgroundColor: Colors.teal,
      ),
      body: FutureBuilder<List<Contact>>(
        future: DBHelper().getContacts(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            padding: EdgeInsets.all(8.0),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final contact = snapshot.data![index];
              return Card(
                elevation: 4,
                margin: EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.teal,
                    child: Text(contact.nom[0].toUpperCase(),
                        style: TextStyle(color: Colors.white)),
                  ),
                  title: Text('${contact.nom} ${contact.prenom}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                  subtitle: Text(contact.telephone),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Détails du contact'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Nom: ${contact.nom}'),
                            Text('Prénom: ${contact.prenom}'),
                            Text('Email: ${contact.email}'),
                            Text('Téléphone: ${contact.telephone}'),
                          ],
                        ),
                        actions: [
                          TextButton(
                            child: Text('Fermer'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          )
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
