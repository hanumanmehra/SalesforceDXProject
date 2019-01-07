public with sharing class taskController 
{
    public TaskCs__c task{set;get;}
    private  String  TaskId = Apexpages.currentPage().getParameters().get('id');
    public taskController(Apexpages.StandardController sc) 
    {
        try
        {
            if(TaskId == null)
            {
                task = (TaskCs__c)sc.getRecord(); 
                task.Process__c = Apexpages.currentPage().getParameters().get('pid');
            }
            else 
            {
                task = [Select Name,Start_date__c,End_date__c,Task_Status__c,Assigned_To__c,Sequence__c,Process__c,Task_Description__c,Cycle_Time__c From TaskCs__c where Id =:TaskId Limit 1];
                System.debug('task'+task);
            }
        }
        catch(Exception e)
        {   
        }
    }
    
    public PageReference save()
    { 
        try
        {
            upsert task;
            System.debug('upsert task'+task);
            
            PageReference editPage = new PageReference('/apex/Process_detailPage?id='+task.Process__c);
                //editPage.setRedirect(true);
                return editPage;
        }
        catch(Exception de)
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.ERROR,de.getmessage()));
        }   
        return null;
    }
    
    public PageReference cancel()
    {
        PageReference editPage = new PageReference('/apex/Process_detailPage?id='+task.Process__c);
        return editPage;
    }
}