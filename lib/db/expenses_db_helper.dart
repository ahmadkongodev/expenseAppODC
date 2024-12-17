import 'package:objectbox/objectbox.dart';
 import '../objectbox.g.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../models/expense.dart';



class ObjectBoxExpenses {

  static late Store store;

  ObjectBoxExpenses._create(store){
    ObjectBoxExpenses.store = store;
  }
   // Add any additional setup code, e.g. build queries.

 static Future<ObjectBoxExpenses> create() async {
   final docsDir = await getApplicationDocumentsDirectory();
   // Future<Store> openStore() {...} is defined in the generated objectbox.g.dart
   final store = await openStore(directory: p.join(docsDir.path, "db-expenses"));
   return ObjectBoxExpenses._create(store);
 }

  static void saveExpense(Expense expense)   {
     final box = ObjectBoxExpenses.store.box<Expense>();
     final id = box.put(expense);
     
  }
  static Expense getExpense(int id)   {
    final box = ObjectBoxExpenses.store.box<Expense>();
    Expense expense = box.get(id)!;
    return expense;
  }
 static void updateExpense(Expense expense) {
    final box = ObjectBoxExpenses.store.box<Expense>();

    box.put(expense);
  }
  static List<Expense> getAllExpense(){
    final box = ObjectBoxExpenses.store.box<Expense>();
   List<Expense> expenses= box.getAll();
   return expenses;
  }

static void deleteExpense(int id) {
    final box = ObjectBoxExpenses.store.box<Expense>();

    box.remove(id);
  }

}