# Add project specific ProGuard rules here.
# You can control the set of applied configuration files using the
# proguardFiles setting in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}

# Uncomment this to preserve the line number information for
# debugging stack traces.
#-keepattributes SourceFile,LineNumberTable

# If you keep the line number information, uncomment this to
# hide the original source file name.
#-renamesourcefileattribute SourceFile

# Flutter specific rules
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }

# Keep native methods
-keepclassmembers class * {
    native <methods>;
}

# Keep Flutter engine classes
-keep class io.flutter.embedding.** { *; }
-keep class io.flutter.plugins.** { *; }

# Keep your app's main classes
-keep class com.aktisada.tilemanager.** { *; }

# Google Play Core rules (if not using Play Core, these can be ignored)
-dontwarn com.google.android.play.core.**
-keep class com.google.android.play.core.** { *; }

# Flutter deferred components (Play Store specific)
-dontwarn io.flutter.embedding.engine.deferredcomponents.**
-keep class io.flutter.embedding.engine.deferredcomponents.** { *; }

# Ignore missing classes warnings for Play Core
-dontwarn com.google.android.play.core.splitcompat.**
-dontwarn com.google.android.play.core.splitinstall.**
-dontwarn com.google.android.play.core.tasks.**
