class AppUrl {
  //this is our base url
  static String baseUrl = 'https://disease.sh/v3/covid-19/';

  //fetch world covid status
  static String worldStatesApi = '${baseUrl}all';
  static String countriesList = '${baseUrl}countries';
}
