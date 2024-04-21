import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class TwoFiveAuthProvider {
  final FirebaseApp _app;
  late FirebaseAuth _auth;

  FirebaseAuth get auth => _auth;
  TwoFiveAuthProvider(this._app) {
    _auth = FirebaseAuth.instanceFor(app: _app);
  }
}
