
import 'package:flutter/material.dart';

class NotificationScreen {
  // Méthode pour afficher une notification via Snackbar
  static void showContactAddedNotification(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Contact ajouté avec succès!'),
        backgroundColor: Colors.teal,
      ),
    );
  }
}

