import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:iblock/services/history_logging_service.dart';
import 'package:meta/meta.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../services/secure_storage_service.dart';
import '../../services/user_contract_service.dart';

part 'verify_event.dart';
part 'verify_state.dart';

class VerifyBloc extends Bloc<VerifyEvent, VerifyState> {
  VerifyBloc() : super(Initial()) {
    on<QRDetectedEvent>((event, emit) async{
      try{
        Map<String, dynamic> data = jsonDecode(event.qrCode.code!);
        log(data.toString());
        emit(QRDetected(data["verifier-name"], data["verifier-contract"], data["token"]));
      }
      catch(error){
        log(error.toString());
        emit(Failed(error.toString()));
        //emit(Failed("Invalid QR code!"));
      }
    });

    on<Verify>((event, emit) async{
      emit(Submitted());

      try{
        var contractService = UserContractService();
        var contractAddress =
            await SecureStorageService.get("contract-address") as String;
        var privateKey =
            await SecureStorageService.get("private-key") as String;
        var transactionID = await contractService
            .verify(event.verifierContract, event.token,
                contractAddress: contractAddress, privateKey: privateKey)
            .timeout(const Duration(seconds: 30), onTimeout: () {
          throw Exception("Unable to process this request. Try again Later!");
        });
        log(transactionID);

        var loggingService = HistoryLoggingService();
        await loggingService.open();
        await loggingService.insert(HistoryRecord(txhash: transactionID, verifierName: event.verifierName, verifierContractAddress: event.verifierContract));
        await loggingService.close();
        emit(Verified());
      }
      catch(error){
        emit(Failed(error.toString()));
      }



    });
  }
}
