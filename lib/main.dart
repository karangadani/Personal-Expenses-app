import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:personal_expenses_app/widgets/chart.dart';
import 'package:personal_expenses_app/widgets/new_transection.dart';
import 'widgets/transection_list.dart';
import 'models/transection.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp ,DeviceOrientation.portraitDown]);
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          accentColor: Colors.cyanAccent,
          primarySwatch: Colors.cyan,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                button: TextStyle(color: Colors.white),
              )),
      title: "Personal Expenses App",
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Transection> transections = [];

  List<Transection> get _recentTransection {
    return transections.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  void _deleteTransection(String id) {
    setState(() {
      transections.removeWhere((tx) => tx.id == id);
    });
  }

  void _addNewTransection(
      String txTitle, double txAmount, DateTime choosenDate) {
    final newTx = Transection(
        title: txTitle,
        amount: txAmount,
        date: choosenDate,
        id: DateTime.now().toString());

    setState(() {
      transections.add(newTx);
    });
  }

  void startNewAddTransection(ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (Bctx) {
          return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: NewTransections(_addNewTransection),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text("Personal Expenses App"),
      centerTitle: true,
      actions: <Widget>[
        IconButton(
            icon: Icon(Icons.add),
            onPressed: () => {startNewAddTransection(context)})
      ],
    );
    return Scaffold(
      appBar: appBar,
      floatingActionButton: FloatingActionButton(
          onPressed: () => startNewAddTransection(context),
          child: Icon(Icons.add)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.3,
              child: Chart(_recentTransection),
            ),
            Container(
              height:(MediaQuery.of(context).size.height - appBar.preferredSize.height - MediaQuery.of(context).padding.top) * 0.7,
              child :TransectionList(transections, _deleteTransection),),
          ],
        ),
      ),
    );
  }
}
