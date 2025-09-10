import 'package:flutter/material.dart';

import 'app.dart';
import 'di/injector.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(MyApp());
}
