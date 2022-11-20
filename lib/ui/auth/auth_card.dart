import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/http_exception.dart';
import '../share/dialog_utils.dart';

import 'auth_manager.dart';

enum AuthMode { signup, login }

class AuthCard extends StatefulWidget {
  const AuthCard({
    super.key,
  });

  @override
  State<AuthCard> createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.login;
  final Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  final _isSubmitting = ValueNotifier<bool>(false);
  final _passwordController = TextEditingController();

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    _isSubmitting.value = true;

    try {
      if (_authMode == AuthMode.login) {
        // Log user in
        await context.read<AuthManager>().login(
              _authData['email']!,
              
              _authData['password']!,
            );
            
      } else {
        // Sign user up
        await context.read<AuthManager>().signup(
              _authData['email']!,
              _authData['password']!,
            );
      }
    } catch (error) {
      showErrorDialog(
          context,
          (error is HttpException)
              ? error.toString()
              : 'Authentication failed');
    }

    _isSubmitting.value = false;
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.login) {
      setState(() {
        _authMode = AuthMode.signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Stack(
        children: [
          
          Container(
            margin: const EdgeInsets.only(top: 400),
            width: double.infinity,
            height: _authMode == AuthMode.signup ? 320 : 260,
            
            constraints:
            BoxConstraints(minHeight: _authMode == AuthMode.signup ? 320 : 260),
            
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topRight: Radius.circular(40), topLeft: Radius.circular(40))
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
             margin: const EdgeInsets.only(top: 200, left: 50, right: 50),
            
            width: double.infinity,
            height: 400,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow:const [
                BoxShadow(
                  color: Colors.black38,
                  spreadRadius: 0.1,
                  blurRadius: 5
                )
              ]
            ),
            
            child: Form(
              key: _formKey,
              child:
            SingleChildScrollView(
              child: Column(children: [
              _buildEmailField(),
              const SizedBox(
                height: 20,
              ),
              _buildPasswordField(),
              if (_authMode == AuthMode.signup)
              
               _buildPasswordConfirmField(),
              
                const SizedBox(
                  height: 20,
                ),
                ValueListenableBuilder<bool>(
                  valueListenable: _isSubmitting,
                  builder: (context, isSubmitting, child) {
                    if (isSubmitting) {
                      return const CircularProgressIndicator();
                    }
                    return _buildSubmitButton();
                  },
                ),
                _buildAuthModeSwitchButton(),
            
            ]),)
            )
             
          ),
          Positioned(
            top: 70, left: 35,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text("Xin chào", 
               style:  TextStyle(color: Colors.white,
              fontWeight: FontWeight.bold, fontSize: 40),
              
              ),
              Text("Chào mừng bạn đến với Cooking with me", 
              style: TextStyle(color: Colors.white,
              fontWeight: FontWeight.w300, fontSize: 17),
              
              ),
              
            ],
          ))
          
          
        ],
      );
   
  }

  Widget _buildAuthModeSwitchButton() {
    return TextButton(
      onPressed: _switchAuthMode,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        textStyle: const TextStyle(
          color: Colors.deepPurple,
          
        ),
      ),
      child:
          Text('${_authMode == AuthMode.login ? 'SIGNUP' : 'LOGIN'} INSTEAD'),
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: const EdgeInsets.symmetric(horizontal: 50)
                ),
             
              //  child: const Text("Đăng Nhập")
                child: Text(_authMode == AuthMode.login ? 'LOGIN' : 'SIGN UP'),
               );
   
  }

  Widget _buildPasswordConfirmField() {
   
    return  TextFormField(
       enabled: _authMode == AuthMode.signup,
      decoration: InputDecoration(
          hintText: "Confirm Password",
          labelText: 'Confirm Password',
          prefixIcon: const Icon(Icons.key),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
          obscureText: true,
      validator: _authMode == AuthMode.signup
          ? (value) {
              if (value != _passwordController.text) {
                return 'Passwords do not match!';
              }
              return null;
            }
          : null,
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Password',
          hintText: "Password",
          prefixIcon: const Icon(Icons.key),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
          obscureText: true,
          controller: _passwordController,
      validator: (value) {
        if (value == null || value.length < 5) {
          return 'Password is too short!';
        }
        return null;
      },
      onSaved: (value) {
        _authData['password'] = value!;
      },
    );
   
  }

  Widget _buildEmailField() {
   
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'E-Mail',
          hintText: "E-Mail",
          prefixIcon: const Icon(Icons.email),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
          keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty || !value.contains('@')) {
          return 'Invalid email!';
        }
        return null;
      },
      onSaved: (value) {
        _authData['email'] = value!;
      },
    );
  }
}
