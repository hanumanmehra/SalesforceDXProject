trigger Update_Patient on Patient__c ( after update) 
{	
	 if(Trigger.isAfter && Trigger.isUpdate)
	 {
		 DoctorHandler.patientlist(Trigger.New,Trigger.oldMap); 
	 }  
}