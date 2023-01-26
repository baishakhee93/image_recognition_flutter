import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Details extends StatefulWidget {
  final String text;
  Details(this.text);
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  final GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: Text('Image Text'),
        backgroundColor: Colors.purple,
        actions: [
          IconButton(
            icon: Icon(Icons.copy),
            onPressed: () {
              // FlutterClipboard.copy(widget.text).then((value) => _key
              //     .currentState
              //     .showSnackBar(new SnackBar(content: Text('Copied'))));
              //                Clipboard.setData(ClipboardData(text:widget.text))
              // .then((value) { //only if ->
              //    ScaffoldMessenger.of(context).showSnackBar(snackBar))
              Clipboard.setData(ClipboardData(text: widget.text)).then((value) {
                //only if ->
                final snackBar = SnackBar(
                  content: Text('Copied to Clipboard'),
                  action: SnackBarAction(
                    label: 'Undo',
                    onPressed: () {},
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              });
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        alignment: Alignment.topCenter,
        height: double.infinity,
        width: double.infinity,
        child: SelectableText(
            widget.text.isEmpty ? 'No Text Available' : widget.text),

      ),
    );
  }
}
