class Constant{
  static const String _developmentBase = 'https://dev.btqn.sa';
  //static const String _liveBase = 'https://btqn.sa';
  static const String _baseUrl = _developmentBase;

  static const String authUrl = '$_baseUrl/api/graphql';
  static const String mainUrl = '$_baseUrl/api/graphql/auth';
}