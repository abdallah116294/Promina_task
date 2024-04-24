class DataModel {
final  List<String> image;

  DataModel({required this.image});
  factory DataModel.fromJson(Map<String,dynamic>json){
    return DataModel(image:json['images'].cast<String>() );
  }
  
}
