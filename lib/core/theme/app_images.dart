abstract class AppImages {
  String get example;
}

class AppImagesDefault implements AppImages {
  @override
  String get example => "assets/images/avatar1.png";
}
