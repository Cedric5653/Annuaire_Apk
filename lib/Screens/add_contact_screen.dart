import 'package:flutter/material.dart';
import '../db/db_helper.dart';
import '../models/contact.dart';
import 'notification_screen.dart'; 


// class AddContactScreen extends StatefulWidget {
//   @override
//   _AddContactScreenState createState() => _AddContactScreenState();
// }

// class _AddContactScreenState extends State<AddContactScreen> {
//   final _formKey = GlobalKey<FormState>();
//   String nom = '', prenom = '', email = '', telephone = '';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Ajouter un contact'),
//         backgroundColor: Colors.teal,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             children: [
//               // Champ nom
//               TextFormField(
//                 decoration: InputDecoration(
//                   labelText: 'Nom',
//                   border: OutlineInputBorder(),
//                   prefixIcon: Icon(Icons.person),
//                 ),
//                 onSaved: (value) => nom = value!,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Le champ nom est obligatoire';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16),
//               // Champ prénom
//               TextFormField(
//                 decoration: InputDecoration(
//                   labelText: 'Prénom',
//                   border: OutlineInputBorder(),
//                   prefixIcon: Icon(Icons.person_outline),
//                 ),
//                 onSaved: (value) => prenom = value!,
//               ),
//               SizedBox(height: 16),
//               // Champ email
//               TextFormField(
//                 decoration: InputDecoration(
//                   labelText: 'Email',
//                   border: OutlineInputBorder(),
//                   prefixIcon: Icon(Icons.email),
//                 ),
//                 keyboardType: TextInputType.emailAddress,
//                 onSaved: (value) => email = value!,
//               ),
//               SizedBox(height: 16),
//               // Champ téléphone
//               TextFormField(
//                 decoration: InputDecoration(
//                   labelText: 'Téléphone',
//                   border: OutlineInputBorder(),
//                   prefixIcon: Icon(Icons.phone),
//                 ),
//                 keyboardType: TextInputType.phone,
//                 onSaved: (value) => telephone = value!,
//               ),
//               SizedBox(height: 24),
//               ElevatedButton(
//                 onPressed: () async {
//                   if (_formKey.currentState!.validate()) {
//                     _formKey.currentState!.save();
//                     Contact newContact = Contact(nom: nom, prenom: prenom, email: email, telephone: telephone);
//                     await DBHelper().insertContact(newContact);
//                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                       content: Text('Contact ajouté avec succès!'),
//                       backgroundColor: Colors.teal,
//                     ));
//                     Navigator.pop(context);
//                   }
//                 },
//                 child: Text('Enregistrer'),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.teal,  // Remplacer `primary` par `backgroundColor`
//                   padding: EdgeInsets.symmetric(vertical: 16),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



class AddContactScreen extends StatefulWidget {
  @override
  _AddContactScreenState createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> {
  final _formKey = GlobalKey<FormState>();
  String nom = '', prenom = '', email = '', telephone = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter un contact'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Champ nom
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Nom',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                onSaved: (value) => nom = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Le champ nom est obligatoire';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              // Champ prénom
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Prénom',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person_outline),
                ),
                onSaved: (value) => prenom = value!,
              ),
              SizedBox(height: 16),
              // Champ email
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
                onSaved: (value) => email = value!,
              ),
              SizedBox(height: 16),
              // Champ téléphone
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Téléphone',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone),
                ),
                keyboardType: TextInputType.phone,
                onSaved: (value) => telephone = value!,
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  // Vérifier si le formulaire est valide
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    Contact newContact = Contact(
                      nom: nom,
                      prenom: prenom,
                      email: email,
                      telephone: telephone,
                    );

                    // Enregistrer le contact dans la base de données
                    int id = await DBHelper().insertContact(newContact);

                    if (id > 0) {
                      // Utiliser la méthode dans NotificationScreen pour afficher une notification
                      NotificationScreen.showContactAddedNotification(context);
                      
                      // Retour à l'écran précédent après l'ajout
                      Navigator.pop(context);
                    } else {
                      // Afficher une erreur si l'enregistrement échoue
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Échec de l\'ajout du contact'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }
                },
                child: Text('Enregistrer'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
