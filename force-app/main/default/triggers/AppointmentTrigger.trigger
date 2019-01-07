trigger AppointmentTrigger on Appointment__c (after delete, after insert, after undelete, after update,before insert) 
{
    if(Trigger.isAfter)
    {
        if(Trigger.isInsert || Trigger.isUnDelete)
        {
            PatientDoctorHandler.updatedoctorpatient(Trigger.New);
            DoctorHandler.updatedoctorlist(Trigger.New);
        }
        else if(Trigger.isUpdate)
        {
            PatientDoctorHandler.updateofaftertrigger(Trigger.New,Trigger.oldMap);
            DoctorHandler.updateopatientfieldmap(Trigger.New,Trigger.oldMap);
        }
        else if(Trigger.isDelete)
        {
            PatientDoctorHandler.updatedoctorpatient(Trigger.old);
            DoctorHandler.updatedoctorlist(Trigger.old);
        }
    }
    
     List<Appointment__c> listAppointment = Trigger.isDelete ? Trigger.Old : Trigger.New;
     
     If(Trigger.isUpdate || Trigger.isDelete || Trigger.isUndelete)
     {
        PatientDoctorHandler.updatedoctorpatient(listAppointment);
        
     }
     
     If(Trigger.Isbefore && Trigger.IsInsert)
     {
        PatientDoctorHandler.updateAppoinmentDateTime(Trigger.new); 
     }
}