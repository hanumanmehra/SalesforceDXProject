public with sharing class ProcessStatusHandler 
{
	public static void StatusAssigned(List <Process__c> processlist)
	{
		for(Process__c sta : processlist)
		{
			sta.Status__c = 'Released';	
		}
	}
}