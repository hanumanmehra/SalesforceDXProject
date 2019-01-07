public with sharing class ClientHandler1
{
    //Method for get value of trigger.new or trigger.old
    public Static void newClient(List<Client__c> listClient)
    {
        Set<Id> setClientIds = new Set<Id>();
        
        for(Client__c pc : listClient)
        {
            if(pc.Id!= null)
            {
                setClientIds.add(pc.Management__c);
            }
        } 
        
        if(setClientIds.size() >0 && setClientIds != null )
        {
            UpdateClient(setClientIds);
        } 
    }
     
    //Method for get value of trigger.new or trigger.oldmap
    public Static void updateClientlist(List<Client__c> listclient ,map<Id,Client__c> clientmap)  
    {
        Set<Id> setClientIds = new Set<Id>();
        for(Client__c pc : listclient)
        {
            if(pc.Id!= null && (pc.Client1__c != clientmap.get(pc.Id).Client1__c || pc.Client2__c != clientmap.get(pc.Id).Client2__c  || pc.BudgetOfclient__c!= clientmap.get(pc.Id).BudgetOfclient__c || pc.ExpanseOnClient__c!= clientmap.get(pc.Id).ExpanseOnClient__c))
            {
                setClientIds.add(pc.Management__c); 
            }
        }
        if(setClientIds.size() >0 && setClientIds != null)
        {
            UpdateClient(setClientIds);
        }        
    }
    
    
    public Static void UpdateClient(Set<Id> setClientIds)
    {
        if(setClientIds.size() >0 && setClientIds != null )
        {
            List<AggregateResult> aggr = [Select Management__c mgId,SUM(Client1__c)sum1,SUM(Client2__c) Sum2,SUM(BudgetOfclient__c)budgesum,SUM(ExpanseOnClient__c)expensesum from  Client__c  where Management__c  in :setClientIds group by Management__c];
            System.debug('aggr'+aggr); 
             
            List<Integer> valueofaggregatereult = new List<Integer>();
            Map<String,Integer> mapResult1 = new Map<String,Integer>();
            Map<Id, Map<String,Integer>> mapResult2 = new Map<Id, Map<String,Integer>>();
            
            Integer sum1;
            Integer sum2;
            Integer Budged;
            Integer Expanse;
            
            
            if(aggr != null && aggr.size() >0)
            { 
                for(AggregateResult ag:aggr)
                {
                    sum1 = Integer.valueof(ag.get('sum1')) != null ? Integer.valueof((ag.get('sum1'))) : 0; 
                    mapResult1.put('TotalClient1__c',sum1 );
                    sum2 = Integer.valueof(ag.get('Sum2')) != null ? Integer.valueof((ag.get('Sum2'))) : 0;
                    mapResult1.put('TotalClient2__c',sum2 );
                    Budged= Integer.valueof(ag.get('budgesum')) != null ? Integer.valueof((ag.get('budgesum'))) : 0;
                    mapResult1.put('TotalClientBudget__c' ,sum1 );
                    Expanse= Integer.valueof(ag.get('expensesum')) != null ? Integer.valueof((ag.get('expensesum'))) : 0;
                    mapResult1.put('TotalClientExpense__c',sum1 );
                    Id str = (Id)ag.get('mgId') != null ?(Id)ag.get('mgId'): new Management__c().Id ;
                    mapResult2.put(str,mapResult1); 
                }
            }
            
            
            List <Management__c> ListofManage =[Select Id,TotalClient1__c,TotalClient2__c,TotalClientBudget__c,TotalClientExpense__c from  Management__c where  Id IN : setClientIds];
          
             if(ListofManage != null && ListofManage.size() > 0)
             {
                
                for(Management__c pt : ListofManage)
                {
                     if(mapResult2.get(pt.Id)!=null && mapResult2.containsKey(pt.Id))
                     {
                        pt.TotalClient1__c=(mapResult2.get(pt.Id)).get('TotalClient1__c') ; 
                        pt.TotalClient2__c =(mapResult2.get(pt.Id)).get('TotalClient2__c'); 
                        pt.TotalClientBudget__c =(mapResult2.get(pt.Id)).get('TotalClientBudget__c');
                        pt.TotalClientExpense__c=(mapResult2.get(pt.Id)).get('TotalClientExpense__c');  
                        System.debug('TotalClient1__c::'+pt.TotalClient1__c+'TotalClient2__c :::'+pt.TotalClient2__c +'TotalClientBudget__c ::'+pt.TotalClientBudget__c +'TotalClientExpense__c::'+pt.TotalClientExpense__c);   
                     }
                }
                update ListofManage;
            }
            /* Way by using of describe objects field
             Map<String,Schema.SObjectField> mfields;
            
            //Management__c mgmtobj = new Management__c();
            //Account acc =  new Account();
            sobjecjMap = Schema.getGlobalDescribe();
            String ObjectName;
            for(String keys: sobjecjMap.keySet())
            {
                Schema.DescribeSObjectResult d = sobjecjMap.get(keys).getDescribe();
                if(d.isQueryable()== true )
                {
                //System.debug('ObjectName :::'+d.getName()); 
                if(d.getName() == 'DoctorPatient__Management__c')
                   ObjectName = d.getName();
                }
                System.debug('ObjectName :::'+ObjectName );
            }
            
            if(ObjectName !=null)
            {
                SObjectType objType = sobjecjMap.get(ObjectName);
                mfields = objType.getDescribe().fields.getMap();
                
                System.debug('-----mfields----'+mfields.values()); 
                System.debug('mfields keys----'+mfields.keySet());
            }
            
            for(Management__c  mc : ListofManage)
            {
                for(String keys: mfields.keySet())
                {
                 //mc.keys = 0;
                }
                
            }*/
            
          
            
          /*  if(ListofManage != null && ListofManage.size() > 0)
            {
                for(Management__c pt : ListofManage)
                {
                
                    for(Integer i =1;i<=4;i++)
                    {
                         if(mapResult1.containsKey(pt.Id))
                         {
                             pt.TotalClient1__c = mapResult1.get(pt.Id);
                         }
                         
                        
                         
                         else if(mapResult4.containskey(pt.Id)){
                             pt.TotalClientExpense__c= mapResult4.get(pt.Id);
                             System.debug('pt.TotalClientExpense__c::'+pt.TotalClientExpense__c);
                         }
                         else
                         {
                            pt.TotalClient1__c = 0;
                            pt.TotalClientExpense__c= 0;
                         }
                     }
                } 
            }
            
            if(ListofManage != null && ListofManage.size() > 0)
            {
                for(Management__c pt : ListofManage)
                {
                     if(mapResult2.containsKey(pt.Id))
                     {
                         pt.TotalClient2__c = mapResult2.get(pt.Id);
                     }
                     else
                     {
                        pt.TotalClient2__c = 0;
                     }
                } 
            }
            
             if(ListofManage != null && ListofManage.size() > 0)
            {
                for(Management__c pt : ListofManage)
                {
                      if(mapResult3.containskey(pt.Id)){
                         pt.TotalClientBudget__c = mapResult3.get(pt.Id);
                         System.debug('pt.TotalClientBudget__c::'+pt.TotalClientBudget__c);
                     }
                     else
                     {
                         pt.TotalClientBudget__c = 0;
                     }
                } 
            }
            update ListofManage;
        }*/
        }
    }
}