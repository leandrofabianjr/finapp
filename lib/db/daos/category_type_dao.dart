import 'package:finapp/db/daos/dao.dart';
import 'package:finapp/shared/helpers/date_helper.dart';
import 'package:finapp/models/category_type.dart';

class CategoryTypeDao extends Dao<CategoryType> {
  @override
  String tblName = 'category_type';
  @override
  String colPk = 'id';

  String colId = 'id';
  String colName = 'name';
  String colDescription = 'description';
  String colCreatedAt = 'created_at';
  String colDeletedAt = 'deleted_at';

  @override
  CategoryType toObj(Map<String, dynamic> row) {
    return CategoryType(
        id: row[colId],
        name: row[colName],
        description: row[colDescription],
        createdAt: DateHelper.stringToDateTime(row[colCreatedAt]),
        deletedAt: DateHelper.stringToDateTime(row[colDeletedAt])
    );
  }

  @override
  Map<String, dynamic> toRow(CategoryType obj) {
    return {
      colId: obj.id,
      colName: obj.name,
      colDescription: obj.description,
      colCreatedAt: obj.createdAt,
      colDeletedAt: obj.deletedAt,
    };
  }
}