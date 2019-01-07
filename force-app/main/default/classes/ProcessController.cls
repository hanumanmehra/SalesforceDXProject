public with sharing class ProcessController  
{   
    public Process__c process{get;set;} 
    public TaskCs__c task;
    String ac= Apexpages.currentPage().getparameters().get('Id'); 
    public String selectid{get;set;}
    public ApexPages.StandardController setcon{get;set;}
    public String sortField{get;set;}
    public Decimal sortFieldup{get;set;}
    public Date startDate;
    public date endDate;
    public Integer diffDate;
    public List<String> listofdate {get;set;} 
    public Set<String> assignedUserSet; 
    public List<TaskCs__c> listTaskProcess{get;set;}
    public map<id,Map<Date,TaskWrapper>> mapoflst{get;set;}
    public map<id,String> mapofassign{get;set;}
    
    //constructor
    public ProcessController(ApexPages.StandardController setcon)
    {     
        this.setcon = setcon;
        String ProcessId = setcon.getId();                 
        listTaskProcess = new List<TaskCs__c>();   
        process = new Process__c();       
        listofdate = new List<String>(); 
        listmehtod();
        
        if(ac != null || ac != '')
        {
            //System.debug('listprocessac'+ac);
            /*if(process != null)
            {
               // process = listprocess[0];
                //System.debug('process '+listprocess[0]);
            }  */ 
        }       
        assignedUserSet = new Set<String>();
        for(TaskCs__c  ts1 :process.TaskCs__r)
        {  
            assignedUserSet.add(ts1.Assigned_To__c);
        }
        listTaskProcess =[Select Name,Start_date__c,End_date__c,Task_Status__c,Assigned_To__c,Sequence__c,Process__c,Cycle_Time__c,Task_Description__c,Assigned_To__r.name From TaskCs__c  where Assigned_To__c IN:assignedUserSet and Process__c=:ProcessId ORDER BY Sequence__c ASC];
        dateofprocesstask();
        //seprate task according date and User
        mapofassign= new map<id,string>();
        Date startdat= date.Today();
        Date takStartDate;
        Date takEndDate;
        mapoflst = new map<id,Map<Date,TaskWrapper>>();
        for(TaskCs__c tsk : listTaskProcess)
        {   
            mapofassign.put(tsk.Assigned_To__c ,tsk.Assigned_To__r.name);
            System.debug('mapofassign'+mapofassign);
            if(tsk.Sequence__c == 1)
            {
                startdat= tsk.Start_date__c; 
            }
            if(tsk.Start_date__c != null && tsk.End_date__c != null )
            {   
                takStartDate = tsk.Start_date__c;
                takEndDate = tsk.End_date__c;
            }
            else if(tsk.Start_date__c != null && tsk.End_date__c == null)
            {
                if(tsk.Start_date__c + Integer.valueOf(tsk.Cycle_Time__c) < date.today())
                { 
                    takStartDate = tsk.Start_date__c;
                    takEndDate = date.today();
                }
                else
                {   
                    takStartDate = tsk.Start_date__c;
                    takEndDate = tsk.Start_date__c + Integer.valueOf(tsk.Cycle_Time__c) - 1;
                }
            }
            else if(tsk.Start_date__c == null && tsk.End_date__c == null)
            {
                if(takStartDate == null && takEndDate == null )
                {   
                    takStartDate = date.today();
                    takEndDate = takStartDate + Integer.valueOf(tsk.Cycle_Time__c) - 1;
                }
                else
                {   
                    takStartDate = takEndDate + 1;
                    takEndDate = takStartDate + Integer.valueOf(tsk.Cycle_Time__c) - 1;
                }
            }
            if(mapoflst.keyset().contains(tsk.Assigned_To__c))
            {
                Map<Date,TaskWrapper> taskToDisplayMap = mapoflst.get(tsk.Assigned_To__c);
                if(tsk.Task_Status__c =='Completed')
                {
                    taskToDisplayMap.put(takStartDate,new TaskWrapper(tsk,takStartDate.daysBetween(takEndDate) + 1,'green'));
                }
                else if(tsk.Task_Status__c =='Started')
                {
                    taskToDisplayMap.put(takStartDate,new TaskWrapper(tsk,takStartDate.daysBetween(takEndDate) + 1,'yellow'));
                }
                 else if(tsk.Task_Status__c =='Assigned')
                 {
                    taskToDisplayMap.put(takStartDate,new TaskWrapper(tsk,takStartDate.daysBetween(takEndDate) + 1,'blue'));
                 }
                mapoflst.put(tsk.Assigned_To__c,taskToDisplayMap);
                System.debug('takStartDate'+takStartDate);
                System.debug('takEndDate'+takEndDate);
                
                
                for(Date dt = takStartDate + 1 ; dt <= takEndDate ; dt += 1) 
                {   
                    taskToDisplayMap.remove(dt);
                    System.debug('taskToDisplayMap'+taskToDisplayMap);
                }
            }
            //when new user assigned to a task
            else
            {
                Map<Date,TaskWrapper> taskToDisplayMap = new Map<Date,TaskWrapper>();
                System.debug('takStartDate :::::::::::'+takStartDate);
                
                if(tsk.Sequence__c == 1)
                {
                    startdat= tsk.Start_date__c; 
                }
                if(startdat== null)
                {
                    startdat = Date.Today();
                }
                
                //System.debug('startdat :::::::::::'+startdat);
                if(listofdate.size() >0)
                {
                    for(Date d = startdat ; d <= startdat + listofdate.size() - 1 ; d += 1)
                    {   
                        if(takStartDate == d)
                        {   System.debug('dt :::::::::::'+d);
                            if(tsk.Task_Status__c == 'Completed')
                            {
                                taskToDisplayMap.put(d,new TaskWrapper(tsk,takStartDate.daysBetween(takEndDate) + 1,'green'));
                            }
                            else if(tsk.Task_Status__c == 'Started')
                            {
                                taskToDisplayMap.put(d,new TaskWrapper(tsk,takStartDate.daysBetween(takEndDate) + 1,'yellow'));
                            }
                            else if(tsk.Task_Status__c == 'Assigned')
                            {
                                taskToDisplayMap.put(d,new TaskWrapper(tsk,takStartDate.daysBetween(takEndDate) + 1,'blue'));
                            }
                            d += takStartDate.daysBetween(takEndDate) ;
                        }
                        else
                        {
                            taskToDisplayMap.put(d,new TaskWrapper(new TaskCs__c(), 1,'lightsteelblue'));
                        }
                    }
                    mapoflst.put(tsk.Assigned_To__c,taskToDisplayMap);
                }
            }
        } 
    }
    
    // List of main query of Process and task
    public void listmehtod()
    {
        process = [Select Name,Description__c,Start_Date__c,End_Date__c,Status__c,Sequence_Count__c,(Select Name,Start_date__c,End_date__c,Task_Description__c,Task_Status__c,Assigned_To__c,Cycle_Time__c,Sequence__c,Process__c,Assigned_To__r.name From TaskCs__r ORDER BY Sequence__c ASC) From Process__c where Id=: ac LIMIT 1];
    }
    
    // Mehtod of edit process
      public PageReference edit() 
      {   
         try
         {
            update process;
         }
         catch(exception e)
         {
         }
         PageReference page = new Pagereference('/apex/ProcessPage?Id='+ac);
         System.debug('id of this'+page);
         page.setRedirect(true);
         return page;
     }
    
              
    //Method of  new task           
     public PageReference newtask() 
     {     
         PageReference page = new Pagereference('/apex/Taskpage?pid='+Apexpages.currentPage().getparameters().get('Id'));
         System.debug('id of this'+page);
         page.setRedirect(true);
         return page;
     }
    
     //Method of delete task          
     public PageReference deletetsk() 
     { 
        try 
        { 
            Process__c liac = new Process__c();  
            //for(Process__c pr :listprocess) {
                for(TaskCs__c  ts :process.TaskCs__r)
                {
                    if(ts.id != null)
                    {
                        System.debug('selectid'+selectid);  
                        System.debug('taskI ki Id:::'+ts.id);
                        if(ts.id == selectid) { 
                        System.debug('Ts ki Id equal to SelectId::'+ts.id);          
                            DELETE ts; 
                            System.debug('Delete Task iki Id:::'+ts.id);    
                        }
                    }
                }
                System.debug('after delete  before Update list of task:::'+process.TaskCs__r);
                update process.TaskCs__r;   
                System.debug('after delete Update list of task:::'+process.TaskCs__r);           
        }
        catch(DMLException de) 
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.ERROR,de.getmessage()));    
        }
        listmehtod();
        return null;
    }
    
    // arrow of downward
    public void toggleSort() 
    {
        String str= sortField;
        System.debug('str'+str);
        try
        {
            List<TaskCs__c> tasklist =process.TaskCs__r;
            for(integer i=0;i<tasklist.size();i++)
            { 
                if(tasklist[i].Sequence__c == integer.valueof(str))
                {
                    if(tasklist[i].Task_Status__c=='Assigned' && (tasklist[i+1].Task_Status__c !='Completed' || tasklist[i+1].Task_Status__c !='Started' ))
                    {
                        tasklist[i].Sequence__c =integer.valueof(str)+1;
                        System.debug('pr.TaskCs__r[i].Sequence__c'+tasklist[i].Sequence__c);
                        tasklist[i+1].Sequence__c =integer.valueof(str);    
                        System.debug('pr.TaskCs__r[i+1].Sequence__c'+tasklist[i+1].Sequence__c);
                        break;
                    }
                }       
            }  
            update tasklist;    
            listmehtod();
        }
        catch(DMLException de) 
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.ERROR,de.getmessage()));    
        }
    } 
    
    //method of Up Arrow
    public void toggleSortup() 
    {
        Decimal seq= sortFieldup;
        System.debug('seq'+seq);
        try
        {
            List<TaskCs__c> tasklist =process.TaskCs__r;
            if(tasklist.size()>0)
            {
            for(integer i=0;i<tasklist.size();i++)
            {
                if(tasklist[i].Sequence__c == seq)
                {
                    if(tasklist[i].Task_Status__c=='Assigned' && tasklist[i-1].Task_Status__c!='Completed' &&tasklist[i-1].Task_Status__c!='Started')   
                    {
                        tasklist[i].Sequence__c = seq-1;
                        System.debug('pr.TaskCs__r[i].Sequence__c'+tasklist[i].Sequence__c);
                        tasklist[i-1].Sequence__c =seq;     
                        System.debug('pr.TaskCs__r[i+1].Sequence__c'+tasklist[i-1].Sequence__c);
                        break;
                    }
                }
            }  
            update tasklist;  
            }
            listmehtod();
        }
         catch(DMLException de) 
         {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.ERROR,de.getmessage()));    
         }
    }
    
    //method of datelist
    public void dateofprocesstask()
    {
        diffDate = 0;
        Date dateoftask = process.Start_Date__c != null? process.Start_Date__c:Date.Today();
        for( TaskCs__c tcs :process.TaskCs__r )
        { 
            startDate = tcs.Start_date__c;
            endDate = tcs.End_date__c;
            if(startDate != null && endDate!= null)
            {
                diffDate += startDate.daysBetween(endDate)+1;
            }
            else if(startDate != null && endDate== null && startDate != Date.Today())
            {
                if(startDate.daysBetween(Date.Today())> =Integer.valueof(tcs.Cycle_Time__c))
                {
                    diffDate +=startDate.daysBetween(Date.Today())+1;  
                }
                else
                {
                    diffDate +=Integer.valueof(tcs.Cycle_Time__c);
                }   
            }
            else
            {
                 diffDate=diffDate+Integer.valueof(tcs.Cycle_Time__c);
            }
        }   
        for(integer i=1; i<=diffDate;i++)
        {
            if(i!= 1)
            {
                dateoftask=+(dateoftask).addDays(1);
                String dateoftask123 = dateoftask.format();
                listofdate.add(dateoftask123);
            }
            else
            {
                dateoftask=+ (dateoftask);
                System.debug(' dateoftask:::'+ dateoftask);
                String dateoftask123 = dateoftask.format();
                listofdate.add(dateoftask123);
            }
        }
        listmehtod();
    }
    
    // Task wrapper class
    public class TaskWrapper
    {
        public TaskCs__c task {get;set;}
        public Integer colSpan {get;set;}
        public String color{get;set;}
        public String stdate{get;set;}
        public String eddate{get;set;}
        
        public TaskWrapper(TaskCs__c task,Integer colSpan, String color)
        {
            this.task = task;
            this.colSpan = colSpan;
            this.color = color;
            if(task.Start_date__c != null && task.End_date__c != null ){
                this.stdate= task.Start_date__c.format();
                this.eddate = task.End_date__c.format();
            }
        }
    }      
}