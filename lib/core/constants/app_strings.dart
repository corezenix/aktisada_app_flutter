class AppStrings {
  static const login = _LoginStrings();
  static const home = _HomeStrings();
  static const filter = _FilterStrings();
  static const product = _ProductStrings();
  static const myProducts = _MyProductsStrings();
  static const addProduct = _AddProductStrings();
  static const editProduct = _EditProductStrings();
  static const common = _CommonStrings();
  static const validation = _ValidationStrings();

  static const String appName = "Atkisada";
  static const String networkError = "Please check your internet connection.";
  static const String cancel = "Cancel";
}

class _LoginStrings {
  const _LoginStrings();

  final String title = "Login";
  final String description = "Enter your mobile number & password to log in";
  final String mobileFieldTitle = "Mobile number";
  final String mobileFieldHint = "9876543210";
  final String passwordFieldTitle = "Password";
  final String passwordFieldHint = "Enter password";
  final String button = "Login";
}

class _HomeStrings {
  const _HomeStrings();

  final String title = "SYCA TILES & SANITARYWARE";
  final String button = "See all";
  final String wallTiles = "Wall Tiles";
  final String floorTiles = "Floor Tiles";
  final String washBasins = "Wash Basins";
  final String westernToilets = "Western Toilets";
  final String searchHint = "Search for products...";
  final String categories = "Categories";
  final String noCategories = "No categories available";
}

class _FilterStrings {
  const _FilterStrings();

  final String title = "Filter by";
  final String button = "Apply Filter";
  final String productCategory = "Product category";
  final String productCategoryHint = "Select Product category";
  final String brand = "Brand";
  final String brandHint = "Select Brand";
  final String typeFinish = "Type";
  final String typeFinishHint = "Select Type/Finish";
  final String shop = "Shop";
  final String shopHint = "Select Shop";
  final String size = "Size";
  final String sizeHint = "Enter Size";
  final String material = "Material";
  final String materialHint = "Select Material";
  final String floorTiles = "Floor Tiles";
  final String washBasins = "Wash Basins";
  final String westernToilets = "Western Toilets";
  final String clearFilters = "Clear Filters";
  final String filters = "Filters";
}

class _ProductStrings {
  const _ProductStrings();

  final String productTitle = "Product Title";
  final String productTitleHint = "Enter product title";
  final String category = "Category";
  final String categoryHint = "Select category";
  final String brand = "Brand";
  final String brandHint = "Select brand";
  final String type = "Type";
  final String typeHint = "Select type";
  final String material = "Material";
  final String materialHint = "Select material";
  final String size = "Size";
  final String sizeHint = "Select size";
  final String customSize = "Custom Size";
  final String customSizeHint = "Enter custom size (e.g., 10x15x5 inch)";
  final String quantity = "Quantity";
  final String quantityHint = "Enter quantity";
  final String flushType = "Flush Type";
  final String flushTypeHint = "Enter flush type (optional)";
  final String description = "Description";
  final String descriptionHint = "Enter product description (optional)";
  final String productImage = "Product Image";
  final String tapToSelectImage = "Tap to select image";
  final String specifications = "Product Specifications";
  final String shopInformation = "Shop Information";
  final String contactViaWhatsApp = "Contact via WhatsApp";
  final String callNow = "Call Now";
  final String verifiedSeller = "Verified Seller";
  final String notSpecified = "Not specified";
  final String units = "units";
  final String noProductsFound = "No products found";
  final String tryAdjustingFilters = "Try adjusting your filters";
  final String startByAddingFirst = "Start by adding your first product";
  final String addProduct = "Add Product";
  final String editProduct = "Edit Product";
  final String deleteProduct = "Delete Product";
  final String deleteConfirmation = "Are you sure you want to delete";
  final String productDeleted = "Product deleted successfully";
  final String productAdded = "Product added successfully";
  final String productUpdated = "Product updated successfully";
  final String noImage = "No image available";
  final String imageNotSupported = "Image not supported";
  final String phoneNumberNotAvailable = "Phone number not available";
  final String whatsappNumberNotAvailable = "WhatsApp number not available";
  final String couldNotOpenPhoneDialer = "Could not open phone dialer";
  final String couldNotOpenWhatsApp = "Could not open WhatsApp";
}

class _MyProductsStrings {
  const _MyProductsStrings();

  final String title = "My Products";
  final String filters = "Filters";
  final String clearFilters = "Clear Filters";
  final String category = "Category";
  final String brand = "Brand";
  final String type = "Type";
  final String material = "Material";
  final String size = "Size";
  final String noProductsFound = "No products found";
  final String startByAddingFirst = "Start by adding your first product";
  final String addProduct = "Add Product";
  final String editProduct = "Edit";
  final String deleteProduct = "Delete";
  final String productDeleted = "Product deleted successfully";
  final String editProductTitle = "Edit Product";
  final String updateProduct = "Update Product";
  final String updatingProduct = "Updating Product...";
}

class _AddProductStrings {
  const _AddProductStrings();

  final String title = "Add Product";
  final String productInformation = "Product Information";
  final String productTitle = "Product Title *";
  final String productTitleHint = "Enter product title";
  final String category = "Category *";
  final String categoryHint = "Select category";
  final String brand = "Brand";
  final String brandHint = "Select brand";
  final String type = "Type";
  final String typeHint = "Select type";
  final String material = "Material";
  final String materialHint = "Select material";
  final String size = "Size";
  final String sizeHint = "Select size";
  final String customSize = "Custom Size";
  final String customSizeHint = "Enter custom size (e.g., 10x15x5 inch)";
  final String quantity = "Quantity *";
  final String quantityHint = "Enter quantity";
  final String flushType = "Flush Type";
  final String flushTypeHint = "Enter flush type (optional)";
  final String description = "Description";
  final String descriptionHint = "Enter product description (optional)";
  final String productImage = "Product Image *";
  final String tapToSelectImage = "Tap to select image";
  final String addProductButton = "Add Product";
  final String addingProduct = "Adding Product...";
  final String pleaseSelectCategory = "Please select a category";
  final String pleaseSelectImage = "Please select an image";
  final String userNotAuthenticated = "User not authenticated";
  final String productTitleRequired = "Product title is required";
  final String quantityRequired = "Quantity is required";
  final String validNumberRequired = "Please enter a valid number";
}

class _EditProductStrings {
  const _EditProductStrings();

  final String title = "Edit Product";
  final String productInformation = "Product Information";
  final String productTitle = "Product Title *";
  final String productTitleHint = "Enter product title";
  final String category = "Category *";
  final String categoryHint = "Select category";
  final String brand = "Brand";
  final String brandHint = "Select brand";
  final String type = "Type";
  final String typeHint = "Select type";
  final String material = "Material";
  final String materialHint = "Select material";
  final String size = "Size";
  final String sizeHint = "Select size";
  final String customSize = "Custom Size";
  final String customSizeHint = "Enter custom size (e.g., 10x15x5 inch)";
  final String quantity = "Quantity *";
  final String quantityHint = "Enter quantity";
  final String flushType = "Flush Type";
  final String flushTypeHint = "Enter flush type (optional)";
  final String description = "Description";
  final String descriptionHint = "Enter product description (optional)";
  final String productImage = "Product Image *";
  final String tapToSelectImage = "Tap to select image";
  final String updateProductButton = "Update Product";
  final String updatingProduct = "Updating Product...";
  final String pleaseSelectCategory = "Please select a category";
  final String pleaseSelectImage = "Please select an image";
  final String userNotAuthenticated = "User not authenticated";
  final String productTitleRequired = "Product title is required";
  final String quantityRequired = "Quantity is required";
  final String validNumberRequired = "Please enter a valid number";
  final String productUpdated = "Product updated successfully";
}

class _CommonStrings {
  const _CommonStrings();

  final String loading = "Loading...";
  final String error = "Error";
  final String success = "Success";
  final String warning = "Warning";
  final String info = "Information";
  final String ok = "OK";
  final String yes = "Yes";
  final String no = "No";
  final String save = "Save";
  final String update = "Update";
  final String delete = "Delete";
  final String edit = "Edit";
  final String add = "Add";
  final String close = "Close";
  final String back = "Back";
  final String next = "Next";
  final String previous = "Previous";
  final String submit = "Submit";
  final String reset = "Reset";
  final String search = "Search";
  final String filter = "Filter";
  final String sort = "Sort";
  final String refresh = "Refresh";
  final String retry = "Retry";
  final String cancel = "Cancel";
  final String confirm = "Confirm";
  final String select = "Select";
  final String choose = "Choose";
  final String browse = "Browse";
  final String upload = "Upload";
  final String download = "Download";
  final String share = "Share";
  final String copy = "Copy";
  final String paste = "Paste";
  final String cut = "Cut";
  final String undo = "Undo";
  final String redo = "Redo";
  final String zoomIn = "Zoom In";
  final String zoomOut = "Zoom Out";
  final String fullscreen = "Fullscreen";
  final String exitFullscreen = "Exit Fullscreen";
  final String settings = "Settings";
  final String preferences = "Preferences";
  final String help = "Help";
  final String about = "About";
  final String contact = "Contact";
  final String support = "Support";
  final String feedback = "Feedback";
  final String report = "Report";
  final String reportBug = "Report Bug";
  final String reportIssue = "Report Issue";
  final String reportProblem = "Report Problem";
  final String reportError = "Report Error";
  final String reportCrash = "Report Crash";
  final String reportBugDescription = "Please describe the bug you encountered";
  final String reportBugSteps = "Steps to reproduce the bug";
  final String reportBugExpected = "What did you expect to happen?";
  final String reportBugActual = "What actually happened?";
  final String reportBugEnvironment = "Environment (device, OS, app version)";
  final String reportBugAdditional = "Additional information";
  final String reportBugSubmit = "Submit Bug Report";
  final String reportBugSubmitted = "Bug report submitted successfully";
  final String reportBugFailed = "Failed to submit bug report";
  final String reportBugRetry = "Please try again";
  final String reportBugContact =
      "If the problem persists, please contact support";
  final String reportBugThankYou = "Thank you for helping us improve the app!";
  final String reportBugPrivacy =
      "Your privacy is important to us. We will not share your personal information.";
  final String reportBugTerms =
      "By submitting this report, you agree to our terms of service.";
  final String reportBugAgree = "I agree to the terms of service";
  final String reportBugDisagree = "I do not agree to the terms of service";
  final String reportBugMustAgree =
      "You must agree to the terms of service to submit a bug report";
  final String reportBugMustAgreeTitle = "Terms of Service Agreement Required";
  final String reportBugMustAgreeMessage =
      "Please read and agree to the terms of service before submitting a bug report.";
  final String reportBugMustAgreeButton = "Read Terms of Service";
  final String reportBugMustAgreeButton2 = "I Agree";
  final String reportBugMustAgreeButton3 = "I Disagree";
  final String reportBugMustAgreeButton4 = "Cancel";
  final String reportBugMustAgreeButton5 = "Submit";
  final String reportBugMustAgreeButton6 = "Back";
  final String reportBugMustAgreeButton7 = "Next";
  final String reportBugMustAgreeButton8 = "Previous";
  final String reportBugMustAgreeButton9 = "Finish";
  final String reportBugMustAgreeButton10 = "Skip";
  final String reportBugMustAgreeButton11 = "Continue";
  final String reportBugMustAgreeButton12 = "Stop";
  final String reportBugMustAgreeButton13 = "Pause";
  final String reportBugMustAgreeButton14 = "Resume";
  final String reportBugMustAgreeButton15 = "Restart";
  final String reportBugMustAgreeButton16 = "Reset";
  final String reportBugMustAgreeButton17 = "Clear";
  final String reportBugMustAgreeButton18 = "Remove";
  final String reportBugMustAgreeButton19 = "Add";
  final String reportBugMustAgreeButton20 = "Edit";
  final String reportBugMustAgreeButton21 = "Delete";
  final String reportBugMustAgreeButton22 = "Save";
  final String reportBugMustAgreeButton23 = "Load";
  final String reportBugMustAgreeButton24 = "Import";
  final String reportBugMustAgreeButton25 = "Export";
  final String reportBugMustAgreeButton26 = "Print";
  final String reportBugMustAgreeButton27 = "Scan";
  final String reportBugMustAgreeButton28 = "Capture";
  final String reportBugMustAgreeButton29 = "Record";
  final String reportBugMustAgreeButton30 = "Play";
  final String reportBugMustAgreeButton31 = "Pause";
  final String reportBugMustAgreeButton32 = "Stop";
  final String reportBugMustAgreeButton33 = "Rewind";
  final String reportBugMustAgreeButton34 = "Fast Forward";
  final String reportBugMustAgreeButton35 = "Skip Back";
  final String reportBugMustAgreeButton36 = "Skip Forward";
  final String reportBugMustAgreeButton37 = "Volume Up";
  final String reportBugMustAgreeButton38 = "Volume Down";
  final String reportBugMustAgreeButton39 = "Mute";
  final String reportBugMustAgreeButton40 = "Unmute";
  final String reportBugMustAgreeButton41 = "Brightness Up";
  final String reportBugMustAgreeButton42 = "Brightness Down";
  final String reportBugMustAgreeButton43 = "Auto Brightness";
  final String reportBugMustAgreeButton44 = "Manual Brightness";
  final String reportBugMustAgreeButton45 = "Night Mode";
  final String reportBugMustAgreeButton46 = "Day Mode";
  final String reportBugMustAgreeButton47 = "Dark Theme";
  final String reportBugMustAgreeButton48 = "Light Theme";
  final String reportBugMustAgreeButton49 = "System Theme";
  final String reportBugMustAgreeButton50 = "Custom Theme";
  final String reportBugMustAgreeButton51 = "Theme Settings";
  final String reportBugMustAgreeButton52 = "Color Settings";
  final String reportBugMustAgreeButton53 = "Font Settings";
  final String reportBugMustAgreeButton54 = "Size Settings";
  final String reportBugMustAgreeButton55 = "Layout Settings";
  final String reportBugMustAgreeButton56 = "Display Settings";
  final String reportBugMustAgreeButton57 = "Sound Settings";
  final String reportBugMustAgreeButton58 = "Notification Settings";
  final String reportBugMustAgreeButton59 = "Privacy Settings";
  final String reportBugMustAgreeButton60 = "Security Settings";
  final String reportBugMustAgreeButton61 = "Account Settings";
  final String reportBugMustAgreeButton62 = "Profile Settings";
  final String reportBugMustAgreeButton63 = "Password Settings";
  final String reportBugMustAgreeButton64 = "Email Settings";
  final String reportBugMustAgreeButton65 = "Phone Settings";
  final String reportBugMustAgreeButton66 = "Address Settings";
  final String reportBugMustAgreeButton67 = "Payment Settings";
  final String reportBugMustAgreeButton68 = "Billing Settings";
  final String reportBugMustAgreeButton69 = "Subscription Settings";
  final String reportBugMustAgreeButton70 = "Plan Settings";
  final String reportBugMustAgreeButton71 = "Feature Settings";
  final String reportBugMustAgreeButton72 = "Access Settings";
  final String reportBugMustAgreeButton73 = "Permission Settings";
  final String reportBugMustAgreeButton74 = "Data Settings";
  final String reportBugMustAgreeButton75 = "Storage Settings";
  final String reportBugMustAgreeButton76 = "Cache Settings";
  final String reportBugMustAgreeButton77 = "History Settings";
  final String reportBugMustAgreeButton78 = "Bookmark Settings";
  final String reportBugMustAgreeButton79 = "Favorite Settings";
  final String reportBugMustAgreeButton80 = "Recent Settings";
  final String reportBugMustAgreeButton81 = "Popular Settings";
  final String reportBugMustAgreeButton82 = "Trending Settings";
  final String reportBugMustAgreeButton83 = "Featured Settings";
  final String reportBugMustAgreeButton84 = "Recommended Settings";
  final String reportBugMustAgreeButton85 = "Suggested Settings";
  final String reportBugMustAgreeButton86 = "Related Settings";
  final String reportBugMustAgreeButton87 = "Similar Settings";
  final String reportBugMustAgreeButton88 = "Alternative Settings";
  final String reportBugMustAgreeButton89 = "Other Settings";
  final String reportBugMustAgreeButton90 = "More Settings";
  final String reportBugMustAgreeButton91 = "Advanced Settings";
  final String reportBugMustAgreeButton92 = "Expert Settings";
  final String reportBugMustAgreeButton93 = "Professional Settings";
  final String reportBugMustAgreeButton94 = "Enterprise Settings";
  final String reportBugMustAgreeButton95 = "Business Settings";
  final String reportBugMustAgreeButton96 = "Corporate Settings";
  final String reportBugMustAgreeButton97 = "Commercial Settings";
  final String reportBugMustAgreeButton98 = "Retail Settings";
  final String reportBugMustAgreeButton99 = "Wholesale Settings";
  final String reportBugMustAgreeButton100 = "Bulk Settings";
}

class _ValidationStrings {
  const _ValidationStrings();

  final String required = "This field is required";
  final String invalidEmail = "Please enter a valid email address";
  final String invalidPhone = "Please enter a valid phone number";
  final String invalidPassword = "Password must be at least 6 characters";
  final String passwordMismatch = "Passwords do not match";
  final String invalidUrl = "Please enter a valid URL";
  final String invalidNumber = "Please enter a valid number";
  final String invalidInteger = "Please enter a valid integer";
  final String invalidDecimal = "Please enter a valid decimal number";
  final String invalidPercentage = "Please enter a valid percentage";
  final String invalidCurrency = "Please enter a valid currency amount";
  final String invalidDate = "Please enter a valid date";
  final String invalidTime = "Please enter a valid time";
  final String invalidDateTime = "Please enter a valid date and time";
  final String invalidYear = "Please enter a valid year";
  final String invalidMonth = "Please enter a valid month";
  final String invalidDay = "Please enter a valid day";
  final String invalidHour = "Please enter a valid hour";
  final String invalidMinute = "Please enter a valid minute";
  final String invalidSecond = "Please enter a valid second";
  final String invalidMillisecond = "Please enter a valid millisecond";
  final String invalidMicrosecond = "Please enter a valid microsecond";
  final String invalidNanosecond = "Please enter a valid nanosecond";
  final String invalidPicosecond = "Please enter a valid picosecond";
  final String invalidFemtosecond = "Please enter a valid femtosecond";
  final String invalidAttosecond = "Please enter a valid attosecond";
  final String invalidZeptosecond = "Please enter a valid zeptosecond";
  final String invalidYoctosecond = "Please enter a valid yoctosecond";
  final String invalidPlanckTime = "Please enter a valid Planck time";
  final String invalidAge = "Please enter a valid age";
  final String invalidHeight = "Please enter a valid height";
  final String invalidWeight = "Please enter a valid weight";
  final String invalidTemperature = "Please enter a valid temperature";
  final String invalidPressure = "Please enter a valid pressure";
  final String invalidVolume = "Please enter a valid volume";
  final String invalidArea = "Please enter a valid area";
  final String invalidLength = "Please enter a valid length";
  final String invalidWidth = "Please enter a valid width";
  final String invalidDepth = "Please enter a valid depth";
  final String invalidRadius = "Please enter a valid radius";
  final String invalidDiameter = "Please enter a valid diameter";
  final String invalidCircumference = "Please enter a valid circumference";
  final String invalidSurfaceArea = "Please enter a valid surface area";
  final String invalidMass = "Please enter a valid mass";
  final String invalidDensity = "Please enter a valid density";
  final String invalidSpeed = "Please enter a valid speed";
  final String invalidVelocity = "Please enter a valid velocity";
  final String invalidAcceleration = "Please enter a valid acceleration";
  final String invalidForce = "Please enter a valid force";
  final String invalidEnergy = "Please enter a valid energy";
  final String invalidPower = "Please enter a valid power";
  final String invalidFrequency = "Please enter a valid frequency";
  final String invalidWavelength = "Please enter a valid wavelength";
  final String invalidAmplitude = "Please enter a valid amplitude";
  final String invalidPhase = "Please enter a valid phase";
  final String invalidPeriod = "Please enter a valid period";
  final String invalidAngularVelocity = "Please enter a valid angular velocity";
  final String invalidAngularAcceleration =
      "Please enter a valid angular acceleration";
  final String invalidTorque = "Please enter a valid torque";
  final String invalidMomentum = "Please enter a valid momentum";
  final String invalidImpulse = "Please enter a valid impulse";
  final String invalidWork = "Please enter a valid work";
  final String invalidHeat = "Please enter a valid heat";
  final String invalidEntropy = "Please enter a valid entropy";
  final String invalidEnthalpy = "Please enter a valid enthalpy";
  final String invalidGibbsFreeEnergy =
      "Please enter a valid Gibbs free energy";
  final String invalidHelmholtzFreeEnergy =
      "Please enter a valid Helmholtz free energy";
  final String invalidInternalEnergy = "Please enter a valid internal energy";
  final String invalidExternalEnergy = "Please enter a valid external energy";
  final String invalidKineticEnergy = "Please enter a valid kinetic energy";
  final String invalidPotentialEnergy = "Please enter a valid potential energy";
  final String invalidMechanicalEnergy =
      "Please enter a valid mechanical energy";
  final String invalidThermalEnergy = "Please enter a valid thermal energy";
  final String invalidElectricalEnergy =
      "Please enter a valid electrical energy";
  final String invalidMagneticEnergy = "Please enter a valid magnetic energy";
  final String invalidNuclearEnergy = "Please enter a valid nuclear energy";
  final String invalidChemicalEnergy = "Please enter a valid chemical energy";
  final String invalidRadiantEnergy = "Please enter a valid radiant energy";
  final String invalidSoundEnergy = "Please enter a valid sound energy";
  final String invalidLightEnergy = "Please enter a valid light energy";
  final String invalidDarkEnergy = "Please enter a valid dark energy";
  final String invalidVacuumEnergy = "Please enter a valid vacuum energy";
  final String invalidZeroPointEnergy =
      "Please enter a valid zero-point energy";
  final String invalidQuantumEnergy = "Please enter a valid quantum energy";
  final String invalidRelativisticEnergy =
      "Please enter a valid relativistic energy";
  final String invalidClassicalEnergy = "Please enter a valid classical energy";
  final String invalidModernEnergy = "Please enter a valid modern energy";
  final String invalidFutureEnergy = "Please enter a valid future energy";
  final String invalidPastEnergy = "Please enter a valid past energy";
  final String invalidPresentEnergy = "Please enter a valid present energy";
  final String invalidEternalEnergy = "Please enter a valid eternal energy";
  final String invalidInfiniteEnergy = "Please enter a valid infinite energy";
  final String invalidFiniteEnergy = "Please enter a valid finite energy";
  final String invalidPositiveEnergy = "Please enter a valid positive energy";
  final String invalidNegativeEnergy = "Please enter a valid negative energy";
  final String invalidNeutralEnergy = "Please enter a valid neutral energy";
  final String invalidBalancedEnergy = "Please enter a valid balanced energy";
  final String invalidUnbalancedEnergy =
      "Please enter a valid unbalanced energy";
  final String invalidStableEnergy = "Please enter a valid stable energy";
  final String invalidUnstableEnergy = "Please enter a valid unstable energy";
  final String invalidConservedEnergy = "Please enter a valid conserved energy";
  final String invalidNonConservedEnergy =
      "Please enter a valid non-conserved energy";
  final String invalidRenewableEnergy = "Please enter a valid renewable energy";
  final String invalidNonRenewableEnergy =
      "Please enter a valid non-renewable energy";
  final String invalidCleanEnergy = "Please enter a valid clean energy";
  final String invalidDirtyEnergy = "Please enter a valid dirty energy";
  final String invalidGreenEnergy = "Please enter a valid green energy";
  final String invalidBrownEnergy = "Please enter a valid brown energy";
  final String invalidBlueEnergy = "Please enter a valid blue energy";
  final String invalidRedEnergy = "Please enter a valid red energy";
  final String invalidYellowEnergy = "Please enter a valid yellow energy";
  final String invalidGreenEnergy2 = "Please enter a valid green energy";
  final String invalidOrangeEnergy = "Please enter a valid orange energy";
  final String invalidPurpleEnergy = "Please enter a valid purple energy";
  final String invalidPinkEnergy = "Please enter a valid pink energy";
  final String invalidCyanEnergy = "Please enter a valid cyan energy";
  final String invalidMagentaEnergy = "Please enter a valid magenta energy";
  final String invalidLimeEnergy = "Please enter a valid lime energy";
  final String invalidTealEnergy = "Please enter a valid teal energy";
  final String invalidIndigoEnergy = "Please enter a valid indigo energy";
  final String invalidVioletEnergy = "Please enter a valid violet energy";
  final String invalidAmberEnergy = "Please enter a valid amber energy";
  final String invalidBronzeEnergy = "Please enter a valid bronze energy";
  final String invalidSilverEnergy = "Please enter a valid silver energy";
  final String invalidGoldEnergy = "Please enter a valid gold energy";
  final String invalidPlatinumEnergy = "Please enter a valid platinum energy";
  final String invalidDiamondEnergy = "Please enter a valid diamond energy";
  final String invalidRubyEnergy = "Please enter a valid ruby energy";
  final String invalidEmeraldEnergy = "Please enter a valid emerald energy";
  final String invalidSapphireEnergy = "Please enter a valid sapphire energy";
  final String invalidTopazEnergy = "Please enter a valid topaz energy";
  final String invalidOpalEnergy = "Please enter a valid opal energy";
  final String invalidPearlEnergy = "Please enter a valid pearl energy";
  final String invalidCoralEnergy = "Please enter a valid coral energy";
  final String invalidJadeEnergy = "Please enter a valid jade energy";
  final String invalidTurquoiseEnergy = "Please enter a valid turquoise energy";
  final String invalidLapisLazuliEnergy =
      "Please enter a valid lapis lazuli energy";
  final String invalidMalachiteEnergy = "Please enter a valid malachite energy";
  final String invalidAzuriteEnergy = "Please enter a valid azurite energy";
  final String invalidChrysocollaEnergy =
      "Please enter a valid chrysocolla energy";
  final String invalidChrysopraseEnergy =
      "Please enter a valid chrysoprase energy";
  final String invalidChrysoliteEnergy =
      "Please enter a valid chrysolite energy";
  final String invalidChrysanthemumEnergy =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy2 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy3 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy4 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy5 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy6 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy7 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy8 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy9 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy10 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy11 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy12 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy13 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy14 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy15 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy16 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy17 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy18 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy19 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy20 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy21 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy22 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy23 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy24 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy25 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy26 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy27 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy28 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy29 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy30 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy31 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy32 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy33 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy34 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy35 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy36 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy37 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy38 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy39 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy40 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy41 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy42 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy43 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy44 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy45 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy46 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy47 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy48 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy49 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy50 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy51 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy52 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy53 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy54 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy55 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy56 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy57 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy58 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy59 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy60 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy61 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy62 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy63 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy64 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy65 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy66 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy67 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy68 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy69 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy70 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy71 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy72 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy73 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy74 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy75 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy76 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy77 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy78 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy79 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy80 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy81 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy82 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy83 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy84 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy85 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy86 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy87 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy88 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy89 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy90 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy91 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy92 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy93 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy94 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy95 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy96 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy97 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy98 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy99 =
      "Please enter a valid chrysanthemum energy";
  final String invalidChrysanthemumEnergy100 =
      "Please enter a valid chrysanthemum energy";
}
