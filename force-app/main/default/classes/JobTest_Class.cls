//public with sharing class JobTest_Class {
@isTest
public class JobTest_Class {
	public static testMethod void jobUnitTest() {
		Test.startTest();
		
		Job__c job_obj= new Job__c(Name ='Software developer',Qualification__c ='btech,mtech',Spoken_Language__c ='english,hindi',Technical_Language__c ='java,Apex',Experience__c =  '3');
		
		insert job_obj;
		Id jobId = job_obj.Id;
		
		Job_Application__c japp_obj  = new Job_Application__c();
		japp_obj.Job__c =job_obj.Id ;
		japp_obj.Name = 'sanjay';
		japp_obj.Qualification__c = 'mtech';
		japp_obj.Spoken_Language__c = 'english';
		japp_obj.Technical_Language__c = 'java';
		japp_obj.Experience__c = '2';
		japp_obj.Qualification__c = 'bca';
		insert japp_obj;
		List<Job_Application__c> listjob = new List<Job_Application__c> ();
		listjob.add(japp_obj);
           japp_obj.Spoken_Language__c = 'hindi';
           japp_obj.Experience__c = '3';
		   japp_obj.Qualification__c = '';
		JobAppController cont_obj = new JobAppController(new ApexPages.StandardController(job_obj));
           job_obj.Spoken_Language__c = 'hindi';
           japp_obj.Spoken_Language__c = 'hindi';
           japp_obj.Experience__c = '3';
		   japp_obj.Qualification__c = '';
           cont_obj.jobExperience = '3';
          japp_obj.Qualification__c = 'btech';
          japp_obj.Experience__c  = '3';
          cont_obj.expNum = 3;
		
		Test.stopTest();
	}
	
	public static testMethod void jobUnitTest1() {
		Test.startTest();
		
		Job__c job_obj1= new Job__c(Name ='Software developer',Qualification__c ='btech',Spoken_Language__c ='english',Technical_Language__c ='java,c',Experience__c =  '1');
		insert job_obj1;
		
		Job_Application__c japp_obj1  = new Job_Application__c();
		japp_obj1.Job__c =job_obj1.Id ;
		japp_obj1.Name = 'hanuman';
		japp_obj1.Qualification__c = 'mca';
		japp_obj1.Spoken_Language__c = 'english';
		japp_obj1.Technical_Language__c = 'java';
		japp_obj1.Experience__c = '1';
		insert japp_obj1;
		
	
		JobAppController cont_obj1 = new JobAppController(new ApexPages.StandardController(job_obj1));
		Test.stopTest();
	}
	
	public static testMethod void jobUnitTest2() {
		Test.startTest();
		
		Job__c job_obj2= new Job__c(Name ='Software developer',Qualification__c ='btech,mca',Spoken_Language__c ='english',Technical_Language__c ='java,c',Experience__c =  '2');
		insert job_obj2;
		
		Job_Application__c japp_obj2  = new Job_Application__c();
		japp_obj2.Job__c =job_obj2.Id ;
		japp_obj2.Name = 'hanuman';
		japp_obj2.Qualification__c = '';
		japp_obj2.Spoken_Language__c = '';
		japp_obj2.Technical_Language__c = '';
		japp_obj2.Experience__c = '4';
		insert japp_obj2;
		
		JobAppController cont_obj2 = new JobAppController(new ApexPages.StandardController(job_obj2));
		Test.stopTest();
	}
	public static testMethod void jobUnitTest3() {
		Test.startTest();
		
		Job__c job_obj3 = new Job__c(Name ='Software developer',Qualification__c ='btech,mca',Spoken_Language__c ='english',Technical_Language__c ='java,c',Experience__c =  '2');
		insert job_obj3;
		
		Job_Application__c japp_obj3  = new Job_Application__c();
		japp_obj3.Job__c =job_obj3.Id ;
		japp_obj3.Name = 'hanuman';
		japp_obj3.Qualification__c = 'btech,mca';
		japp_obj3.Spoken_Language__c = 'english';
		japp_obj3.Technical_Language__c = 'java,c';
		japp_obj3.Experience__c = '';
		insert japp_obj3;
		
		JobAppController cont_obj3 = new JobAppController(new ApexPages.StandardController(job_obj3));
		Test.stopTest();
	}
}