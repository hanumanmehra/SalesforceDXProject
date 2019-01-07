trigger TotalContacttrigger on Contact(after insert,after update,after delete,after undelete) 
{
    List<Contact> contactList  = trigger.isdelete ? trigger.old:trigger.new;
    
    Set<id> setOFIds =  new Set<id>();
    for(Contact con : contactList  )
    {
        if((trigger.Isupdate) && (con.AccountId != trigger.oldmap.get(con.Id).AccountId))
        {
            setOFIds.add(trigger.oldmap.get(con.Id).AccountId);
            setOFIds.add(con.AccountId);     
        }
            setOFIds.add(con.AccountId);
    }
    if(setOFIds != null && setOFIds.size() >0)
    {
        List<Account> listOfAccount = [Select Id,Name,Total_Number_Contact__c,(Select Id,Name from Contacts ) from Account Where Id In:setOFIds];
        
        if(listOfAccount  != null && listOfAccount.size() >0)
        {
            for(Account ac: listOfAccount ) 
            {
                ac.Total_Number_Contact__c =(ac.contacts).size();
            }
            
           update listOfAccount ;
        }
    }
}