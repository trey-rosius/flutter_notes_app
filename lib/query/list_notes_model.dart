
class ListNoteModel {
  List<ListNotes>? listNotes;

  ListNoteModel({this.listNotes});

  ListNoteModel.fromJson(Map<String, dynamic> json) {
    if (json['listNotes'] != null) {
      listNotes = <ListNotes>[];
      json['listNotes'].forEach((v) {
        listNotes!.add(new ListNotes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.listNotes != null) {
      data['listNotes'] = this.listNotes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListNotes {
  String? color;
  String? description;
  String? id;
  String? title;
  int? createdOn;

  ListNotes(
      {this.color, this.description, this.id, this.title, this.createdOn});

  ListNotes.fromJson(Map<String, dynamic> json) {
    color = json['color'];
    description = json['description'];
    id = json['id'];
    title = json['title'];
    createdOn = json['createdOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['color'] = this.color;
    data['description'] = this.description;
    data['id'] = this.id;
    data['title'] = this.title;
    data['createdOn'] = this.createdOn;
    return data;
  }
}
