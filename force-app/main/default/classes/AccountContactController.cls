public class AccountContactController
{
    public String selectedAccountId {get;set;}
    public List<Account> accountlist {get;set;}
    public List<Contact> contactList{get;set;}
    public AccountContactController()
    {
        
        accountlist  =  new List<Account>();
        contactList =  new List<Contact>();
        
       accountlist   = [Select Name,Ownership,Type, Site,AccountNumber from Account];
       System.debug('accountlist   ::'+accountlist);
    }
    
    public void SelAccountContacts()
    {
        System.debug('selectedAccountId ::'+selectedAccountId);
        contactList  = [Select Name, Email, phone,Account.Name from Contact where AccountId=:selectedAccountId];
    }
}