import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// overarching application state
class ApplicationState extends Equatable {
  @override
  List<Object> get props => [];
}

// Client View State
class ClientViewState extends ApplicationState {
  // Call Client View?
}

// Trainer View State
class TrainerViewState extends ApplicationState {
  // Call Trainer View?
}