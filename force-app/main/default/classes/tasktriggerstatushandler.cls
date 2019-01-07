public with sharing class tasktriggerstatushandler
 {
	public static void updateTaskWorkingStatus(List<Triggertask__c> tasklist,map<id,Triggertask__c> tskmap)
	{
		
				for(Triggertask__c ts:tasklist) 
				{
					if(ts.Status__c == 'Started'  && tskmap.get(ts.id).Status__c == 'Pending')  
					{
						if(ts.StratDate__c < System.today())
						{
							ts.WorkStatus__c= 'Delay'; 
						}
						else if(ts.StratDate__c >= System.today())
						{	
							ts.WorkStatus__c= 'Ontime'; 
						}
					}	
				}
	}
}