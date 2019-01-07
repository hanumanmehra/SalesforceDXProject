public with sharing class DoctorHandler 
{
	public Static void updatedoctorlist(List<Appointment__c> listAppointment)
    {
    	Set<Id> setPatientIds = new Set<Id>();
    	
	 	for(Appointment__c pc : listAppointment)
	 	{
 			if(pc.Id!= null)
		 	{
 				setPatientIds.add(pc.Patient__c);
		 	}
	 	} 
		if(setPatientIds.size() > 0)  
	 	Updatepatient(setPatientIds); 
    }
    
    
	public static void updateopatientfieldmap(List<Appointment__c> listAppointment,Map<Id,Appointment__c> mapold)
    {
		Set<Id> setPatientIds = new Set<Id>();
	 	for(Appointment__c pc : listAppointment)
	 	{
 			if(pc.Id!= null ||(pc.Patient__c != mapold.get(pc.Id).Patient__c))
		 	{
	 			setPatientIds.add(pc.Patient__c);
	 			
				if(pc.Patient__c != mapold.get(pc.Id).Patient__c)
	 			{
	            	setPatientIds.add(mapold.get(pc.Id).Patient__c);
				}   
		 	}
		 }	
		 
	  	if(setPatientIds.size() >0)
	  	Updatepatient(setPatientIds);
	}
	
	public Static void patientlist(List<Patient__c> listpatient ,map<Id,Patient__c> patientmap)
	{
		Set<Id> setPatientIds = new Set<Id>();
		for(Patient__c pc : listpatient)
			 {
			 	if((pc.No_Of_Doctor__c != patientmap.get(pc.Id).No_Of_Doctor__c))
			 	{
			 		setpatientIds.add(pc.Id);
			 	}
			 }
			 if(setpatientIds.size() >0)
			 {
			 	Updatepatient(setpatientIds);
			 }
	
	}
	public Static void Updatepatient(Set<Id> setPatientIds)
	{
		if(setPatientIds.size() >0 && setPatientIds != null )
		{
			List<AggregateResult> aggr = [Select Patient__c ptId,COUNT(Doctor__c) totdoc from Appointment__c where Patient__c  in :setPatientIds  group by Patient__c];
			 
			//System.debug('aggr'+aggr);
			Map<Id,Integer> mapResult = new Map<Id,Integer>();
	 	 	Integer totdoc;
		 	if(aggr != null && aggr.size() >0)
		 	{ 
		 	 	for(AggregateResult ag:aggr)
		 	 	{
		 	 		totdoc = (Integer)ag.get('totdoc') != null ? (Integer)(ag.get('totdoc')) : 0; 
			 	 	Id str = (Id)ag.get('ptId') != null ?(Id)ag.get('ptId'): new Patient__c().Id ;
			 	 	mapResult.put(Id.valueof(str),totdoc);
			 	 	//System.debug(mapResult);
		 	 	}
		 	}
	 	 	
	 	 	
			List <Patient__c> ListofPatient =[Select Id,Name,No_Of_Doctor__c from  Patient__c where  Id IN : setPatientIds];
			//System.debug('ListofPatient'+ListofPatient);
			
			if(ListofPatient != null && ListofPatient.size() > 0)
			{
				for(Patient__c pt : ListofPatient)
			 	{
			 		 if(mapResult.containsKey(pt.Id))
			 		 {
						 pt.No_Of_Doctor__c = mapResult.get(pt.Id);
						 System.debug( pt.No_Of_Doctor__c);
					 }
					 else
					 {
		             	pt.No_Of_Doctor__c = 0;
		             }
			 	}
			 	update ListofPatient;
				//System.debug('ListofPatient'+ListofPatient); 
			}
		}
	}
		
	}