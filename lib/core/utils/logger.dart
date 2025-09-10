import 'dart:developer' as developer;

void logInfo(String message) {
  developer.log(message, name: 'AppLogger', level: 800);
}

void logError(String message) {
  developer.log(message, name: 'AppLogger', level: 1000);
}
