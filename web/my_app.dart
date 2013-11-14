import 'dart:html';
import 'dart:convert';
import 'package:polymer_contacts/contacts.dart';
import 'package:polymer/polymer.dart';

@CustomTag('my-app')
class MyApp extends PolymerElement {

  MyApp.created() : super.created() {
    toObservable(Model.one.contacts.internalList);
    load();
  }

  load() {
    String json = window.localStorage['polymer_contacts'];
    if (json == null) {
      Model.one.init();
    } else {
      Model.one.fromJson(JSON.decode(json));
    }
  }
}