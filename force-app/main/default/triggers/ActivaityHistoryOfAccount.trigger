trigger ActivaityHistoryOfAccount on Opportunity (after insert,after update ) {
    map<Id,Opportunity> mapOfAccountOpportuntiy  = new Map<id,Opportunity>();
  
    for(Opportunity opp : trigger.new){
        mapOfAccountOpportuntiy.put(opp.AccountId,Opp); 
        if(opp.AccountId != null && opp.AccountId != trigger.oldMap.get(opp.id).AccountId) {
            mapOfAccountOpportuntiy.put(opp.AccountId,Opp);  
        }  
    }
    
    if(mapOfAccountOpportuntiy != null && mapOfAccountOpportuntiy.keyset().size() > 0){
       List<Task> listOfcreatedTask =  new List<Task>();
       for(Account acc: [Select id ,name,OwnerId,(select id,Name from Opportunities) From Account Where Id In:mapOfAccountOpportuntiy.keyset()]){
           if(mapOfAccountOpportuntiy.containskey(acc.Id)){
               //List<Opportunity> listofOpportunity = mapOfAccountOpportuntiy.get(acc.Id);
               if(acc.Opportunities.size() > 0 && acc.Opportunities.size() >=3 ){
                   Task tsk= new task();
                   tsk.Subject ='Other';
                   tsk.ActivityDate =Date.Today(); 
                   tsk.WhatId =acc.Id;
                   tsk.OwnerId  =acc.OwnerId ;
                   listOfcreatedTask.add(tsk);
               }
               
              
           }
          
       }
       
    }
}