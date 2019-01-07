public with sharing class PatientDoctorHandler
 {
    
    public Static void updatedoctorpatient(List<Appointment__c> listAppointment)
    {
        Set<Id> setDoctorIds = new Set<Id>(); 
        for(Appointment__c pc : listAppointment)
        {
            if(pc.Id!= null)
            {
                setDoctorIds.add(pc.Doctor__c);
            }
        } 
        if(setDoctorIds.size() > 0)  
        countTotalPatient(setDoctorIds); 
    }
    
    
    public static void updateofaftertrigger(List<Appointment__c> listAppointment,Map<Id,Appointment__c> mapold)
    {
        Set<Id> setDoctorIds = new Set<Id>();
        for(Appointment__c pc : listAppointment)
        {
            if(pc.Id!= null ||(pc.Doctor__c != mapold.get(pc.Id).Doctor__c || pc.Patient__c != mapold.get(pc.Id).Patient__c))
            {
                setDoctorIds.add(pc.Doctor__c);
                
                if(pc.Doctor__c != mapold.get(pc.Id).Doctor__c)
                {
                    setDoctorIds.add(mapold.get(pc.Id).Doctor__c);
                }
                
            }
         }  
         
        if(setDoctorIds.size() >0)
        countTotalPatient(setDoctorIds);
    }
    
    public Static void Doctorlist(List<Doctor__c> listDoctor,map<Id,Doctor__c> mapdoctor)
    {
        Set<Id> setDoctorIds = new Set<Id>();
        for(Doctor__c pc : listDoctor)
        {
            if((pc.Total_Patient__c != mapdoctor.get(pc.Id).Total_Patient__c))
            {
                setDoctorIds.add(pc.Id);
            }
        }
        if(setDoctorIds.size() >0)
        {
            countTotalPatient(setDoctorIds);
        }
    }
    
    public  static void countTotalPatient(Set<Id> setDoctorIds)
    {
        if(setDoctorIds.size() >0)
        {
            List<AggregateResult> aggr1 = [Select Doctor__c dtId,COUNT(Patient__c) totpar from Appointment__c where Doctor__c  in :setDoctorIds  group by Doctor__c];
             
            Map<Id,Integer> mapResult = new Map<Id,Integer>();
            
            if(aggr1.size() >0 && aggr1 != null)
            {   
                for(AggregateResult ag:aggr1)
                {
                    Integer totpar = (Integer)ag.get('totpar') != null ? (Integer)ag.get('totpar') : 0; 
                    Id str = (Id)ag.get('dtId') != null ?(Id)ag.get('dtId'): new Doctor__c().Id ; 
                    mapResult.put(str,totpar);
                    //System.debug(mapResult);
                }
            }
            
            
            List <Doctor__c> ListofDoctor =[Select Id,Name,Total_Patient__c from  Doctor__c where  Id IN : setDoctorIds];
            
            if(ListofDoctor.size() >0 || ListofDoctor != null)
            {
                for(Doctor__c dc : ListofDoctor)
                {
                     if(mapResult.containsKey(dc.Id))
                     {
                         dc.Total_Patient__c = mapResult.get(dc.Id);
                     }
                     else
                     {
                        dc.Total_Patient__c = 0;
                     }
                }
                update ListofDoctor;
            } 
        }
    }
    
    public Static void updateAppoinmentDateTime(List<Appointment__c> listappointment)
    {
        Set<Id> setdoctorsId =  new Set<Id>();
        Set<Date> AppointDateSet= new Set<Date>();
        
        for(Appointment__c ac :listappointment)
        {
            setdoctorsId.add(ac.Doctor__c);
            AppointDateSet.add(ac.Appointment_date__c); 
            System.debug('ac.Appointment_date__c'+ac.Appointment_date__c+'setdoctorsId'+setdoctorsId);
        }
            
        list<Appointment__c> appointlist =  [Select Id,Name,Appointment_date__c,AppiontmentTime__c,Doctor__c from Appointment__c where Doctor__c IN :setdoctorsId order by Appointment_date__c,AppiontmentTime__c Asc];
        System.debug('appointlist::'+appointlist);
        
        if(appointlist.size() >0)
        {			
        	Map <Id,Appointment__c> appointMap =  new Map <Id,Appointment__c>();
        	
        	for(Appointment__c acc : appointlist)
        	{
    			appointMap.put(acc.Doctor__c,acc);
        	}
        	
        	List<Appointment__c> listapp =  new List<Appointment__c> ();
        	
        	for( Id iddoc :setdoctorsId)
        	{
    			listapp.add(appointMap.get(iddoc));
        	}
        	
    		System.debug(listapp);
        	Date previousAppointDate = listapp[listapp.size()-1].Appointment_date__c;
        	String Timeofapp = String.valueof(listapp[listapp.size()-1].AppiontmentTime__c);
        	System.debug('previousAppointDate'+previousAppointDate +'Timeofapp' +Timeofapp);
        	
        	Time myTime = Time.newInstance(9, 00, 0, 00);
           
	        if(Timeofapp !=null)
	        {
	        	if(Timeofapp.endswith('Z'))
	        	{
	        		Timeofapp = Timeofapp.subString(0,Timeofapp.length()-1);
	        	}
	        	
	        	Timeofapp = Timeofapp.replace('.',':');
	        	System.debug('Timeofapp'+Timeofapp.replace('.',':'));
    			List<String> prevtimelist = Timeofapp.split(':'); 
    			system.debug('prevtimelist'+prevtimelist); 
    		
			 	if(AppointDateSet.contains(previousAppointDate))  
	    		{ 
	    			if(prevtimelist.size() > =3)
	    			{
	    				Time prevTime = Time.newInstance(Integer.valueof(prevtimelist[0]),Integer.valueof(prevtimelist[1]),Integer.valueof(prevtimelist[2]),Integer.valueof(prevtimelist[3]));
	    				//if(prevtimelist[0]!='4' &&  prevtimelist[1] != '30')
	    				System.debug('prevTime:::'+prevTime);
	    				myTime = prevTime.addMinutes(30); 
	    				System.debug('myTime11:::'+myTime);
	    			} 
			 		System.debug('myTime:::'+myTime);
	    		}
	        } 
	        else
		 	{
		 		myTime = Time.newInstance(9, 00, 0, 00);
		 	}
		 	
        	String str = String.valueof(myTime);
        	System.debug('str'+str);
        	
        	for(Appointment__c ac :listappointment)
        	{
            	ac.AppiontmentTime__c = str;
        	}	 
        }
    }

}