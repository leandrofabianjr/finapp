import 'package:finapp/models/model.dart';

class CategoryType implements Model {
  int id;
  String name;
  String description;
  DateTime createdAt;
  DateTime deletedAt;

  CategoryType(
      {this.id, this.name, this.description, this.createdAt, this.deletedAt});

  @override
  String toString() {
    return 'CategoryType{id: $id, name: $name, description: $description, createdAt: $createdAt, deletedAt: $deletedAt}';
  }
}
