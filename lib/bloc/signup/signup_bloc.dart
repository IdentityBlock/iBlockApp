import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import '../../services/secure_storage_service.dart';
import '../../services/user_contract_service.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  static const String countriesUrl = "https://api.first.org/data/v1/countries";

  SignupBloc() : super(Initial()) {

    on<LoadEvent>((event, emit) async{
      emit(Loading());

      List<String> countries = [];

      try{
        final response = await http.get(Uri.parse(countriesUrl));
        if(response.statusCode == 200){
          var responseJson = jsonDecode(response.body);
          responseJson['data'].values.forEach((element) {
           countries.add(element['country']);
          });
          emit(Loaded(countries));
        }
        else{
          emit(Failed("Error in getting data"));
        }
      }
      catch(e){
        log(e.toString());
        emit(Failed("Failed to access internet. Try again later!"));
      }
    });


    on<SubmitSignupEvent>((event, emit) async{
      emit(Submitted());
      try{

        var service = UserContractService();
        var result = await service.deploy(
            name: event.name,
            email: event.email,
            dob: event.dob,
            country: event.country,
            mobile: event.phone,
            gender: event.gender)
        .timeout(const Duration(seconds: 10),
        onTimeout: (){
          throw Exception("Failed to deploy your contract");
        });

        var privateKey = result['private-key'] as String;

        await SecureStorageService.store("private-key", privateKey);

        emit(PrivateKeyStored());
      }
      catch(error){
        log(error.toString());
        emit(Failed(error.toString()));
      }
    });

    on<AcceptingContractAddressEvent>((event, emit){
      emit(PrivateKeyStored());
    });

    on<ContractAddressSubmitEvent>((event, emit) async{
      emit(Loading());

      try {
        var service = UserContractService();
        var privateKey = await SecureStorageService.get("private-key") as String;

        var userInfo = await service.getAll(event.contractAddress, privateKey)
            .timeout(const Duration(seconds: 10),
            onTimeout: (){
              throw Exception("Failed to fetch your user data");
            });

        await SecureStorageService.store("contract-address", event.contractAddress);
        emit(Success(userInfo));

      }
      catch(e){
        log(e.toString());
        Failed(e.toString());
      }
    });

    on<RecoverySubmitEvent>((event, emit) async{
      emit(RecoverySubmitted());
      try{
        var service = UserContractService();
        var userInfo = await service.getAll(event.contractAddress, event.privateKey)
            .timeout(const Duration(seconds: 10),
            onTimeout: (){
              throw Exception("Failed to fetch your user data");
            });
        await SecureStorageService.store("private-key", event.privateKey);
        await SecureStorageService.store("contract-address", event.contractAddress);

        emit(Success(userInfo));
      }
      catch(error){
        log(error.toString());
        emit(Failed(error.toString()));
      }
    });
  }
}
