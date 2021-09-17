import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_api/amplify_api.dart';

import 'list_notes_model.dart';
class QueryRepository extends ChangeNotifier {

  QueryRepository.instance();
  Future<ListNoteModel> getNotesList() async{

    String graphQLDocument =
    '''query listNotes {
  listNotes {
    color
    description
    id
    title
    createdOn
  }
}''';

    var operation = Amplify.API.query(


        request: GraphQLRequest<String>(document: graphQLDocument,apiName: "cdk-notes-appsync-api_API_KEY"));



    var response = await operation.response;

    final responseJson = json.decode(response.data);
 print("here"+ responseJson.toString());
    return ListNoteModel.fromJson(responseJson);

  }


}