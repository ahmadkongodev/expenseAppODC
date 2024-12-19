import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static late SharedPreferences prefs;
  static initialise() async {
    prefs = await SharedPreferences.getInstance();
  }

  static storeBudget(double budget) async {
    await prefs.setDouble('budget', budget);
  }

  static storePrefMode(bool isDarkMode) async {
    await prefs.setBool('isDarkMode', isDarkMode);
  }
  

  static storeIncomeCategories(List<String> categories) async {
    await prefs.setStringList('incomeCategories', categories);
  }
   static storeExpenseCategories(List<String> categories) async {
    await prefs.setStringList('expenseCategories', categories);
  }
  
  static List<String>?getIncomeCategories()  {
   return   prefs.getStringList('incomeCategories');
      
  }
   static List<String>?getExpenseCategories()   {
      return prefs.getStringList('expenseCategories');
  }

  static setUserConnectedChecker() async {
    await prefs.setBool('isUserConnected', true);
  }
 
  static double? getBudget(){
    final budget=prefs.getDouble("budget");
    return budget;
  }
  static bool? isDarkMode(){
     final bool? isDarkMode = prefs.getBool('isDarkMode');
    return isDarkMode ;
  }
  static bool? checkConnected(){
    final bool? isConnected = prefs.getBool('isUserConnected');
    return isConnected;
  }
}
