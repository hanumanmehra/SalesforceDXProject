@isTest
public class TaskTestClass 
{
	public static testMethod void taskUnitTest()
	{
		
		Process__c	proce = new Process__c();
			proce.Name ='hsjasjss';	
			proce.Description__c = 'jjdjcjjdcncjjc' ;
			proce.Status__c =  'Started';
			proce.Start_date__c =Date.Today();
			insert proce;
		TaskCs__c tsobj = new TaskCs__c();
		tsobj.Sequence__c = 1;
		//tsobj.Task_Status__c ='Completed';
		tsobj.Task_Description__c='jjdiddjkdjk';
		tsobj.Cycle_Time__c = 2.0; 
		tsobj.Assigned_To__c= UserInfo.getUserId();
		tsobj.Process__c= proce.Id;
		tsobj.Start_date__c = Date.Today();
		//tsobj.End_date__c = Date.Today().adddays(3);
		insert tsobj;
		//tsobj.Id='';
		//update tsobj;
		ApexPages.StandardController asp = new ApexPages.StandardController(tsobj);
		taskController tskcon = new taskController(asp);
		Apexpages.currentPage().getparameters().put('Id',+proce.id);
		tskcon.save();
	}
	public static testMethod void taskUnitTest2()
	{
		
		Process__c	proce2 = new Process__c();
			proce2.Name ='hsjasjss';	
			proce2.Description__c = 'jjdjcjjdcncjjc' ;
			proce2.Status__c =  'Assigned';
			//proce2.Start_date__c =Date.Today();
			insert proce2;
		TaskCs__c tsobj2 = new TaskCs__c();
		//tsobj2.Sequence__c = 1;
		tsobj2.Task_Status__c ='Assigned';
		tsobj2.Task_Description__c='jdkkdxkmxkdxmsdm';
		tsobj2.Cycle_Time__c = 2.0; 
		tsobj2.Assigned_To__c= UserInfo.getUserId();
		tsobj2.Process__c= proce2.Id;
		insert tsobj2;
		Apexpages.currentPage().getparameters().put('Id',+proce2.Id);
		ApexPages.StandardController asp1 = new ApexPages.StandardController(tsobj2);
		taskController tskcon2 = new taskController(asp1);
		tskcon2.task = (TaskCs__c)asp1.getRecord();	
	}
	public static testMethod void taskUnitTest3()
	{
		list<TaskCs__c> lst3 = new list<TaskCs__c>();
		
		Process__c	proce3 = new Process__c();
			proce3.Name ='hsjasjss';	
			proce3.Description__c = 'jjdjcjjdcncjjc' ;
			proce3.Status__c =  'Started';
			//proce2.Start_date__c =Date.Today();
			insert proce3;
		TaskCs__c tsobj31 = new TaskCs__c();
		tsobj31.Sequence__c = 1;
		tsobj31.Task_Status__c ='Completed';
		tsobj31.Task_Description__c='hdhhdhdh';
		tsobj31.Cycle_Time__c = 2.0; 
		tsobj31.Assigned_To__c= UserInfo.getUserId();
		tsobj31.Start_date__c = Date.Today();
		tsobj31.End_date__c = Date.Today();
		tsobj31.Process__c= proce3.Id;
		//insert tsobj31;
		lst3.add(tsobj31);
		
		TaskCs__c tsobj32 = new TaskCs__c();
		tsobj32.Sequence__c = 2;
		tsobj32.Task_Status__c ='Assigned';
		tsobj32.Task_Description__c='hhdhdhdbxbsbsbsb';
		tsobj32.Cycle_Time__c = 2.0; 
		tsobj32.Assigned_To__c= UserInfo.getUserId();
		tsobj32.Process__c= proce3.Id;
		lst3.add(tsobj32);
		insert lst3;
		try{
		tsobj32.Task_Status__c ='Started';
		tsobj32.Start_date__c = Date.Today();
		update lst3;
		}
		catch(Exception e)
		{
			
		}
	}
	
	public static testMethod void taskUnitTest4()
	{	
		Process__c	proce4 = new Process__c();
			proce4.Name ='hsjasjss';	
			proce4.Description__c = 'jjdjcjjdcncjjc' ;
			proce4.Status__c =  'Started';
			proce4.Start_date__c =Date.Today();
			insert proce4;
		TaskCs__c tsobj4 = new TaskCs__c();
		//tsobj2.Sequence__c = 1;
		tsobj4.Task_Status__c ='Started';
		tsobj4.Task_Description__c='jdjkdkdkdxcm';
		tsobj4.Cycle_Time__c = 2.0; 
		tsobj4.Assigned_To__c= UserInfo.getUserId();
		tsobj4.Process__c= proce4.Id;
		tsobj4.Start_date__c = Date.Today();
		
		
		List<TaskCs__c>  lst =  new List<TaskCs__c> ();
		try
		{
			lst.add(tsobj4);
			insert lst;
			Statusupdatehandler.deltrigger(lst);
		}
		catch(Exception e)
		{
			
		}
	}

}