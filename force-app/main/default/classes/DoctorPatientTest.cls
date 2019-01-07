//@isTest
public with sharing class DoctorPatientTest 
{
    /*public static testMethod void doctortest() 
    {
        list<Doctor__c> listdioc =  new list<Doctor__c>();
        
        Doctor__c dcobj =  new Doctor__c();
        dcobj.Name ='Manoj Jain';
        dcobj.Spaciality__c = 'Skin';
        dcobj.Total_Patient__c = null;
        listdioc.add(dcobj);
        
        Doctor__c dcobj1 =  new Doctor__c();
        dcobj1.Name ='Saurav garg';
        dcobj1.Spaciality__c = 'Heart';
        dcobj1.Total_Patient__c = null;
        listdioc.add(dcobj1);
        
        insert listdioc;
        
        list<Patient__c> listpatient =  new list<Patient__c>();
        
        Patient__c ptobj =  new Patient__c();
        ptobj.Name ='lokesh';
        ptobj.Diseses__c = 'Skin,Surgery,';
        ptobj.Sex__c     = 'M';
        listpatient.add(ptobj);
        
        Patient__c ptobj1 =  new Patient__c();
        ptobj1.Name ='mahesh';
        ptobj1.Diseses__c = 'Heart,neurology';
        ptobj1.Sex__c = 'M';
        listpatient.add(ptobj1);
        insert listpatient;
        System.assertNotEquals(null,listpatient);
        
        
        List<Appointment__c> listapp = new List<Appointment__c>();
        
        Appointment__c accobj = new  Appointment__c();
        accobj.Patient__c = ptobj.Id;
        accobj.Doctor__c = dcobj.Id;
        accobj.Appointment_date__c = System.today();
        //accobj.Name ='A-001';
        listapp.add(accobj);
        
        Appointment__c accobj1 = new  Appointment__c();
        accobj1.Patient__c =ptobj1.Id;
        accobj1.Doctor__c = dcobj.Id;
        accobj1.Appointment_date__c = System.today();
        //accobj1.Name ='A-002';
        listapp.add(accobj1);
        
        insert listapp;
        System.assertNotEquals(null,listapp);
        
        accobj1.Patient__c =ptobj1.Id;
        accobj1.Doctor__c = dcobj1.Id;
        update listapp; 
        
        System.assertNotEquals(null,listapp);
        
        dcobj.Total_Patient__c = 5;
        dcobj1.Total_Patient__c = 8;
        update listdioc;
        System.assertNotEquals(null,listdioc);
        
        ptobj.No_Of_Doctor__c = 10;
        ptobj1.No_Of_Doctor__c = 7;
        update listpatient;
        System.assertNotEquals(null,listpatient);
    } */  

}