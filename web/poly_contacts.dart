import 'dart:html';
import 'dart:convert';
import 'package:polymer_contacts/contacts.dart';
import 'package:polymer/polymer.dart';

@CustomTag('poly-contacts')
class PolyContacts extends PolymerElement {
  @published Contacts contacts = Model.one.contacts;

  PolyContacts.created() : super.created();

  add(Event e, var detail, Node target) {
    InputElement name = shadowRoot.querySelector("#name");
    InputElement phone = shadowRoot.querySelector("#phone");
    InputElement e_mail = shadowRoot.querySelector("#e_mail");
    LabelElement message = shadowRoot.querySelector("#message");
    var error = false;
    message.text = '';
    if (name.value.trim() == '') error = true;
    if (phone.value.trim() == '') error = true;
    if (e_mail.value.trim() == '') error = true;
    if (!error) {
      var contact = new Contact(name.value, phone.value, e_mail.value);
      if (contacts.add(contact)) {
        contacts.sort();
        save();
      } else {
        message.text = 'web contact with that name already exists';
      }
    }
  }
  
  clear(Event e, var detail, Node target) {
    InputElement name = shadowRoot.querySelector("#name");
    InputElement phone = shadowRoot.querySelector("#phone");
    InputElement e_mail = shadowRoot.querySelector("#e_mail");
    name.value = '';
    phone.value = '';
    e_mail.value = '';
  }

  modify(Event e, var detail, Node target) {
    ButtonElement btn = e.target;
    InputElement name = shadowRoot.querySelector("#name");
    InputElement phone = shadowRoot.querySelector("#phone");
    InputElement e_mail = shadowRoot.querySelector("#e_mail");
    Contact contact = contacts.find(btn.id);
    name.value = contact.name;
    phone.value = contact.phone;
    e_mail.value = contact.e_mail;
    contacts.remove(contact);
    save();
  }
  
  delete(Event e, var detail, Node target) {
    ButtonElement btn = e.target;
    LabelElement message = shadowRoot.querySelector("#message");
    message.text = '';
    Contact contact = contacts.find(btn.id);
    if (contacts.remove(contact)) {
      contacts.sort();
      save();
      window.location.reload();
    } else {
      message.text = 'web contact with that name doesn\'t exists';
    }
  }

  save() {
    window.localStorage['polymer_contacts'] = JSON.encode(Model.one.toJson());
  }
}