trigger DevloperTrigger on Developer__c (after delete, after insert, after update,after undelete) 
{
    if(Trigger.isInsert || Trigger.isUnDelete)
    {
        DeveloperHandler.newdeveloper(Trigger.New);
    }
    else if(Trigger.isUpdate)
    {
        DeveloperHandler.updatedeveloperlist(Trigger.New,Trigger.oldMap);
    }
    else if(Trigger.isDelete)
    {
      DeveloperHandler.newdeveloper(Trigger.old);
    }
}