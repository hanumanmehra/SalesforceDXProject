trigger Totalcontacts on Contact (after insert,after update ,after delete,after undelete) 
{
    if(trigger.isinsert || trigger.isundelete)
    {
        AccountTriggerHandler.countAccount(trigger.new);
    }
    else if(trigger.isupdate)
    {
        AccountTriggerHandler.countAccountmap(trigger.new, trigger.oldmap);  
    }
    else if(trigger.isdelete)
    {
        AccountTriggerHandler.countAccount(trigger.old);
    }
}