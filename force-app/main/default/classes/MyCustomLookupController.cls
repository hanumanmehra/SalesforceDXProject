public with sharing class MyCustomLookupController {

  public Contact part{get;set;}
  public Contact contact {get;set;}
  public MyCustomLookupController() {
    part= new Contact();
  }

}