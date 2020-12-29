import 'package:flutter/material.dart';
import 'package:patron_bloc_app/src/bloc/login_bloc.dart';
import 'package:patron_bloc_app/src/bloc/provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _crearFondo(context),
          _loginForm(context)
        ],
      )
    );
  }

  Widget _crearFondo(context){
    final size = MediaQuery.of(context).size;

    final fondoMorado = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(63, 63, 156, 1.0),
            Color.fromRGBO(90, 70, 178, 1.0)
          ]
        )
      ),
    );
    
    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Color.fromRGBO(255, 255, 255, 0.05)
      ),
    );
    
    return Stack(
      children: [
        fondoMorado,
        Positioned(top: 90.0,left: 30.0,child: circulo),
        Positioned(top: -40.0,right: -30.0,child: circulo),
        Positioned(bottom: -50.0,right: -10.0,child: circulo),
        Positioned(bottom: 120.0,right: 20.0,child: circulo),
        Positioned(bottom: -50.0,left: -20.0,child: circulo),

        Container(
          padding: EdgeInsets.only(top:80.0),
          child: Column(
            children: [
              Icon(Icons.person_pin_circle, color: Colors.white, size:100.0),
              SizedBox(height: 10.0,width: double.infinity),
              Text('Iker Larrea', style: TextStyle(color: Colors.white, fontSize: 25.0))
            ],
          ),
        )
      ],
    );
  }

  Widget _loginForm(context){
    final size = MediaQuery.of(context).size;
    final bloc = Provider.of(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          SafeArea(
              child: Container(
                height: 180.0,
              )
          ),
          Container(
            width: size.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 30.0),
            padding: EdgeInsets.symmetric(vertical: 50.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 3.0,
                  offset: Offset(0.0,5.0),
                  spreadRadius: 3.0
                )
              ]
            ),
            child: Column(
              children: [
                Text('Login', style: TextStyle(fontSize: 20.0)),
                SizedBox(height: 60.0),
                _email(bloc),
                SizedBox(height: 30.0),
                _password(bloc),
                SizedBox(height: 30.0),
                _boton(bloc)
              ],
            ),
          ),
          Text('¿Olvido la contraseña?'),
          SizedBox(height: 100.0)
        ],
      ),
    );
  }

  Widget _email(LoginBloc bloc){
   return StreamBuilder(
     stream: bloc.emailStream,
     builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
       return Container(
         padding: EdgeInsets.symmetric(horizontal: 20.0),
         child: TextField(
           keyboardType: TextInputType.emailAddress,
           decoration: InputDecoration(
               icon: Icon(Icons.alternate_email,color:Colors.deepPurple),
               hintText: 'ejemplo@correo.com',
               labelText: 'Correo electrónico',
               errorText: snapshot.error,
               counterText: snapshot.data
           ),
           onChanged: bloc.changeEmail,
         )
       );
     },

   );

  }

  Widget _password(LoginBloc bloc){
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
                icon: Icon(Icons.lock_outlined,color:Colors.deepPurple),
                labelText: 'Password',
                errorText: snapshot.error,
                counterText: snapshot.data
            ),
            onChanged: bloc.changePassword,
          ),
        );
      }
    );
  }

  Widget _boton(LoginBloc bloc){
    return StreamBuilder(
        stream: bloc.formValidStream,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
          return RaisedButton(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
                child: Text('Aceptar'),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)
              ),
              elevation: 0.0,
              color: Colors.deepPurple,
              textColor: Colors.white,
              onPressed: snapshot.hasData ? () => _loginDatos(bloc,context): null
          );
        }
    );
  }
  
  _loginDatos(LoginBloc bloc, BuildContext context){
    Navigator.pushReplacementNamed(context, 'home');
  }

}
