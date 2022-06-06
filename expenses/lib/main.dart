import 'dart:io';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import './models/transaction.dart';
import './widgets/chart.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primaryColor: Colors.amber,
        primaryColorLight: Colors.amber,
        primaryColorDark: Colors.amber,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.lightGreen,
          accentColor: Colors.blueGrey,
        ),
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              titleLarge: const TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var uuid = const Uuid();

  bool _showChart = false;

  final List<Transaction> _userTransactions = [];

  List<Transaction> get _recentTransactions {
    return _userTransactions
        .where(
          (tx) => tx.date.isAfter(DateTime.now().subtract(
            const Duration(days: 7),
          )),
        )
        .toList();
  }

  void _addNewTransaction(String txTitle, double txAmount, DateTime date) {
    setState(() {
      _userTransactions.addAll(
        [
          Transaction(
            id: uuid.v4(),
            title: txTitle,
            amount: txAmount,
            date: date,
          ),
          Transaction(
            id: uuid.v4(),
            title: txTitle,
            amount: txAmount,
            date: date,
          ),
          Transaction(
            id: uuid.v4(),
            title: txTitle,
            amount: txAmount,
            date: date,
          ),
          Transaction(
            id: uuid.v4(),
            title: txTitle,
            amount: txAmount,
            date: date,
          ),
          Transaction(
            id: uuid.v4(),
            title: txTitle,
            amount: txAmount,
            date: date,
          ),
          Transaction(
            id: uuid.v4(),
            title: txTitle,
            amount: txAmount,
            date: date,
          ),
          Transaction(
            id: uuid.v4(),
            title: txTitle,
            amount: txAmount,
            date: date,
          )
        ],
      );
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) => NewTransaction(_addNewTransaction),
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    final isLandscape = mediaQuery.orientation == Orientation.landscape;

    final appBar = AppBar(
      title: const Text('Personal Expenses'),
      actions: [
        IconButton(
          onPressed: () => _startAddNewTransaction(context),
          icon: const Icon(Icons.add),
        )
      ],
    );

    final availableView = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    final txListWidget = SizedBox(
      height: availableView * 0.7,
      child: TransactionList(_userTransactions, _deleteTransaction),
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Show Chart'),
                  Switch.adaptive(
                    activeColor: Theme.of(context).primaryColor,
                    value: _showChart,
                    onChanged: (isShown) {
                      setState(() {
                        _showChart = isShown;
                      });
                    },
                  ),
                ],
              ),
            if (!isLandscape)
              SizedBox(
                height: availableView * 0.3,
                child: Chart(_recentTransactions),
              ),
            if (!isLandscape) txListWidget,
            if (isLandscape)
              _showChart
                  ? SizedBox(
                      height: availableView * 0.7,
                      child: Chart(_recentTransactions),
                    )
                  : txListWidget,
          ],
        ),
      ),
      floatingActionButton: Platform.isIOS
          ? null
          : FloatingActionButton(
              onPressed: () => _startAddNewTransaction(context),
              child: const Icon(Icons.add),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
