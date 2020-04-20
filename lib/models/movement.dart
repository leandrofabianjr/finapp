import 'package:finapp/db/daos/category_dao.dart';
import 'package:finapp/models/category.dart';
import 'package:finapp/models/model.dart';

class Movement implements Model {
  int id;
  String name;
  String description;
  DateTime datetime;
  double value;
  int idAccount;
  int idCategory;
  Category _category;
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

  Future<Category> get category async {
    if (_category == null) {
      _category = await CategoryDao().findById(idCategory);
    }
    return _category;
  }

  @override
  String toString() {
    return 'Movement{id: $id, name: $name, description: $description, datetime: $datetime, value: $value, idAccount: $idAccount, idCategory: $idCategory, createdAt: $createdAt, deletedAt: $deletedAt}';
  }
}
