// file for overarching application wide bloc decisions
// most importantly, determining user type and other such decisions

import 'package:fitnesstracker/bloc/application_state.dart';
import 'package:fitnesstracker/entities/profile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ApplicationBLoC extends Bloc<LoginEvent, ApplicationState> {

  Profile user = null;

  ApplicationState get initialState => LaunchApplication(user);

  Stream<ApplicationState> mapEventToState(LoginEvent event) async* {
    if (event is ClientLoginEvent) {
      // defined specifically as client login
    }

    if (event is TrainerLoginEvent) {
      // defined specifically as trainer login
    }
  }
}