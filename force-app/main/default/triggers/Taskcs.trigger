trigger Taskcs on TaskCs__c (after delete, after insert, after undelete,after update, before delete, before insert, before update){
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            TaskcsTriggerHandler.populateTaskFields(Trigger.new);
        }   
        
        else if(Trigger.isUpdate){
            Statusupdatehandler.statusUpdate(Trigger.new,Trigger.oldMap);
        }
        
        else if(Trigger.isDelete){
            Statusupdatehandler.deltrigger(Trigger.old);
        }
    } 
    
    if(Trigger.isAfter){
        
        if(Trigger.isDelete){ 
            TaskcsTriggerHandler.updatesequence(Trigger.old);
        }
        
        if(Trigger.isUpdate){
            Statusupdatehandler.statusoftask(Trigger.new,Trigger.oldMap);
            
            EmailHandler.sendTriggerEmail(Trigger.new,Trigger.oldMap);
  
            EndDateofProcessHandler.endDate(Trigger.new,Trigger.oldMap);
            EndDateofProcessHandler.startStatusofProcess(Trigger.new,Trigger.oldMap);  
        }
        
        else if(Trigger.isInsert){
            EmailHandler.sendTriggerEmail(Trigger.new,null);
        }
    }
}