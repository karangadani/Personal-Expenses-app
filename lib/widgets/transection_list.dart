import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transection.dart';

class TransectionList extends StatelessWidget {
  final List<Transection> transections;
  final Function deleteTx;

  TransectionList(this.transections, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return transections.isEmpty
        ? Column(
            children: <Widget>[
              Text("No Tansection added Yet!",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 20,
              ),
              Container(
                  height: 200,
                  child: Image.asset(
                    "assets/images/waiting.png",
                    fit: BoxFit.cover,
                  )),
            ],
          )
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                elevation: 5,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: FittedBox(
                          child: Text("\u{20B9}${transections[index].amount}")),
                    ),
                  ),
                  title: Text(transections[index].title,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  subtitle:
                      Text(DateFormat.yMMMd().format(transections[index].date)),
                  trailing: MediaQuery.of(context).size.width > 460
                      ? FlatButton.icon(
                          onPressed: () => deleteTx(transections[index].id),
                          icon: Icon(Icons.delete),
                          label: Text('Remove'),
                          textColor: Theme.of(context).errorColor,
                        )
                      : IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => deleteTx(transections[index].id),
                          color: Theme.of(context).errorColor,
                        ),
                ),
              );
            },
            itemCount: transections.length,
          );
  }
}
