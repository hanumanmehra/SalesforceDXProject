trigger processTrigger on Process__c (before insert) 
{
	if(Trigger.isBefore)
	{
		if(Trigger.isInsert)
		{
			ProcessStatusHandler.StatusAssigned(Trigger.new);
		}
	}
	
}