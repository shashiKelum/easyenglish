import 'package:flutter/material.dart';

import '../../../../ui/theme/dim.dart';

class DialogInput extends StatefulWidget {
  final String title;
  final String positiveText;
  final Function(dynamic)? positiveCallback;

  const DialogInput({
    Key? key,
    required this.title,
    this.positiveText = 'OK',
    this.positiveCallback,
  })  : assert(title != null),
        super(key: key);

  @override
  _DialogInputState createState() => _DialogInputState();
}

class _DialogInputState extends State<DialogInput> {
  final _formKey = GlobalKey<FormState>();
  final _controllerInput = TextEditingController();
  final _focusInput = FocusNode();
  String userInput = '';

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Stack(
        children: <Widget>[
          _dialogBody(context),
        ],
      ),
    );
  }

  _dialogBody(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: AppDim.size16,
        bottom: AppDim.size16,
        left: AppDim.size16,
        right: AppDim.size16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // To make the card compact
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _title(),
          _buildInputField(),
          SizedBox(height: AppDim.size24),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              buildPositiveButton(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _title() {
    return Column(
      children: <Widget>[
        widget.title == null
            ? Container()
            : Text(
                widget.title,
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Colors.black),
              ),
        widget.title == null ? Container() : SizedBox(height: AppDim.size16),
      ],
    );
  }

  Widget _buildInputField() {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: TextFormField(
        controller: _controllerInput,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: TextInputType.multiline,
        textInputAction: TextInputAction.newline,
        focusNode: _focusInput,
        style: Theme.of(context)
            .textTheme
            .headline6!
            .copyWith(color: Colors.black),
        decoration: InputDecoration(
          labelStyle: TextStyle(color: Colors.black87),
          errorStyle: TextStyle(color: Colors.red[600]),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black54),
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black54),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black87),
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red[600]!),
          ),
          disabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black54),
          ),
        ),
      ),
    );
  }

  Widget buildPositiveButton() {
    return SizedBox(
      height: 36.0,
      child: FlatButton(
        child: Text(
          widget.positiveText,
          style:
              Theme.of(context).textTheme.button!.copyWith(color: Colors.black),
        ),
        onPressed: () {
          if (widget.positiveCallback == null)
            Navigator.pop(context);
          else
            _onSubmit();
        },
      ),
    );
  }

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      widget.positiveCallback!(_controllerInput.text);
    }
  }
}
