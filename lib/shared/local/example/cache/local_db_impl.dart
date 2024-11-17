import 'local_db.dart';

class InitDbImpl extends LocalDb {
  // late Isar db;

  @override
  Future<void> initDb() async {
    // final dir = await getApplicationDocumentsDirectory();
    // db = await Isar.open([SchemasList], directory: dir.path);
  }

  @override
  void getDb() {
    return;
  }

  @override
  Future<void> cleanDb() async {
    return;
  }
}
