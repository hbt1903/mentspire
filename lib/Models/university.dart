class University {
  String countryCode, country, name;
  List<String> webPages = [];

  University.fromJson(Map<String, dynamic> data) {
    countryCode = data["alpha_two_code"];
    name = data["name"];
    country = data["country"];
    (data["web_pages"] as List<dynamic>).forEach((webPage) {
      webPages.add(webPage.toString());
    });
  }
}
