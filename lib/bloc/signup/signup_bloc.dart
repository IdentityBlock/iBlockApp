import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../utils/accounts.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(Initial()) {
    on<SubmitSignupEvent>((event, emit) async{
      emit(Submitted());

      //simulate the signup process
      // creating a wallet, storing the data in wallet
      await Accounts.createAccount(event.name, event.email);
      // await Future.delayed(const Duration(seconds: 3));

      emit(Success());
    });
  }
}
