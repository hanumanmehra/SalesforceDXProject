public with sharing class Statusupdatehandler {

    //Method for validation of task canot change status untill it started 
    public static void statusUpdate(List<TaskCs__c> tasklist,map<id,TaskCs__c> tskmap1){                       
        for(TaskCs__c tcs :tasklist){
            if(tskmap1.get(tcs.Id).Task_Status__c =='Assigned' && tcs.Task_Status__c == 'Completed'){
                tcs.adderror('we cannot updated status completed untill it started');
            }
        }
    }


    public static void  statusoftask(List<TaskCs__c> listTs, map<id,TaskCs__c> tskmap){ 
        set<Id> taskIdset= new set<Id>();
        try{
            for( TaskCs__c  tsk :tskmap.values()){
                taskIdset.add(tsk.Process__c);
            }
            
            list<TaskCs__c> listoftask = [Select Name,Start_date__c,End_date__c,Task_Status__c,Assigned_To__c,Sequence__c,Process__c  From TaskCs__c  where Process__c =:taskIdset ORDER BY Sequence__c ASC];
            
            for(TaskCs__c  tskofnew :listTs ){
                if(tskmap.get(tskofnew.Id).Task_Status__c =='Assigned' && (tskofnew.Task_Status__c == 'Started' || tskofnew.Task_Status__c == 'Completed')){
                    
                    // for status conditions or trigger methods
                    for(TaskCs__c ts : listoftask){
                        if(ts.Sequence__c == 1 && ( ts.Task_Status__c =='Assigned')){   
                            tskofnew.adderror('you cannot updated status untill first is  started and not completed');
                        }
                        else{
                            for(integer i =0;i< listoftask.size();i++) {
                              if(i>0){
                                    if(listoftask[i].Task_Status__c =='Started' && listoftask[i].Id !=tskofnew.Id ){
                                        tskofnew.adderror('you cannot updated status untill any other task have started and not completed');
                                    }
                                    if(listoftask[i].Task_Status__c =='Started' && listoftask[i].Id ==tskofnew.Id){
         
                                        if( listoftask[i-1].Task_Status__c =='Assigned' || listoftask[i-1].Task_Status__c !='completed'){
                                            tskofnew.adderror('you cannot updated status untill before this task are not completed');
                                        }
                                    }   
                                }
                            }
                        }
                    }                   
                }
        else{   
            for(TaskCs__c  tskofnew1 :listTs ){
                if(tskofnew1.Task_Status__c == 'Assigned' && tskmap.get(tskofnew1.Id).Task_Status__c == 'Started'){
                    tskofnew1.adderror('we cannot updated status Started to  Assigned');
                }
            }                        
        }
    //status update today date
    for(TaskCs__c tcs :listoftask){
        if(tcs.End_date__c == date.Today()){
            for(TaskCs__c  tsknew :listTs){
                if(tsknew.Task_Status__c == 'Started'){
                    tsknew.adderror('we cannot updated status Started to if any other task started or completed today');
                }   
            }
        }
    }
}
}       

catch(Exception de){

}       
    }
    
    //Method for the delete validation on task
    public static void deltrigger(List<TaskCs__c> taskDellist){
        for(TaskCs__c task : taskDellist){
            //System.debug('you are in'+task.Task_Status__c );
            if(task.Task_Status__c =='Started' || task.Task_Status__c =='Completed' ){
                task.adderror('You cannot delete a task if status is started or completed');
            }
        }   
    }
    
}