import 'dart:math';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionItem extends StatefulWidget {
  final Transaction transaction;
  final Function deleteTransaction;

  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.deleteTransaction,
  }) : super(key: key);

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  Color _bgColor;

  @override
  void initState() {
    const availableColors = [
      Colors.red,
      Colors.black,
      Colors.blue,
      Colors.purple,
    ];
    _bgColor = availableColors[Random().nextInt(4)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _bgColor,
          radius: 30,
          child: Padding(
              padding: const EdgeInsets.all(6),
              child: FittedBox(child: Text('\$${widget.transaction.amount}'))),
        ),
        title: Text(
          widget.transaction.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(widget.transaction.date),
        ),
        trailing: MediaQuery.of(context).size.width > 400
            ? ElevatedButton.icon(
                icon: const Icon(Icons.delete),
                label: const Text('Delete'),
                style: ElevatedButton.styleFrom(
                    foregroundColor: Theme.of(context).errorColor,
                    backgroundColor: Colors.white,
                    elevation: 0),
                onPressed: () {
                  widget.deleteTransaction(widget.transaction.id);
                },
              )
            : IconButton(
                icon: const Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () {
                  widget.deleteTransaction(widget.transaction.id);
                },
              ),
      ),
    );
  }
}
