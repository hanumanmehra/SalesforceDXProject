public with sharing class TaskcsTriggerHandler {

    // Mehtod of auto assigned task status at new create
    public static void populateTaskFields(List< TaskCs__c> taskList){
    
        Map<String,Integer> processAndTaskCountMap = new Map<String,Integer>();
        
        for(Process__c proce : [SELECT Id,Sequence_Count__c FROM Process__c]){
            processAndTaskCountMap.put(proce.id,Integer.valueOf(proce.Sequence_Count__c));
        }
        for(TaskCs__c task : taskList){
            task.Task_Status__c = 'Assigned';
            task.Sequence__c = processAndTaskCountMap.get(task.Process__c) + 1;
        }
     }
     
     //method of update task sequence number when delete a task
     public static void updatesequence(List<TaskCs__c> taskSeqlist){
        set<Id> taskIdset= new set<Id>();
        
        for( TaskCs__c  tsk :taskSeqlist){
           // System.debug('tsk'+tsk);
            taskIdset.add(tsk.Process__c);
        }
        system.debug('taskIdset'+taskIdset);
        
        Process__c porcess =[Select Name,Description__c,Start_Date__c,End_Date__c,Status__c,(Select Name,Start_date__c,End_date__c,Task_Status__c,Assigned_To__c,Sequence__c,Process__c  From TaskCs__r ORDER BY Sequence__c ASC) From Process__c where id IN:taskIdset limit 1];
        
            for(TaskCs__c  tsk1 :taskSeqlist) { 
            
                if(tsk1.Task_Status__c =='Assigned')
                {
                    System.debug('processtasklist'+porcess.TaskCs__r);
                    for( TaskCs__c  tcs :porcess.TaskCs__r) {
                        if(tcs.Sequence__c >tsk1.Sequence__c) {
                            tcs.Sequence__c = tcs.Sequence__c-1;
                            system.debug('tcs.Sequence__c ::::::'+tcs.Sequence__c);
                        }
                    }
                }
                else{
                    tsk1.adderror('You canot delete this task'); 
                    System.debug('We are the delete validation'+tsk1);
                }
            }
        update porcess.TaskCs__r;
        system.debug('porcess.TaskCs__r ::::::'+porcess.TaskCs__r);
     }
}