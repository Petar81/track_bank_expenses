import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class TransactionsHistory extends StatefulWidget {
  const TransactionsHistory({Key? key}) : super(key: key);

  @override
  State<TransactionsHistory> createState() => _TransactionsHistoryState();
}

class _TransactionsHistoryState extends State<TransactionsHistory> {
  @override
  void initState() {
    super.initState();
    getDeposits();
  }

  DatabaseReference getDepositsRef = FirebaseDatabase.instance.ref("deposits");

  getDeposits() async {
    // Get the data once from currentBalance/currentAmount
    DatabaseEvent event = await getDepositsRef.once();
    print(event.snapshot.value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View transactions history'),
      ),
      body: Card(
        child: SizedBox(
          height: double.infinity,
          child: ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: 15,
            itemBuilder: (BuildContext context, int index) {
              return SizedBox(
                height: 100,
                //color: Colors.amber.shade300,
                child: ListTile(
                  leading: 10 < 3
                      ? Icon(
                          Icons.arrow_downward,
                          color: Colors.red.shade300,
                          size: 30,
                        )
                      : Icon(
                          Icons.arrow_upward,
                          color: Colors.green.shade300,
                          size: 30,
                        ),
                  title: const Text('Transaction amount: 12.54'),
                  subtitle: Column(
                    children: <Widget>[
                      Row(
                        children: const <Widget>[
                          Text('Pizza quatro carne'),
                        ],
                      ),
                      Row(
                        children: const <Widget>[
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(top: 5),
                              child: Text('on 2022-02-02 @ 12:56'),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: const <Widget>[
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(top: 5),
                              child: Text('previous balance: 344.77'),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: const <Widget>[
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(top: 5.0),
                              child: Text('current balance: 9898.90'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(
              thickness: 3,
            ),
          ),
        ),
      ),
    );
  }
}
