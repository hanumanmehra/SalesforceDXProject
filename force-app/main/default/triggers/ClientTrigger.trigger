trigger ClientTrigger on Client__c (after delete, after insert, after update,after undelete) 
{	
    if(Trigger.isInsert || Trigger.isUnDelete)
    {
        ClientHandler1.newClient(Trigger.New);
    }
    else if(Trigger.isUpdate)
    {
        ClientHandler1.updateClientlist(Trigger.New,Trigger.oldMap);
    }
    else if(Trigger.isDelete)
    {
      ClientHandler1.newClient(Trigger.old);
    }
}