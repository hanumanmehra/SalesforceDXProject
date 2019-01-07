trigger TriggerOnTask on Triggertask__c (before update) 
{
	if(Trigger.isbefore)
	{
		if(Trigger.isUpdate)
		{
			tasktriggerstatushandler.updateTaskWorkingStatus(Trigger.new,Trigger.oldMap);  
		}
	}

}