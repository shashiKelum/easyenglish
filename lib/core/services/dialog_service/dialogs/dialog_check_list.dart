import 'package:flutter/material.dart';

import 'dialog_list_item.dart';

class DialogList<T> extends StatefulWidget {
  final String title;
  final List<DialogListItem<T>> items;

  const DialogList({Key? key, required this.title, required this.items})
      : super(key: key);

  @override
  _DialogListState createState() => _DialogListState<T>();
}

class _DialogListState<T> extends State<DialogList> {
  late List<DialogListItem<T>> items;

  @override
  void initState() {
    super.initState();
    items = widget.items as List<DialogListItem<T>>;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _title(),
        Expanded(
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              final item = items[index];
              return CheckboxListTile(
                value: item.checked,
                title: Text(
                  item.name,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(color: Colors.black),
                ),
                onChanged: (value) {
                  setState(() {
                    items[index].checked = value ?? false;
                  });
                },
              );
            },
          ),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, items),
          child: Text('Done'),
        ),
      ],
    );
  }

  Widget _title() {
    return Column(
      children: <Widget>[
        Text(
          widget.title,
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(color: Colors.black),
        ),
        SizedBox(
          height: 16.0,
        ),
        TextField(
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(color: Colors.black),
          decoration: InputDecoration.collapsed(
            hintText: 'Search',
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black87, width: 2.0),
            ),
            hintStyle: Theme.of(context)
                .textTheme
                .bodyText2!
                .copyWith(color: Colors.black54),
          ),
          onChanged: (val) {
            setState(() {
              if (val.isNotEmpty)
                items = widget.items
                    .where((w) =>
                        w.name.toLowerCase().startsWith(val.toLowerCase()))
                    .toList() as List<DialogListItem<T>>;
              else
                items = widget.items as List<DialogListItem<T>>;
            });
          },
        ),
      ],
    );
  }
}
