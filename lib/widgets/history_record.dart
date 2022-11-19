import 'package:flutter/material.dart';

class HistoryRecord extends StatelessWidget {
  final String txhash;
  final String verifierName;
  final String verifierContractAddress;
  const HistoryRecord({required this.txhash, required this.verifierName, required this.verifierContractAddress,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0)
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
          Row(
            children: [
              const Text("Contract Address : "),
              Text(verifierContractAddress),
            ],
          ),
          Row(
            children: [
              const Text("Transaction Hash : "),
              Text(txhash),
            ],
          )
        ],
      ),
    );
  }
}
