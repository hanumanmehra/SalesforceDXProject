@isTest
public  class ProcessTestClass 
{
	public static testMethod void processUnitTest()
	{
		
		Process__c	proce = new Process__c();
			proce.Name ='hanauuan';	
			proce.Description__c = 'jjdjcjjdcncjjc' ;
			proce.Status__c =  'Started';
			proce.Start_date__c =Date.Today();
			insert proce;
		list<TaskCs__c>	 testlist= new list<TaskCs__c>();
			
		TaskCs__c task = new TaskCs__c();
		task.Sequence__c = 1;
		task.Task_Status__c ='Completed';
		task.Task_Description__c='jjdiddjkdjk';
		task.Cycle_Time__c = 2.0; 
		task.Assigned_To__c= UserInfo.getUserId();
		task.Process__c= proce.Id;
		task.Start_date__c = Date.Today();
		task.End_date__c = Date.Today().adddays(3);
		testlist.add(task);
		
		TaskCs__c task1 = new TaskCs__c();
		task1.Sequence__c = 2;
		task1.Task_Status__c ='Started';
		task1.Task_Description__c='jjdiddjkdjk';
		task1.Cycle_Time__c = 2.0; 
		task1.Assigned_To__c= UserInfo.getUserId();
		task1.Process__c= proce.Id;
		task1.Start_date__c = Date.Today().adddays(3);
		//task1.End_date__c = Date.Today().adddays(3);
		testlist.add(task1);
		
		TaskCs__c task2 = new TaskCs__c();
		task2.Sequence__c = 3;
		task2.Task_Status__c ='Assigned';
		task2.Task_Description__c='jjdiddjkdjk';
		task2.Cycle_Time__c = 2.0; 
		task2.Assigned_To__c= UserInfo.getUserId();
		task2.Process__c= proce.Id;
		//task1.Start_date__c = Date.Today().adddays(3);
		//task1.End_date__c = Date.Today().adddays(3);
		testlist.add(task2);
		
		
		
		TaskCs__c task3 = new TaskCs__c();
		task3.Sequence__c = 4;
		task3.Task_Status__c ='Assigned';
		task3.Task_Description__c='jjdiddjkdjk';
		task3.Cycle_Time__c = 2.0; 
		task3.Assigned_To__c= UserInfo.getUserId();
		task3.Process__c= proce.Id;
		testlist.add(task3);
		try
		{
			proce.Description__c ='jdksassnnxnnx';
			update proce;
			insert testlist;
			task2.Task_Description__c='ggg';
			update testlist;
		}
		catch(Exception e1)
		{	
		}
		
			
		Apexpages.currentPage().getparameters().put('Id',+proce.id);	
		ApexPages.StandardController asp = new ApexPages.StandardController(proce);
		ProcessController cont_obj = new ProcessController(asp); 
		cont_obj.name='Sayar' ;
		cont_obj.Description='jsjjdjdjxjxnsmm';
		cont_obj.task  = New TaskCs__c();
		cont_obj.selectid= task3.Id; 
		cont_obj.sortField ='2';
			cont_obj.sortFieldup=2.0; 
			cont_obj.edit();
			cont_obj.listmehtod();
			cont_obj.newtask();
			cont_obj.toggleSort();
			cont_obj.toggleSortup();
	}
	
	public static testMethod void processUnitTest2()
	{
		list<TaskCs__c>	 testlist1= new list<TaskCs__c>();
		Process__c	proce2 = new Process__c();
			proce2.Name ='hanauuan';	
			proce2.Description__c = 'jjdjcjjdcncjjc' ;
			proce2.Status__c =  'Started';
			proce2.Start_date__c =Date.Today().adddays(2);
			insert proce2;
		
		List<TaskCs__c>	lst3 = new List<TaskCs__c>();
		TaskCs__c task21 = new TaskCs__c();
		task21.Sequence__c = 1;
		task21.Task_Status__c ='Started';
		task21.Task_Description__c='jdjkkdk';
		task21.Cycle_Time__c = 2.0; 
		task21.Assigned_To__c= UserInfo.getUserId();
		task21.Process__c= proce2.Id;
		task21.Start_date__c = Date.Today().adddays(2);
		testlist1.add(task21);
		
		
		
		TaskCs__c task22 = new TaskCs__c();
		task22.Sequence__c = 2;
		task22.Task_Status__c ='Assigned';
		task22.Task_Description__c='jdjkkdk';
		task22.Cycle_Time__c = 2.0; 
		task22.Assigned_To__c= UserInfo.getUserId();
		task22.Process__c= proce2.Id;
		testlist1.add(task22);
		insert testlist1;
		try
		{
			task21.Task_Status__c ='Completed';
			task21.End_date__c = Date.Today().adddays(3);
			update task21;	
		    task22.Task_Status__c ='Completed';
		  
		   update testlist1;
		}
		catch(Exception de)
		{	
		}
		
		
			Apexpages.currentPage().getparameters().put('Id',+proce2.id);
			 ApexPages.StandardController asp = new ApexPages.StandardController(proce2);
		ProcessController cont_obj2 = new ProcessController(asp);  
			//cont_obj2.edit();
	}
	
	public static testMethod void processUnitTest3()
	{
		
		Process__c	proce3 = new Process__c();
			proce3.Name ='frasrersfrscv';	
			proce3.Description__c = 'lslkxkxkkxmkx' ;
			proce3.Status__c =  'Started';
			proce3.Start_date__c =Date.Today().adddays(2);
			
			insert proce3;
			
		TaskCs__c task31 = new TaskCs__c();
		task31.Sequence__c = 1;
		task31.Task_Status__c ='Completed';
		task31.Task_Description__c='jdjkkdk';
		task31.Cycle_Time__c = 2.0; 
		task31.Assigned_To__c= UserInfo.getUserId();
		task31.Process__c= proce3.Id;
		task31.Start_date__c = Date.Today().adddays(2);
		task31.End_date__c = Date.Today().adddays(3);
		insert task31;
		
		TaskCs__c task32 = new TaskCs__c();
		task32.Sequence__c = 2;
		task32.Task_Status__c ='Started';
		task32.Task_Description__c='jdjkkdk';
		task32.Cycle_Time__c = 2.0; 
		task32.Assigned_To__c= UserInfo.getUserId();
		task32.Process__c= proce3.Id;
		task32.Start_date__c = Date.Today().adddays(4);
		//task32.End_date__c = Date.Today().adddays(5);
		insert task32;
		try
		{
			task32.Task_Status__c ='Completed';
			task32.End_date__c = Date.Today().adddays(5);
			update task32;
			proce3.Status__c =  'Completed';
			proce3.End_date__c =task32.End_date__c;
			update proce3;
		}
		catch(Exception de)
		{
			
		}
		
		list<TaskCs__c> tskkk = new list<TaskCs__c>();
		 tskkk.add(task31);
		 tskkk.add(task32);
		 
		  EmailHandler.sendTriggerEmail(tskkk ,null);
		  //EndDateofProcessHandler.endDate(tskkk,null);
			Apexpages.currentPage().getparameters().put('Id',+proce3.id);
			 ApexPages.StandardController asp = new ApexPages.StandardController(proce3);
		ProcessController cont_obj3 = new ProcessController(asp); 
	}
	
	public static testMethod void processUnitTest4()
	{
		
		Process__c	proce4 = new Process__c();
			proce4.Name ='frasrersfrscv';	
			proce4.Description__c = 'lslkxkxkkxmkx' ;
			proce4.Status__c =  'Assigned';
			insert proce4;
			
		TaskCs__c task41 = new TaskCs__c();
		task41.Sequence__c = 1;
		task41.Task_Status__c ='Assigned';
		task41.Task_Description__c='jdjkkdk';
		task41.Cycle_Time__c = 2.0; 
		task41.Assigned_To__c= UserInfo.getUserId();
		task41.Process__c= proce4.Id;
		insert task41;
		
		TaskCs__c task42 = new TaskCs__c();
		task42.Sequence__c = 2;
		task42.Task_Status__c ='Assigned';
		task42.Task_Description__c='jdjkkdk';
		task42.Cycle_Time__c = 2.0; 
		task42.Assigned_To__c= UserInfo.getUserId();
		task42.Process__c= proce4.Id;
		insert task42;
		try
		{
		task41.Task_Status__c= 'Started';
		update task41;
		task41.Task_Status__c= 'Assigned';
		update task41;
		}
		catch(Exception de)
		{	
		}
		  
			Apexpages.currentPage().getparameters().put('Id',+proce4.id);
			 ApexPages.StandardController asp = new ApexPages.StandardController(proce4);
		ProcessController cont_obj4 = new ProcessController(asp); 
		
	}
	
}