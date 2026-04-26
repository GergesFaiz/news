import 'package:news/utils/app_assets.dart';

class Category {
  String id;

  String title;

  String image;

  Category({required this.id, required this.title, required this.image});

  static List<Category> getCategoriesList({required bool isDark}) {
    return [
      Category(
        id: 'general',
        title: 'General',
        image: isDark
            ?AppAssets.generalDarkImage
            : AppAssets.generalLightImage,
      ),
      Category(
        id: 'business',
        title: 'Business',
        image: isDark
            ?AppAssets.businessDarkImage
            :AppAssets.businessLightImage ,
      ),
      Category(
        id: 'sports',
        title: 'Sports',
        image: isDark ? AppAssets.sportsDarkImage :AppAssets.sportsLightImage ,
      ),
      Category(
        id: 'technology',
        title: 'Technology',
        image: isDark
            ?AppAssets.technologyDarkImage
            : AppAssets.technologyLightImage,
      ),
      Category(
        id: 'entertainment',
        title: 'Entertainment',
        image: isDark
            ?  AppAssets.entertainmentDarkImage
            :AppAssets.entertainmentLightImage,
      ),
      Category(
        id: 'health',
        title: 'Health',
        image: isDark ?   AppAssets.healthDarkImage:AppAssets.healthLightImage,
      ),
      Category(
        id: 'science',
        title: 'Science',
        image: isDark
            ? AppAssets.scienceDarkImage
            :  AppAssets.scienceLightImage,
      ),
    ];
  }
}
