part of search_map_place;

class Geocoding {
  Geocoding({this.apiKey, language = 'en'});
  String? apiKey;
  String? language;

  Future<Geolocation?> getGeolocation(String adress) async {
    String trimmedAdress = adress.replaceAllMapped(' ', (m) => '+');
    final String authority = "maps.googleapis.com";
    Map<String, String>  headers = {
        "Content-Type": "application/json",
        "Accept": "application/json" };
    final String path =
        "https://maps.googleapis.com/maps/api/geocode/json?address=$trimmedAdress&key=$apiKey&language=$language";
    final Uri url = Uri.parse(path);
    //"https://maps.googleapis.com/maps/api/geocode/json?address=$trimmedAdress&key=$apiKey&language=$language";
    final response = await http.get(url,headers: headers);
    final json = JSON.jsonDecode(response.body);
    if (json["error_message"] == null) {
      return Geolocation.fromJSON(json);
    } else {
      var error = json["error_message"];
      if (error == "This API project is not authorized to use this API.")
        error +=
            " Make sure both the Geolocation and Geocoding APIs are activated on your Google Cloud Platform";
      throw Exception(error);
    }
  }
}
