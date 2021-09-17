import 'dart:io';

import 'package:amplify_flutter/amplify.dart';

import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:notes/utils/app_theme.dart';
import 'package:uuid/uuid.dart';

class CreateNoteRepository extends ChangeNotifier {
  CreateNoteRepository.instance();

  bool _loading = false;

  int _colorSelectedIndex = 0;
  String _colorSelected = '3d3d3f';

  String get colorSelected => _colorSelected;

  set colorSelected(String value) {
    _colorSelected = value;
    notifyListeners();
  }

  int get colorSelectedIndex => _colorSelectedIndex;

  set colorSelectedIndex(int value) {
    _colorSelectedIndex = value;
    notifyListeners();
  }

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        style: TextStyle(fontSize: 20),
      ),
      backgroundColor: ThemeColor.secondary,
    ));
  }

  final noteTitleController = TextEditingController();
  final noteDescriptionController = TextEditingController();
  int colorId = 0;

  Future<void> createNote(BuildContext context) async {
    var uuid = Uuid().v1();
    DateTime dateCreated = DateTime.now();


    loading = true;

    try {
      String graphQLDocument =
          '''mutation note(\$id: ID!,\$title:String!, \$description: String!,\$color:String!,\$createdOn:AWSTimestamp) {

  createNote(note: 
  {
   id: \$id,
   title:\$title,
   description:\$description,
   color:\$color,
   createdOn:\$createdOn
   }) {
      id
    title
    description
    color
    
  }
}''';

       var operation = Amplify.API.mutate(
          request: GraphQLRequest<String>(
        document: graphQLDocument,
        apiName: "cdk-notes-appsync-api_AMAZON_COGNITO_USER_POOLS",
        variables: {
          'id': uuid,
          'title': noteTitleController.text,
          'description': noteDescriptionController.text,
          'color': colorSelected,
          'createdOn': dateCreated.microsecondsSinceEpoch,
        },
      ));

      var response = await operation.response;

      var data = response.data;

      print('Mutation result is' + data);
      print('Mutation error: ' + response.errors.toString());


      loading = false;

    } catch (ex) {

      print(ex.toString());
      loading = false;

    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    noteTitleController.dispose();
    noteDescriptionController.dispose();
  }
}
