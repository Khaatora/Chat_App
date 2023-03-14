class RoomCategoryModel{

  static String sportsId="Sports";
  static String musicId="Music";
  static String moviesId="Movies";

  String id;
  late String name;
  late String image;

  RoomCategoryModel({required this.id, required this.name, required this.image});
  RoomCategoryModel.fromId(this.id){
    name = id;
    image = "assets/images/${id.toLowerCase()}.png";
  }
  
  static List<RoomCategoryModel> getCategories(){
    return [
      RoomCategoryModel.fromId(sportsId),
      RoomCategoryModel.fromId(musicId),
      RoomCategoryModel.fromId(moviesId),

    ];
}
}