import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:patron_bloc_app/src/bloc/validators.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with Validators{
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

 // Recuperar los datos del Stream
 Stream<String> get emailStream => _emailController.stream.transform(validarEmail);
 Stream<String> get passwordStream => _passwordController.stream.transform(validarPassword);

 Stream<bool> get formValidStream => Rx.combineLatest2(emailStream, passwordStream, (e, p) => true);

 // Insertar valores al Stream
 Function(String) get changeEmail => _emailController.sink.add;
 Function(String) get changePassword => _passwordController.sink.add;

 // Get de Streams
 String get email => _emailController.value;
 String get password => _passwordController.value;

 dispose(){
   _emailController?.close();
   _passwordController?.close();
 }

}