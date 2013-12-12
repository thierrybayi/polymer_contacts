library contacts;

class Contact implements Comparable {
  String name;
  String phone;
  String e_mail;

  Contact(this.name, this.phone, this.e_mail) {
  }

  Contact.fromJson(Map<String, Object> contactMap) {
    name = contactMap['name'];
    phone = contactMap['phone'];
    e_mail = contactMap['e_mail'];
  }

  Map<String, Object> toJson() {
    var contactMap = new Map<String, Object>();
    contactMap['name'] = name;
    contactMap['phone'] = phone;
    contactMap['e_mail'] = e_mail;
    return contactMap;
  }
  
  String toString() {
    return '{name: ${name}, phone: ${phone}, e_mail: ${e_mail}}';
  }

  int compareTo(Contact contact) {
    if (name != null && contact.name != null) {
      return name.compareTo(contact.name);
    } else {
      throw new Exception('a contact name must be present');
    }
  }
}

class Contacts {
  var _list = new List<Contact>();

  Iterator<Contact> get iterator => _list.iterator;
  bool get isEmpty => _list.isEmpty;

  List<Contact> get internalList => _list;
  set internalList(List<Contact> observableList) => _list = observableList;

  bool add(Contact newContact) {
    if (newContact == null) {
      throw new Exception('a new contact must be present');
    }
    for (Contact contact in this) {
      if (newContact.name == contact.name) return false;
    }
    _list.add(newContact);
    return true;
  }

  Contact find(String name) {
    for (Contact contact in _list) {
      if (contact.name == name) return contact;
    }
    return null;
  }

  bool remove(Contact contact) {
    return _list.remove(contact);
  }

  sort() {
    _list.sort();
  }
}

class Model {
  var contacts = new Contacts();
  static Model model;
  Model.private();
  static Model get one {
    if (model == null) {
      model = new Model.private();
    }
    return model;
  }
  // singleton

  init() {
    var contact1 = new Contact('Arlette Gounou', '418', 'arlette@hotmail.fr');
    var contact2 = new Contact('Thierry Henri', '428', 'thierry@yahoo.fr');
    var contact3 = new Contact('Joelle Perrier', '43898709009', 'joelle@yahoo.fr');
    Model.one.contacts..add(contact1)..add(contact2)..add(contact3);
  }

  List<Map<String, Object>> toJson() {
    var contactList = new List<Map<String, Object>>();
    for (Contact contact in contacts) {
      contactList.add(contact.toJson());
    }
    return contactList;
  }

  fromJson(List<Map<String, Object>> contactList) {
    if (!contacts.isEmpty) {
      throw new Exception('contacts are not empty');
    }
    for (Map<String, Object> contactMap in contactList) {
      Contact contact = new Contact.fromJson(contactMap);
      contacts.add(contact);
    }
  }
}
