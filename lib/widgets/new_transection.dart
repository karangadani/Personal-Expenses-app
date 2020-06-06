import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransections extends StatefulWidget {
  final Function addTx;

  NewTransections(this.addTx);

  @override
  _NewTransectionsState createState() => _NewTransectionsState();
}

class _NewTransectionsState extends State<NewTransections> {
  void submitTx() {
    final enteredTilte = titleController.text;
    final enteredAmount = double.parse(amountController.text);
    if (enteredTilte.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addTx(enteredTilte, enteredAmount,_selectedDate);

    Navigator.of(context).pop();
  }

  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime _selectedDate;

  void _percentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child : Card(
      child: Container(
          padding: EdgeInsets.only(top: 10,bottom: MediaQuery.of(context).viewInsets.bottom +10,right: 10,left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: "Title"),
                controller: titleController,
                onSubmitted: (_) => submitTx(),
              ),
              TextField(
                decoration: InputDecoration(labelText: "Amount"),
                keyboardType: TextInputType.number,
                controller: amountController,
                onSubmitted: (_) => submitTx(),
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(_selectedDate == null
                          ? "No Date Choosen"
                          : "Picked Date " +
                              DateFormat.yMd().format(_selectedDate)),
                    ),
                    FlatButton(
                        child: Text(
                          "Choose Date",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onPressed: _percentDatePicker,
                        textColor: Theme.of(context).primaryColor),
                  ],
                ),
              ),
              RaisedButton(
                color: Theme.of(context).primaryColor,
                onPressed: submitTx,
                child: Text(
                  "Add Transection",
                ),
                textColor: Theme.of(context).textTheme.button.color,
              )
            ],
          )),
      )
    );
  }
}
