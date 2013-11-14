import 'dart:html';
import 'dart:convert';
import 'package:polymer_contacts/contacts.dart';
import 'package:polymer/polymer.dart';

@CustomTag('table-form')
class TableForm extends PolymerElement {
  @published Contacts contacts  = Model.one.contacts;

  TableForm.created() : super.created();
  
  addContact(Event e, var detail, Node target) {
    InputElement firstname = shadowRoot.querySelector("#fn");
    InputElement lastname = shadowRoot.querySelector("#ln");
    InputElement phone = shadowRoot.querySelector("#ph");
    InputElement email = shadowRoot.querySelector("#em");
    LabelElement message = shadowRoot.querySelector("#message");
    var error = false;
    message.text = '';
    if (firstname.value.trim() == '') error = true;
    if (lastname.value.trim() == '') error = true;
    if (phone.value.trim() == '') error = true;
    if (email.value.trim() == '') error = true;
    if (!error) {
      var contact = new Contact(firstname.value, lastname.value, phone.value, email.value);
      if (contacts.add(contact)) {
        contacts.sort();
        save();
        clear();
        } else {
          message.text = 'this contact already exists';
        }
      }
    }
  
  clear() {
    InputElement firstname = shadowRoot.querySelector("#fn");
    InputElement lastname = shadowRoot.querySelector("#ln");
    InputElement phone = shadowRoot.querySelector("#ph");
    InputElement email = shadowRoot.querySelector("#em");
    LabelElement message = shadowRoot.querySelector("#message");
    firstname.value = '';
    lastname.value = '';
    phone.value = '';
    email.value = '';
  }
  
  clearContactInfos(Event e, var detail, Node target) {
    clear();
  }
  
  edit(Event e, var detail, Node target) {
    var name1 = (e.target as ButtonElement).title;
    var name2 = (e.target as ButtonElement).id;
    Contact contact = contacts.find(name1, name2);
    InputElement firstname = shadowRoot.querySelector("#fn");
    InputElement lastname = shadowRoot.querySelector("#ln");
    InputElement phone = shadowRoot.querySelector("#ph");
    InputElement email = shadowRoot.querySelector("#em");
    firstname.value = contact.firstName;
    lastname.value = contact.lastName;
    phone.value = contact.phone;
    email.value = contact.e_mail;
  }
  
  delete(Event e, var detail, Node target) {
    var name1 = (e.target as ButtonElement).title;
    var name2 = (e.target as ButtonElement).id;
    Contact contact = contacts.find(name1, name2);
    contacts.remove(contact);
  }
  
  save() {
    window.localStorage['polymer_contacts'] = JSON.encode(Model.one.toJson());
  }
}
