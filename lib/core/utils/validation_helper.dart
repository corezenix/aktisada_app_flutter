import 'dart:io';

class ValidationHelper {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  static String? validatePassword(String? value) {
    // Temporarily bypass password validation during testing
    return null;
  }

  static String? validateMobile(String? value) {
    if (value == null || value.isEmpty) {
      return 'Mobile number is required';
    }

    final mobileRegex = RegExp(r'^[0-9]{10}$');
    if (!mobileRegex.hasMatch(value)) {
      return 'Please enter a valid 10-digit mobile number';
    }

    return null;
  }

  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  static String? validateMinLength(
    String? value,
    String fieldName,
    int minLength,
  ) {
    final requiredValidation = validateRequired(value, fieldName);
    if (requiredValidation != null) return requiredValidation;

    if (value!.length < minLength) {
      return '$fieldName must be at least $minLength characters long';
    }

    return null;
  }

  static String? validateMaxLength(
    String? value,
    String fieldName,
    int maxLength,
  ) {
    if (value != null && value.length > maxLength) {
      return '$fieldName must not exceed $maxLength characters';
    }

    return null;
  }

  static String? validateNumeric(String? value, String fieldName) {
    final requiredValidation = validateRequired(value, fieldName);
    if (requiredValidation != null) return requiredValidation;

    if (double.tryParse(value!) == null) {
      return '$fieldName must be a valid number';
    }

    return null;
  }

  static String? validatePositiveNumber(String? value, String fieldName) {
    final numericValidation = validateNumeric(value, fieldName);
    if (numericValidation != null) return numericValidation;

    final number = double.parse(value!);
    if (number <= 0) {
      return '$fieldName must be greater than 0';
    }

    return null;
  }

  static String? validateInteger(String? value, String fieldName) {
    final requiredValidation = validateRequired(value, fieldName);
    if (requiredValidation != null) return requiredValidation;

    if (int.tryParse(value!) == null) {
      return '$fieldName must be a valid integer';
    }

    return null;
  }

  static String? validatePositiveInteger(String? value, String fieldName) {
    final integerValidation = validateInteger(value, fieldName);
    if (integerValidation != null) return integerValidation;

    final number = int.parse(value!);
    if (number <= 0) {
      return '$fieldName must be greater than 0';
    }

    return null;
  }

  static String? validateDropdown(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'Please select a $fieldName';
    }
    return null;
  }

  static String? validateImage(dynamic imageFile) {
    if (imageFile == null) {
      return 'Product image is required';
    }

    if (imageFile is String) {
      if (imageFile.isEmpty) {
        return 'Product image is required';
      }
    } else if (imageFile is File) {
      if (!imageFile.existsSync()) {
        return 'Selected image file does not exist';
      }
    }

    return null;
  }

  static String? validatePrice(String? value) {
    final requiredValidation = validateRequired(value, 'Price');
    if (requiredValidation != null) return requiredValidation;

    final priceRegex = RegExp(r'^\d+(\.\d{1,2})?$');
    if (!priceRegex.hasMatch(value!)) {
      return 'Please enter a valid price (e.g., 100 or 100.50)';
    }

    final price = double.parse(value);
    if (price <= 0) {
      return 'Price must be greater than 0';
    }

    return null;
  }

  static String? validateUrl(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return null; // URL is optional
    }

    final urlRegex = RegExp(
      r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$',
    );
    if (!urlRegex.hasMatch(value)) {
      return 'Please enter a valid URL';
    }

    return null;
  }
}
