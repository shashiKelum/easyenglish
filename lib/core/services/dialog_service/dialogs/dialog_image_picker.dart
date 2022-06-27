import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../ui/theme/dim.dart';

class DialogImagePicker extends StatefulWidget {
  final void Function(ImageSource source)? callback;

  const DialogImagePicker({Key? key, this.callback}) : super(key: key);

  @override
  _DialogImagePickerState createState() => _DialogImagePickerState();
}

class _DialogImagePickerState extends State<DialogImagePicker> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Stack(
        children: <Widget>[_buildBody()],
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      padding: EdgeInsets.only(
        top: AppDim.size16,
        bottom: AppDim.size16,
        left: AppDim.size16,
        right: AppDim.size16,
      ),
      child: Container(
        width: MediaQuery.of(context).size.width -
            (MediaQuery.of(context).size.width / 3),
        child: Wrap(
          alignment: WrapAlignment.spaceEvenly,
          runAlignment: WrapAlignment.spaceEvenly,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[
            // OutlineButton.icon(
            //     onPressed: () => widget.callback!(ImageSource.gallery),
            //     icon: Icon(Icons.photo_album, color: Colors.black87),
            //     label: Text(
            //       'Gallery',
            //       style: Theme.of(context)
            //           .textTheme
            //           .bodyText2!
            //           .copyWith(color: Colors.black87),
            //     )),
            // OutlineButton.icon(
            //     onPressed: () => widget.callback!(ImageSource.camera),
            //     icon: Icon(Icons.camera, color: Colors.black87),
            //     label: Text(
            //       'Camera',
            //       style: Theme.of(context)
            //           .textTheme
            //           .bodyText2!
            //           .copyWith(color: Colors.black87),
            //     )),
          ],
        ),
      ),
    );
  }
}
