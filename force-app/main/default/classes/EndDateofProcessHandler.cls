public with sharing class EndDateofProcessHandler {
	
	public static void endDate(List<TaskCs__c> tslist,map<id,TaskCs__c> tsmap){
		
		set<Id> idset = new Set<Id>();
		
		if(tsmap != null){
			for(String str : tsmap.keyset()){
					 	for(TaskCs__c tc :tsmap.values()){
					 	 idset.add(tc.Process__c);
					 	}
			}
		list<Process__c> porcesslist =[Select Name,Description__c,Start_Date__c,End_Date__c,Status__c,Sequence_Count__c,(Select Name,Start_date__c,End_date__c,Task_Status__c,Assigned_To__c,Sequence__c,Process__c  From TaskCs__r ORDER BY Sequence__c ASC) From Process__c where id =:idset];
			
		for(Process__c pr :porcesslist){
			for(TaskCs__c tc: tslist){
					if(tc.Task_Status__c == 'Completed'){
						
						for(TaskCs__c ts:pr.TaskCs__r ){
							if(ts.Task_Status__c =='Completed' && (ts.Sequence__c == pr.Sequence_Count__c) ){
								pr.End_Date__c =ts.End_date__c;
								pr.Status__c = ts.Task_Status__c;
								update porcesslist;
							}
						}
					}
				}
			}
		}
	}
	
	public static void startStatusofProcess(List<TaskCs__c> tslist,map<id,TaskCs__c> tsmap){
		
		set<Id> idset = new Set<Id>();
		
		if(tsmap != null){
			for(String str : tsmap.keyset()){
					 	for(TaskCs__c tc :tsmap.values()){
					 	 idset.add(tc.Process__c);
					 	}
			}
		list<Process__c> porcesslist =[Select Name,Description__c,Start_Date__c,End_Date__c,Status__c,Sequence_Count__c,(Select Name,Start_date__c,End_date__c,Task_Status__c,Assigned_To__c,Sequence__c,Process__c  From TaskCs__r ORDER BY Sequence__c ASC) From Process__c where id =:idset];
			
		for(Process__c pr :porcesslist){
			
			for(TaskCs__c tc: tslist){
					if(tc.Task_Status__c == 'Started'){
						
						for(TaskCs__c ts:pr.TaskCs__r ){
							if(ts.Task_Status__c =='Started' && (ts.Sequence__c == 1) ){
								//pr.End_Date__c =ts.End_date__c;
								pr.Status__c = ts.Task_Status__c;
								pr.Start_Date__c =  ts.Start_date__c;
								update porcesslist;
							}
						}
					}
			}
		}
		}
	}
		
}