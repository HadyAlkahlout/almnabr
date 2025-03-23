import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:teqani/app/app_preferances.dart';
import 'package:teqani/app/constant.dart';

class AppServiceClient {
  const AppServiceClient._internal(); // Private named constructor

  static const AppServiceClient instance =
      AppServiceClient._internal(); // Single instance -- Singleton

  factory AppServiceClient() => instance;

  GraphQLClient getAppClient(bool isAuth) {
    final HttpLink httpLink =
        HttpLink(isAuth ? Constant.authUrl : Constant.mainUrl);

    AuthLink? authLink;

    final Link link = Link.function((request, [forward]) {
      request = request.withContextEntry(
        HttpLinkHeaders(
          headers: {
            'Accept-Language': AppPreferences.getAppLanguage(), // Add dynamic language header
          },
        ),
      );
      return forward!(request);
    }).concat(httpLink);

    if(!isAuth){
      String token = AppPreferences.getUserToken();
      authLink = AuthLink(
        getToken: () async => 'Bearer $token',
      );
    } else {
      authLink = null;
    }

    final GraphQLClient client = GraphQLClient(
      link: isAuth ? link : authLink!.concat(httpLink),
      cache: GraphQLCache(store: HiveStore()), // Cache configuration
    );

    return client;
  }
}
