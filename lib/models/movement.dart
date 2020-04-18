import 'package:finapp/models/model.dart';

class Movement implements Model {
  int id;
  String name;
  String description;
  DateTime datetime;
  double value;
  int idAccount;
  int idCategory;
  DateTime createdAt;
  DateTime deletedAt;

  Movement(
      {this.id,
      this.name,
      this.description,
      this.datetime,
      this.value,
      this.idAccount,
      this.idCategory,
      this.createdAt,
      this.deletedAt});

  @override
  String toString() {
    return 'Movement{id: $id, name: $name, description: $description, datetime: $datetime, value: $value, idAccount: $idAccount, idCategory: $idCategory, createdAt: $createdAt, deletedAt: $deletedAt}';
  }
}
