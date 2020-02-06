import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:pixart/config/main_theme.dart';
import 'package:pixart/controllers/teddy_controller.dart';
import 'package:pixart/locator.dart';
import 'package:pixart/store/auth/auth.dart';
import 'package:pixart/store/auth/auth_validation.dart';
import 'package:pixart/widgets/button/gradient_button.dart';
import 'package:pixart/widgets/tracking_text_input.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RegistrationScreen();
}

class _RegistrationScreen extends State<RegistrationScreen> {
  Auth auth = locator<Auth>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = true;
  String _email = "";
  String _password = "";
  TeddyController _teddyController;

  @override
  initState() {
    _teddyController = TeddyController();
    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        if (!visible) {
          SystemChrome.restoreSystemUIOverlays();
        }
      },
    );
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
    auth.setContext(null);
  }

  String _confirm(String value) {
    return authValidation['confirmPassword'](value, _password);
  }

  List<Widget> _inputs(BuildContext context) {
    return [
      TrackingTextInput(
        label: "Email",
        hint: "What's your email address?",
        onValidation: authValidation['email'],
        keyboardType: TextInputType.emailAddress,
        onCaretMoved: (Offset caret) {
          _teddyController.lookAt(caret);
        },
        onSaved: (String value) {
          _email = value;
        },
      ),
      TrackingTextInput(
        label: "Password",
        hint: "Type password",
        onValidation: authValidation['password'],
        isObscured: true,
        onCaretMoved: (Offset caret) {
          _teddyController.coverEyes(caret != null);
          _teddyController.lookAt(null);
        },
        onTextChanged: (String value) {
          setState(() {
            _password = value;
          });
        },
        onSaved: (String value) {
          _password = value;
        },
      ),
      TrackingTextInput(
        label: "Confirm Password",
        hint: "Repeat password",
        onValidation: _confirm,
        isObscured: true,
        onCaretMoved: (Offset caret) {
          _teddyController.coverEyes(caret != null);
          _teddyController.lookAt(null);
        },
        onSaved: (String value) {
          _password = value;
        },
      ),
      GradientButton(
        child: Text(
          "Sign Up",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            auth.signup(
              _email,
              _password,
              _teddyController.submitSuccess,
              _teddyController.submitFailed,
            );
          } else {
            _teddyController.submitFailed();
          }
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    auth.setContext(context);
    return Scaffold(
      backgroundColor: Color.fromRGBO(93, 142, 155, 1.0),
      appBar: AppBar(
        centerTitle: true,
        title: Icon(Icons.person),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  // Box decoration takes a gradient
                  gradient: LinearGradient(
                    // Where the linear gradient begins and ends
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    // Add one stop for each color. Stops should increase from 0 to 1
                    stops: [0.0, 1.0],
                    colors: [
                      bgNavColor,
                      bgNavLightColor,
                    ],
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 200,
                      padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                      child: FlareActor(
                        "assets/flare/Teddy.flr",
                        shouldClip: false,
                        alignment: Alignment.bottomCenter,
                        fit: BoxFit.contain,
                        controller: _teddyController,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(25.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Form(
                          autovalidate: _autoValidate,
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: _inputs(context),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
