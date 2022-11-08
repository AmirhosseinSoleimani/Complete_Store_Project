class SliderObject{
  String title;
  String subTitle;
  String image;

  SliderObject(this.title,this.subTitle,this.image);
}

class Customer{
  String id;
  String name;
  int numOfNotification;
  Customer(this.id,this.name,this.numOfNotification);
}

class Contacts{
  String email;
  String phone;
  String link;
  Contacts(this.email,this.phone,this.link);
}

class Authentication{
  Customer customer;
  Contacts contacts;
  Authentication(this.customer,this.contacts);
}