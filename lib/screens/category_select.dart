import 'package:finapp/db/daos/category_dao.dart';
import 'package:finapp/models/category.dart';
import 'package:finapp/screens/category_new.dart';
import 'package:flutter/material.dart';

class CategorySelect extends StatefulWidget {
  @override
  _CategorySelectState createState() => _CategorySelectState();
}

class _CategorySelectState extends State<CategorySelect> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Selecione uma categoria'),
        ),
        body: FutureBuilder<List<Category>>(
            initialData: List(),
            future: CategoryDao().findAll(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        CircularProgressIndicator(),
                        Text('Loading')
                      ],
                    ),
                  );
                  break;

                case ConnectionState.done:
                  final List<Category> categories = snapshot.data;
                  var list = ListView.builder(
                    itemBuilder: (context, index) {
                      var category = categories[index];
                      return ListTile(
                        title: Text(category.name),
                        leading: Icon(Icons.local_offer, color: category.color),
                        subtitle: category.description != null ? Text(category.description) : null,
                        trailing: category.createdAt != null ? Icon(Icons.edit) : null,
                        onTap: () {
                          Navigator.pop<Category>(context, category);
                        },
                      );
                    },
                    itemCount: categories != null ? categories.length : 0,
                  );
                  return list;
                  break;

                default:
                  return Text('Erro desconhecido');
              }
            }
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (BuildContext context) => CategoryNewScreen())
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}
