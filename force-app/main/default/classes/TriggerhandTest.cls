@isTest
public with sharing class TriggerhandTest 
{
	public static testMethod void processUnitTest3()
	{
		Process__c	proc = new Process__c();
		proc.Name ='frasrersfrscv';	
		proc.Description__c = 'lslkxkxkkxmkx' ;
		proc.Status__c =  'Complted';
		proc.Start_date__c =Date.Today().adddays(2);
			//proc.End_date__c =Date.Today().adddays(3);
		insert proc;
			
		TaskCs__c task31 = new TaskCs__c();
		task31.Sequence__c = 1;
		task31.Task_Status__c ='Completed';
		task31.Task_Description__c='jdjkkdk';
		task31.Cycle_Time__c = 2.0; 
		task31.Assigned_To__c= UserInfo.getUserId();
		task31.Process__c= proc.Id; 
		task31.Start_date__c = Date.Today().adddays(2);
		task31.End_date__c = Date.Today().adddays(3);
		insert task31;
		/*TaskCs__c task32 = new TaskCs__c();
		task32.Sequence__c = 2;
		task32.Task_Status__c ='Assigned';
		task32.Task_Description__c='hdhhdhddhd';
		task32.Cycle_Time__c = 2.0; 
		task32.Assigned_To__c= UserInfo.getUserId();
		task32.Process__c= proc.Id; 
		insert task32;
		
		TaskCs__c task33 = new TaskCs__c();
		task33.Sequence__c = 3;
		task33.Task_Status__c ='Assigned';
		task33.Task_Description__c='hdhhdhddhd';
		task33.Cycle_Time__c = 2.0; 
		task33.Assigned_To__c= UserInfo.getUserId();
		task33.Process__c= proc.Id; 
		//task31.Start_date__c = Date.Today().adddays(2);
		//task31.End_date__c = Date.Today().adddays(3);
		insert task33;*/
		list<TaskCs__c> tslst = new list<TaskCs__c>();
		tslst.add(task31);
		//tslst.add(task32);
		//tslst.add(task33);
		TaskcsTriggerHandler.updatesequence(tslst);
	}
}