import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class PlatFormAlert{
  final String? title;
  final String? message;
  PlatFormAlert({
    required this.title,
    required this.message,
  }): assert (title != null),assert(message != null);

  void show(BuildContext context){
    final platform = Theme.of(context).platform;

    if (platform == TargetPlatform.iOS){
      _buildCupertinoAlert(context);
    }
    else{
      _buildMaterialAlert(context);
    }
  }

  void _buildMaterialAlert(BuildContext context){
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text(title!),
            content: Text(message!),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("Close"),
              )
            ],
          );
        });
  }

  void _buildCupertinoAlert(BuildContext context){
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(title!),
            content: Text(message!),
            actions: [
              CupertinoButton(
                  child: const Text("Close"),
                  onPressed: () => Navigator.of(context).pop(),
              )
            ],
          );
        });
  }

}