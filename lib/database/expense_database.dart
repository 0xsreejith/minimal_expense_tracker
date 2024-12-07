import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class ExpenseDatabase extends ChangeNotifier {
  static late Isar isar;

  List<Expense> _allExpenses = [];

  // ISAR DB SETUP
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([ExpenseSchema], directory: dir.path);
  }

  // Get Expenses
  List<Expense> get allExpenses => _allExpenses;

  // CRUD operations

  // CREATE
  Future<void> createNewExpense(Expense newExpense) async {
    await isar.writeTxn(() => isar.expenses.put(newExpense));
    await readExpenses();
  }

  // READ
  Future<void> readExpenses() async {
    // fetch all from existing db
    List<Expense> fetchExpenses = await isar.expenses.where().findAll();

    // give to local expsense list
    _allExpenses.clear();
    _allExpenses.addAll(fetchExpenses);

    //uodate ui
    notifyListeners();
  }

  // update
  Future<void> updateExpense(int id, Expense expense) async {
    expense.id = id;
    await isar.writeTxn(() => isar.expenses.put(expense));

    await readExpenses();
  }

  // delete
  Future<void> deleteExpense(int id) async {
    await isar.writeTxn(() => isar.expenses.delete(id));
    await readExpenses();
  }
}
