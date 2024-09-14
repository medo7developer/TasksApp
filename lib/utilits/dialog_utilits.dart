import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showLoading(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          content: Row(
            children: [
              Text('Loading...'),
              Spacer(),
              CircularProgressIndicator(),
            ],
          ),
        );
      });
}

hideLoadin(BuildContext context) {
  Navigator.pop(context);
}

showMessage(BuildContext context,
    {String? title,
    String? body,
    String? posButtonTitle,
    String? negButtonTitle,
    Function? onPositiveButton,
    Function? onNegButtonButton}) {
  showDialog(
      context: context,
      builder: (_) {
        return CupertinoAlertDialog(
          title: title != null ? Text(title) : null,
          content: body != null ? Text(body) : null,
          actions: [
            if (posButtonTitle != null)
              TextButton(
                  onPressed: () {
                    onPositiveButton?.call();
                  },
                  child: Text(posButtonTitle)),
            if (negButtonTitle != null)
              TextButton(
                  onPressed: () {
                    onNegButtonButton?.call();
                    Navigator.pop(context);
                  },
                  child: Text(negButtonTitle)),
          ],
        );
      });
}
