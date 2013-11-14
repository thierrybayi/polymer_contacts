library contacts;

class Contact implements Comparable {
  String firstName;
  String lastName;
  String phone;
  String e_mail;
  
  Contact(this.firstName, this.lastName, this.phone, this.e_mail) {
  }

  Contact.fromJson(Map<String, Object> contactMap) {
    firstName = contactMap['firstName'];
    lastName = contactMap['firstName'];
    phone = contactMap['phone'];
    e_mail = contactMap['e_mail'];
  }

  Map<String, Object> toJson() {
    var contactMap = new Map<String, Object>();
    contactMap['firstName'] = firstName;
    contactMap['lastName'] = lastName;
    contactMap['phone'] = phone;
    contactMap['e_mail'] = e_mail;
    return contactMap;
  }

  String toString() {
    return '{firstName: ${firstName}, lastName: ${lastName}, phone: ${phone}, e_mail: ${e_mail} }';
  }

  int compareTo(Contact contact) {
    if (firstName != null && contact.firstName != null) {
      return firstName.compareTo(contact.firstName);
    } else {
      throw new Exception('a contact first name must be present');
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
      throw new Exception('a new Contact must be present');
    }
    for (Contact contact in this) {
      if (newContact.firstName == contact.firstName && newContact.lastName == contact.lastName) return false;
    }
    _list.add(newContact);
    return true;
  }

  Contact find(String name1, String name2) {
    for (Contact contact in _list) {
      if (contact.firstName == name1 && contact.lastName == name2) return contact;
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
    var  contact1 = new Contact('Bob', 'Smith', '4182557151', 'bob@yahoo.fr');
    var contact2 = new Contact('Alice', 'Johnson', '4182557878', 'alice@yahoo.fr');
    var contact3 = new Contact('Thierry', ' Franck', '4182557189', 'thierry@yahoo.fr');
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
