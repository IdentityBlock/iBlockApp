import 'dart:collection';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import '../../utils/accounts.dart';

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
      print(event);
      try{
        print("Into the try");
        String result = await Accounts.createAccount(event.name, event.email).timeout(const Duration(seconds: 10), onTimeout: (){
          throw Exception("Request Timed Out");
        });
        print(result);
        emit(Success());
      }
      catch(error){
        print(error.toString());
        emit(Failed(error.toString()));
      }
    });
  }
}
