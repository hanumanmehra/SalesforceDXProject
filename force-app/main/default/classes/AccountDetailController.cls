public class AccountDetailController
{
    public String inputvalue{get;set;}
    public List<Account> accountlist;
    public List<Account> acclist{get;set;}
    Public String accId;
    public map<Id,Contact> contactmap{get;set;}
    
    public AccountDetailController(ApexPages.StandardController setcon)
    {
        Accountlist =  new List<Account>();
        acclist = new List<Account>();
        accId = setcon.getId();
        System.debug('Ids '+accId );
        contactmap = new  map<Id,Contact>();
        
        //Accountlist =  [Select Name,Total_Contacts__c,My_Contacts__c,(Select Name,Email,Phone,Account.Name from Contacts) From Account];
        //System.debug('Accountlist '+Accountlist );
        inputmethod();
        
    }
    public void inputmethod()
    {
        System.debug('inputvalue'+inputvalue);
        String querystr = 'Select Name,Total_Contacts__c,My_Contacts__c,(Select Name,Email,Phone,Account.Name from Contacts) From Account ';
        
        if(inputvalue != null)
        {
             querystr =+querystr +'where Name LIKE  \''+inputvalue + '%\'' ;
             System.debug('querystr'+querystr);
             
             Accountlist= database.query(querystr);
         }
         else
         {
            Accountlist= database.query(querystr); 
         }
         System.debug('listacc'+Accountlist);
         if(Accountlist !=null && Accountlist.size() >0)
         {
             for(Account ac:Accountlist )
             {
                 for(Contact con : ac.Contacts)
                 {
                   if(ac.id != null && con.id ==null)
                   {
                       acclist.add(ac);
                       contactmap.put(ac.Id,new Contact()); 
                   } 
                    else
                    {
                     acclist.add(ac);
                     contactmap.put(ac.Id,con);                   
                    }
                 }
             }
             System.debug(contactmap);
         }
          
    }
}