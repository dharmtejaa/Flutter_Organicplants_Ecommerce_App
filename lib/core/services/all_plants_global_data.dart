
import 'package:organicplants/models/all_plants_model.dart';

List<AllPlantsModel> allPlantsGlobal = [];
// Plant category-based lists
List<AllPlantsModel> indoorPlants = [];
List<AllPlantsModel> outdoorPlants = [];
List<AllPlantsModel> medicinalPlants = [];
List<AllPlantsModel> herbsPlants = [];
List<AllPlantsModel> floweringPlants = [];
List<AllPlantsModel> bonsaiPlants = [];
List<AllPlantsModel> succulentsCactiPlants = [];

// Tag-based (attribute) lists
List<AllPlantsModel> petFriendlyPlants = [];
List<AllPlantsModel> lowMaintenancePlants = [];
List<AllPlantsModel> airPurifyingPlants = [];
List<AllPlantsModel> sunLovingPlants = [];

List<AllPlantsModel> getPlantsByCategory(String category) {
  return allPlantsGlobal
      .where((plant) => plant.category!.toLowerCase() == category.toLowerCase())
      .toList();
}

List<AllPlantsModel> getPlantsByTag(String tag) {
  return allPlantsGlobal
      .where(
        (plant) => plant.tags!.any((t) => t.toLowerCase() == tag.toLowerCase()),
      )
      .toList();
}

final List<Map<String, String>> onboardingData = [
  {
    'image': 'assets/onBoarding/plant.json',
    'title': 'A plant for Every Space',
    'description':
        'Explore a wide selection of indoor and outdoor plants. Hand-picked for style, wellness, and every kind of space.',
  },
  {
    'image': 'assets/onBoarding/plantCaring.json',
    'title': 'Easy Tips for Happy Plants',
    'description':
        'Get clear care tips and gentle reminders. So your plants stay happy and healthy, no matter your experience level.',
  },
  {
    'image': 'assets/onBoarding/delivery.json',
    'title': 'Packed with Love, Delivered Safe',
    'description':
        'We use eco-friendly packaging and thoughtful handling to make sure your plant arrives safe, sound, and ready to grow.',
  },
  {
    'image': 'assets/onBoarding/community.json',
    'title': 'Grow Together with Plant Lovers',
    'description':
        'Share your journey, swap tips, and connect with a supportive community of fellow plant parents.',
  },
];

final List<Map<String, String>> banners = [
  {
    'imagePath': 'assets/banner/air_purifier_banner.png',
    'title': 'Air Purifying Plants',
    'subtitle': 'Breathe cleaner air with natural filters',
    'filterTag': 'Air_Purifying',
  },
  {
    'imagePath': 'assets/banner/low_maintenance_banner.png',
    'title': 'Low Maintenance Plants',
    'subtitle': 'Perfect for beginners and busy lives',
    'filterTag': 'Low_Maintenance',
  },
  {
    'imagePath': 'assets/banner/pet_friendly_banner.png',
    'title': 'Pet-Friendly Plants',
    'subtitle': 'Safe greenery for your furry friends',
    'filterTag': 'Pet_Friendly',
  },
  {
    "imagePath": "assets/banner/sun_loving_banner.png",
    "title": "Sun Loving Plants",
    "subtitle": "Thrive in bright, sunny spaces",
    "filterTag": "Sun_Loving",
  },
];

final List<Map<String, String>> categories = [
  {
    "imagePath": "assets/category/indoor.png",
    "title": "Indoor Plants",
    "filterTag": "Indoor plant",
  },
  {
    "imagePath": "assets/category/outdoor.png",
    'title': "Outdoor Plants",
    "filterTag": "Outdoor plant",
  },
  {
    "imagePath": "assets/category/medicinal.png",
    "title": "Medicinal Plants",
    "filterTag": "Medicinal plants",
  },
  {
    "imagePath": "assets/category/herbs.png",
    "title": "Herbs Plants",
    "filterTag": "Herbs plant",
  },
  {
    "imagePath": "assets/category/flowering.png",
    "title": "Flowering Plants",
    "filterTag": "Flowering plant",
  },
  {
    "imagePath": "assets/category/bonsai.png",
    "title": "Bonsai Plants",
    "filterTag": "Bonsai plant",
  },
  {
    "imagePath": "assets/category/succulent.png",
    "title": "Succulents Plants",
    "filterTag": "Succulents & Cacti Plants",
  },
];
