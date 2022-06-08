import 'dart:io';

import 'package:flutter/cupertino.dart';
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
  final uuid = const Uuid();

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
      _userTransactions.add(
        Transaction(
          id: uuid.v4(),
          title: txTitle,
          amount: txAmount,
          date: date,
        ),
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

  List<Widget> _buildLandscapeContent(
    double availableView,
    Widget txListWidget,
  ) =>
      [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Show Chart',
              style: Theme.of(context).textTheme.titleLarge,
            ),
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
        _showChart
            ? SizedBox(
                height: availableView * 0.7,
                child: Chart(_recentTransactions),
              )
            : txListWidget
      ];

  List<Widget> _buildPortraitContent(
    double availableView,
    Widget txListWidget,
  ) =>
      [
        SizedBox(
          height: availableView * 0.3,
          child: Chart(_recentTransactions),
        ),
        txListWidget,
      ];

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    final isLandscape = mediaQuery.orientation == Orientation.landscape;

    final cupertinoNavigationBar = CupertinoNavigationBar(
      middle: const Text('Personal Expenses'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: (() => _startAddNewTransaction(context)),
            child: const Icon(CupertinoIcons.add, size: 24),
          )
        ],
      ),
    );
    final materialAppBar = AppBar(
      title: const Text('Personal Expenses'),
      actions: [
        IconButton(
          onPressed: () => _startAddNewTransaction(context),
          icon: const Icon(Icons.add),
        )
      ],
    );

    final availableView = mediaQuery.size.height -
        (Platform.isIOS
            ? cupertinoNavigationBar.preferredSize.height
            : materialAppBar.preferredSize.height) -
        mediaQuery.padding.top -
        (Platform.isIOS ? mediaQuery.padding.bottom : 0);

    final txListWidget = SizedBox(
      height: availableView * 0.7,
      child: TransactionList(_userTransactions, _deleteTransaction),
    );

    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isLandscape)
              ..._buildLandscapeContent(
                availableView,
                txListWidget,
              )
            else
              ..._buildPortraitContent(
                availableView,
                txListWidget,
              ),
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: cupertinoNavigationBar,
            child: pageBody,
          )
        : Scaffold(
            appBar: materialAppBar,
            body: pageBody,
            floatingActionButton: Platform.isIOS
                ? null
                : FloatingActionButton(
                    onPressed: () => _startAddNewTransaction(context),
                    child: const Icon(Icons.add),
                  ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
