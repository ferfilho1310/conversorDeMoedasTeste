import 'package:conversordemoedasapp/Model/Moeda.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final String conversoes = "conversoes";
final String id = "id";
final String nomeMoedaParaConversao = "nomeMoedaParaConversao";
final String nomeMoedaConvertida = "nomeMoedaConvertida";
final String valorParaConversao = "valorParaConversao";
final String valorConvertido = "valorConvertido";

class ConversorHelper {
  Database _db;

  ConversorHelper();

  Future<Database> get db async {
    if (_db != null) {
      return db;
    } else {
      _db = await initDb();
    }
  }

  Future<Database> initDb() async {
    final dataBasePath = await getDatabasesPath();
    final path = join(dataBasePath, "moedas.db");

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int newerVersion) async {
      await db.execute(
          "CREATE TABLE $conversoes($id INTEGER PRIMARY KEY, $valorParaConversao TEXT,"
              " $valorConvertido TEXT)");
    });
  }

  Future<Moeda> saveConversao(Moeda moeda) async {
    Database dbContact = await db;
    moeda.idConversao = await dbContact.insert(conversoes, moeda.toMap());
    return moeda;
  }

  Future<List> getAllContacts() async {
    Database dbContact = await db;
    List lisMap = await dbContact.rawQuery("SELECT * FROM $conversoes");
    List<Moeda> listContact = List();
    for (Map m in lisMap) {
      listContact.add(Moeda.fromMap(m));
    }
    return listContact;
  }
}
