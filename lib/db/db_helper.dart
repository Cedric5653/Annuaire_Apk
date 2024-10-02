import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/contact.dart';



class DBHelper {
  static final DBHelper _instance = DBHelper._();
  static Database? _database;

  DBHelper._();

  factory DBHelper() {
    return _instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('contacts.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    String path = join(await getDatabasesPath(), filePath);
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE contacts(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nom TEXT,
        prenom TEXT,
        email TEXT,
        telephone TEXT
      )
    ''');
  }


  Future<int> insertContact(Contact contact) async {
    final db = await database;
    int id = await db.insert('contacts', contact.toMap());
    print('Contact inséré avec l\'id : $id'); // teste verification
    return id;
  }


  Future<List<Contact>> getContacts() async {
    final db = await database;
    final result = await db.query('contacts');
    return result.map((map) => Contact.fromMap(map)).toList();
  }

  
}

