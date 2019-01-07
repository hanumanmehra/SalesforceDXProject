public with sharing class SobjectCsController 
{
	public Map<String, Schema.SObjectType> sobjecjMap;
	public String selobject{get;set;}
	
	public SobjectCsController()
	{
		
		 AuthoriziedObject__c acc =  new AuthoriziedObject__c();
		 
		List< AuthoriziedObject__c>  allRecords= [Select Object_API_Name__c from AuthoriziedObject__c];
		System.debug('allRecords'+allRecords);
		  //Map<string, AuthoriziedObject__c> allRecords = acc.getAll();
		  //System.debug('allRecords'+allRecords);
		 
		 sobjecjMap = Schema.getGlobalDescribe(); 
		 System.debug('sobjecjMap'+sobjecjMap);
		 
		 for(String keys: sobjecjMap.keySet())
        {
        	if(String.valueof(allRecords[0].Object_API_Name__c) == String.valueof(sobjecjMap.get(keys)))
        	{
            	Schema.DescribeSObjectResult dsobj = sobjecjMap.get(keys).getDescribe();
            	if(dsobj.isQueryable()== true)
            	{
        			System.debug('dsobj'+dsobj);
            	}
        	}
        }
	}
	
	 public String getselectobject()
    {
        return selobject;
    }
    
    public  void setselectobject( String selobject)  
    {
        this.selobject = selobject;
    }
    
    //get method for list SelectOptions of Sobject
    public List<SelectOption> getItems() 
    { 
        List<SelectOption> selectlist = new List<SelectOption>();
        for(String keys: sobjecjMap.keySet())
        {
            Schema.DescribeSObjectResult d = sobjecjMap.get(keys).getDescribe();
            if(d.isQueryable()== true)
            {
        		selectlist.add(new SelectOption(d.getName(),d.getlabel()));
            }
        }
        
        selectlist.sort();
        System.debug('selectlist'+selectlist);
        return selectlist;  
    }
}