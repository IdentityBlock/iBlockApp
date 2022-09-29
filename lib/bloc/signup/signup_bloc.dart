import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../utils/accounts.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(Initial()) {
    on<SubmitSignupEvent>((event, emit) async{
      emit(Submitted());

      try{
        String result = await Accounts.createAccount(event.name, event.email);
      }
      catch(error){
        emit(Failed(error.toString()));
      }
      emit(Success());
    });
  }
}
