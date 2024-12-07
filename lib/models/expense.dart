import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

part 'expense.g.dart';

@Collection()
class Expense {
  Id id = Isar.autoIncrement;
  final String name;
  final double amount;
  final DateTime dateTime;

  Expense({required this.name, required this.amount, required this.dateTime});
}
