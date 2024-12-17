import 'package:objectbox/objectbox.dart';
import '../objectbox.g.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../models/Income.dart';

class ObjectBoxIncomes {
  static late Store store;

  ObjectBoxIncomes._create(store) {
    ObjectBoxIncomes.store = store;
  }
  // Add any additional setup code, e.g. build queries.

  static Future<ObjectBoxIncomes> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    // Future<Store> openStore() {...} is defined in the generated
    final store =
        await openStore(directory: p.join(docsDir.path, "db-incomes"));
    return ObjectBoxIncomes._create(store);
  }

  static void saveIncome(Income income) {
    final box = ObjectBoxIncomes.store.box<Income>();
    final id = box.put(income);
  }

  static void updateIncome(Income income) {
    final box = ObjectBoxIncomes.store.box<Income>();
  
    box.put(income);
  }

  static Income getIncome(int id) {
    final box = ObjectBoxIncomes.store.box<Income>();
    Income income = box.get(id)!;
    return income;
  }

  static List<Income> getAllIncomes() {
    final box = ObjectBoxIncomes.store.box<Income>();
    List<Income> incomes = box.getAll();
    return incomes;
  }
  
static void deleteIcome(int id) {
    final box = ObjectBoxIncomes.store.box<Income>();

    box.remove(id);
  }
}
