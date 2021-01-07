import 'package:grocery_list/models/api_model.dart';
import 'package:grocery_list/models/household.dart';
import 'package:grocery_list/models/list_section.dart';

class Recipe extends ApiModel {
  int id;
  String title;
  Household household;
  String instrcutions;
  int standardServing;
  List<ListSection> listSection;

  Recipe();
  Recipe.fromMap(Map<String, dynamic> map) {
    this.loadMap(map);
  }

  @override
  ApiModel clone() {
    return Recipe()
      ..id = this.id
      ..title = this.title
      ..household = this.household
      ..instrcutions = this.instrcutions
      ..standardServing = this.standardServing
      ..listSection = this.listSection.map((ls) => ls.clone());
  }

  @override
  void loadMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.title = map['title'];
    this.household = Household.fromMap(map['household']);
    this.instrcutions = map['instrcutions'];
    this.standardServing = map['standard_serving'];
    this.listSection = [];
    for(Map<String, dynamic> ls in map['list_section_set']){
      this.listSection.add(ListSection.fromMap(ls));
    }
  }

  @override
  get pk => this.id;

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'title': this.title,
      'household': this.household.toMap(),
      'instrcutions': this.instrcutions,
      'standard_serving': this.standardServing,
      'list_section_set': this.listSection.map((ls) => ls.toMap()),
    };
  }
}
