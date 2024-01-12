import 'package:flutter/material.dart';
import 'package:todos/db.dart';
import 'constants/colors.dart';

// ignore: camel_case_types
class todoList extends StatelessWidget {
  final Database dbb;
  final deltedb;
  final updatedb;

  const todoList({
    Key? key,
    required this.dbb,
    required this.deltedb,
    required this.updatedb,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: listColors,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: () => updatedb(dbb),
            icon: dbb.isComplete
                ? Icon(Icons.check_box)
                : Icon(Icons.check_box_outline_blank_outlined),
          ),
          Flexible(
            child: Text(
              dbb.title!,
              maxLines: 2,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                overflow: TextOverflow.ellipsis,
                decoration: dbb.isComplete ? TextDecoration.lineThrough : null,
              ),
            ),
          ),
          const Divider(),
          Text(
            dbb.date!,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          IconButton(
            onPressed: () => deltedb(dbb.id),
            icon: const Icon(
              Icons.delete_outline_outlined,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
