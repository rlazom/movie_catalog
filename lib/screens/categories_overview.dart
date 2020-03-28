import 'package:catalogo/providers/categories_provider.dart';
import 'package:catalogo/widgets/category_grid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      Provider.of<CategoriesProvider>(context, listen: false)
          .syncroCatagories(context);
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final catData = Provider.of<CategoriesProvider>(context, listen: false);
    print('build');
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio'),
      ),
      body: RefreshIndicator(
          onRefresh: () => catData.syncroCatagories(context),
          child: CategoryGrid()), //      body: CategoryGrid(),
    );
  }
}
