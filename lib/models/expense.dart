// Annotate a Dart class to create a Box
import 'package:objectbox/objectbox.dart';

@Entity()
class Expense {
  @Id()
  int id;
  String title;  
  String category;  
  double amount; 
  DateTime date;

  Expense({this.id = 0,  required this.title,
   required this.category, required this.amount,  required this.date });
}
