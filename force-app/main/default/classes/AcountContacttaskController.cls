public class AcountContacttaskController{

    public String editRecordId{ get; set; }
    public String deleteRecordId{ get; set;}
    public Contact con{get;set;}
    public List<Contact> listOFContacts{get;set;}
    public AcountContacttaskController(){
        con = new Contact();
       // listOFContacts=  new List<Contact>();
    }
    
    public void ContactsOFAccount(){
        String str=con.AccountId; 
        listOFContacts= [select name,id,email,AccountId,Phone,LastName from Contact where AccountId = :con.AccountId And AccountId != null];
    }
    public void EditContact(){
        System.debug('editRecordId'+editRecordId);
    }
     public void deleteContact(){
         System.debug('deleteRecordId'+deleteRecordId);

    }
    
        
}