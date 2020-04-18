import 'package:finapp/db/daos/dao.dart';
import 'package:finapp/models/category_type.dart';

class CategoryTypeDao extends Dao<CategoryType> {
  @override
  String tblName = 'category_type';

  String colId = 'id';
  String colName = 'name';
  String colDescription = 'description';

  @override
  CategoryType toObj(Map<String, dynamic> row) {
    return CategoryType(
      id: row[colId],
      name: row[colName],
      description: row[colDescription],
    );
  }

  @override
  Map<String, dynamic> toRow(CategoryType obj) {
    return {
      colId: obj.id,
      colName: obj.name,
      colDescription: obj.description,
    };
  }
}
