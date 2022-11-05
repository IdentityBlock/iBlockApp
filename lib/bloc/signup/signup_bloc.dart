import 'dart:collection';
import 'dart:convert';

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
        print(e);
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
        var contractAddress = result['contract-address'] as String;

        await SecureStorageService.store("private-key", privateKey);
        await SecureStorageService.store("contract-address", contractAddress);

        var userInfo = await service.getAll(contractAddress, privateKey)
            .timeout(const Duration(seconds: 10),
          onTimeout: (){
              throw Exception("Failed to fetch your user data");
          });

        emit(Success(userInfo));
      }
      catch(error){
        print(error.toString());
        emit(Failed(error.toString()));
      }
    });
  }
}
