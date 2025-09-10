class AppAssets {
  static final images = _ImageAssets();
  static final svg = _SvgAssets();
  static final audio = _AudioAssets();
  static final video = _VideoAssets();
  static final animations = _AnimationAssets();
  static final dummy = _DummyAssets();
}

class _ImageAssets {
  //images
  final String logo = 'assets/images/app_logo.png';
  final String banner1 = 'assets/images/banner-1.png';
  final String wallTiles = 'assets/images/wall_tiles.png';
  final String floorTiles = 'assets/images/floor_tiles.png';
  final String washBasins = 'assets/images/wash_basins.png';
  final String westernToilets = 'assets/images/western_toilets.png';
}

class _SvgAssets {
  //icons
  final String productListIcon = 'assets/icons/product_unselected.svg';
  final String productListFilledIcon = 'assets/icons/product_selected.svg';
  final String myProductsIcon = 'assets/icons/my_products_unselected.svg';
  final String myProductsFilledIcon = 'assets/icons/my_products_selected.svg';

  final String homeIcon = 'assets/icons/home_unselected.svg';
  final String homeFilledIcon = 'assets/icons/home_selected.svg';

  final String profileIcon = 'assets/icons/profile_unselected.svg';
  final String profileFilledIcon = 'assets/icons/profile_selected.svg';

  final String whatsAppIcon = 'assets/icons/whatsapp_icon.svg';
  final String editIcon = 'assets/icons/edit_icon.svg';
  final String deleteIcon = 'assets/icons/delete_icon.svg';
}

class _AudioAssets {
  final String clickSound = 'assets/audio/click_sound.mp3';
}

class _VideoAssets {
  final String introVideo = 'assets/video/intro.mp4';
}

class _AnimationAssets {
  final String loading = 'assets/animations/loading.json';
}

class _DummyAssets {
  final String placeholderImage = 'assets/dummy/placeholder.jpg';
}
