trigger DoctorTriggger on Doctor__c (after update) 
{
	if(Trigger.isAfter && Trigger.isUpdate)
 	{
 		PatientDoctorHandler.Doctorlist(Trigger.New,Trigger.oldMap); 
 	}  
}