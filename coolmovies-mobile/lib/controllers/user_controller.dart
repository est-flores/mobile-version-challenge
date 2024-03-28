import 'package:coolmovies/models/user.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class UserController extends ChangeNotifier {
  User currentUser = User(id: '', name: '');

  fetchCurrentUser(BuildContext context) async {
    var client = GraphQLProvider.of(context).value;

    final QueryResult result = await client.query(QueryOptions(
      document: gql(r"""
          query {
              currentUser {
                id
                name
              }
            }
        """),
    ));
    final Map<String, dynamic>? userData = result.data?['currentUser'];
    currentUser = User(
      id: userData?['id'],
      name: userData?['name'],
    );
    notifyListeners();
  }
}
