import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../utils/accounts.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(Initial()) {
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
