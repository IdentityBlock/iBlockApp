import 'package:flutter/material.dart';
import 'package:iblock/widgets/copyable_text.dart';

class HistoryRecord extends StatelessWidget {
  final String txhash;
  final String verifierName;
  final String verifierContractAddress;
  const HistoryRecord({required this.txhash, required this.verifierName, required this.verifierContractAddress,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Theme.of(context).colorScheme.secondary)
      ),
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children:[
          Padding(padding: const EdgeInsets.all(8.0),
            child: Text(verifierName, style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold
            ),),
          ),
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: Row(
              children: [
                const Text("Contract Address : ", style: TextStyle(fontSize: 10),),
                Flexible(child: Text(verifierContractAddress, style: const TextStyle(fontSize: 10, overflow: TextOverflow.ellipsis))),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: Row(
              children: [
                const Text("Transaction Hash : ", style: TextStyle(fontSize: 10)),
                Flexible(child: Text(txhash, style: const TextStyle(fontSize: 10, overflow: TextOverflow.ellipsis))),
              ],
            ),
          )
        ],
      ),
    );
  }
}
