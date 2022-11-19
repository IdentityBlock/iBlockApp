import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:fluttertoast/fluttertoast.dart';

class CopyableText extends StatelessWidget {
  final String value;
  const CopyableText(this.value, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.grey,
        backgroundBlendMode: BlendMode.colorDodge
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            flex: 9,
            child: Text(value,
            overflow: TextOverflow.fade,
            style: const TextStyle(fontSize: 12),),
          ),
          Expanded(
            flex: 1,
            child: IconButton(onPressed: (){
              Clipboard.setData(ClipboardData(text: value));
              Fluttertoast.showToast(
                msg: "Text copied",
                gravity: ToastGravity.BOTTOM,
                toastLength: Toast.LENGTH_SHORT
              );
            }, icon: const Icon(Icons.copy)),
          )
        ],
      ),
    );
  }
}
