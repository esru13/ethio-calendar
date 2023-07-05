class Description {
  String? id;
  String? name;
  String? description;
  double latitude=0 ;
  double longitude=0;
  String? category;
  String? image;

  Description(
      this.id,
      this.name,
      this.description,
      this.latitude,
      this.longitude,
      this.category,
      this.image
      );
  Description.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    category = json['category'];
    image = json['image'];
  }
}
