// Annotate a Dart class to create a Box
import 'package:objectbox/objectbox.dart';

@Entity()
class Income {
  @Id()
  int id;
  String category;  
  double amount; 
  DateTime date;

  Income({this.id = 0,  
   required this.category, required this.amount,  required this.date });
}
