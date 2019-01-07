public with sharing class DeveloperHandler {   
    public Static void newdeveloper(List<Developer__c> listDeveloper){
        Set<Id> setDeveloperIds = new Set<Id>();
        for(Developer__c pc : listDeveloper){
            if(pc.Id!= null){
                setDeveloperIds.add(pc.Management__c);
            }   
        }  
        if(setDeveloperIds.size() >0 && setDeveloperIds != null){
            UpdateClient(setDeveloperIds);
        }
    }
     
    public Static void updatedeveloperlist(List<Developer__c> listDeveloper ,map<Id,Developer__c> clientmap){
        Set<Id> setDeveloperIds = new Set<Id>();
        for(Developer__c pc : listDeveloper) {
            if((pc.Id!= null) && (pc.Developer1__c !=clientmap.get(pc.Id).Developer1__c || pc.Developer2__c !=clientmap.get(pc.Id).Developer2__c ) )
            {
                setDeveloperIds.add(pc.Management__c); 
            }
        }
        if(setDeveloperIds.size() >0 && setDeveloperIds != null){
            UpdateClient(setDeveloperIds);
        }
    }
    
    
    public Static void UpdateClient(Set<Id> setDeveloperIds) {
        if(setDeveloperIds.size() >0 && setDeveloperIds != null ) {
            List<AggregateResult> aggr = [Select Management__c mgId, SUM(Developer1__c)sum1,SUM(Developer2__c) Sum2 from  Developer__c  where Management__c  in :setDeveloperIds group by Management__c]; 
             
            Map<Id,List<Integer>> mapResult1 = new Map<Id,List<Integer>>();
            List<Integer> listofAggregatevalue = new List<Integer>();
            
            Integer sum1;
            Integer sum2;
            if(aggr != null && aggr.size() >0) { 
                for(AggregateResult ag:aggr){
                    sum1 = Integer.valueof(ag.get('sum1')) != null ? Integer.valueof((ag.get('sum1'))) : 0;
                    listofAggregatevalue.add(sum1 );
                    sum2 = Integer.valueof(ag.get('Sum2')) != null ? Integer.valueof((ag.get('Sum2'))) : 0;
                    listofAggregatevalue.add(sum2 );
                    Id str = (Id)ag.get('mgId') != null ?(Id)ag.get('mgId'): new Management__c().Id ;
                    
                    mapResult1.put(Id.valueof(str),listofAggregatevalue);
                }
            }
            
            List <Management__c> ListofManage =[Select Id,  TotalDevelpoer1__c,TotalDeveloper2__c from  Management__c where  Id IN : setDeveloperIds];
           
            if(ListofManage != null && ListofManage.size() > 0){   
                for(Management__c pt : ListofManage){
                     if(mapResult1.containsKey(pt.Id)){
          
                           if(mapResult1.get(pt.Id)!=null) {
                               pt.TotalDevelpoer1__c =mapResult1.get(pt.Id)[0] ; 
                               pt.TotalDeveloper2__c =mapResult1.get(pt.Id)[1]; 
                           }
                           
                     }
                }
               update ListofManage;
            } 
        }
    }
}