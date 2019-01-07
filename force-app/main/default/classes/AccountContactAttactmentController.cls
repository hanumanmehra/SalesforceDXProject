public with sharing class AccountContactAttactmentController 
{
    public Account acc{get;set;}
    public List<Contact> contactlist{get;set;}
    public String vfContainsValue{get;set;}
    public String Id{get;set;}
    
    public AccountContactAttactmentController(ApexPages.StandardController contrl)
    {
        Id='';
        Id=contrl.getId();
        contactlist = new List<Contact>();
        acc = [Select Name,(Select Name,Title,Department,CleanStatus from Contacts)From Account Where Id =:Id];
        //System.debug('acc'+acc);
        //System.debug('+acc.Contacts ::'+acc.Contacts);
        
        for(Contact con :acc.Contacts)
        {
            contactlist.add(con);
        }
    }
    public void VFPageContains()
    {
       // System.debug('Hanuman JI ke contains>>>'+vfContainsValue);
    
    }

}