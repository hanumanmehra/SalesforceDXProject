public with sharing class NewOpportunityTeamController 
{
   /* public with sharing class NewOpportunityTeamController 
{
    public String oppId;
    Public Opportunity__c oppRec {get;set;}
    public List<OpportunityTeamWrapper> opportunityTeamlist{ get; set; }
    public String propId;

    public NewOpportunityTeamController(ApexPages.StandardController controller) 
    {
        oppId = ApexPages.currentPage().getParameters().get('id');
        opportunityTeamlist= new List<OpportunityTeamWrapper>();
        OppRec = [Select id,name,Account__c,OwnerId,Technical_Quarterback__c from opportunity__c where id  =: oppId Limit 1];
        System.debug('OppRec :::'+OppRec);
        
        OpportunityTeamWrapper oppTeamwrap = new OpportunityTeamWrapper();
        oppTeamwrap.opp=new Opportunity_Team__c();
        opportunityTeamlist.add(oppTeamwrap);
        System.debug('ProposalLineItems:::'+opportunityTeamlist);
        
    }
    
     public void addRow()
     {
        try
        {
           OpportunityTeamWrapper oppwrap = new OpportunityTeamWrapper();
            oppwrap.opp=new Opportunity_Team__c();
            opportunityTeamlist.add(oppwrap);
            System.debug('ProposalLineItems::'+opportunityTeamlist);
        }
        catch(Exception ex)
        {
            System.debug('Error message in add row'+ex.getMessage());
        }
    }
     
    public List<SelectOption>getstagePicklistvalue()
    {
        List<SelectOption> teamRoleOption = new List<SelectOption>();
        teamRoleOption.add(new SelectOption('None','None'));
        Schema.DescribeFieldResult feildResult = Opportunity_Team__c.Team_Role__c.getDescribe();
        LIST<Schema.PicklistEntry> pickListResult = feildResult.getPicklistValues();
        for(Schema.PicklistEntry f : pickListResult)
        {
             teamRoleOption.add(new SelectOption(f.getLabel(),f.getLabel()));
        }
        System.debug('options:::'+teamRoleOption );
        return teamRoleOption ;
    }
    
    public List<SelectOption> getopportunityAccess()
    {
        List<SelectOption> teamRoleOption = new List<SelectOption>();
        teamRoleOption.add(new SelectOption('Read/Write','Read/Write'));
        return teamRoleOption;
    }

    public pageReference savePage()
    {
        System.debug('opportunityTeamlist::::'+opportunityTeamlist);
        try
        {
            List<Opportunity__Share> opportunityShareList =  new List<Opportunity__Share>();
            LisT<Opportunity_Team__c> ToinsertOpportunityTeamList =  New List<Opportunity_Team__c>();
            Set<id> setOfUserId =  new  Set<id>();
            List<Opportunity__Share> allShareOFOppootunityList=  [SELECT Id,UserOrGroupId,ParentId  FROM Opportunity__Share WHERE ParentId =:oppId  AND RowCause = 'Manual'];
            if(allShareOFOppootunityList != null && allShareOFOppootunityList.size() > 0)
            {
                for(Opportunity__Share oppSh : allShareOFOppootunityList)
                {
                    setOfUserId.add(oppSh.UserOrGroupId); 
                }
            }
            for(OpportunityTeamWrapper oppwarp :  opportunityTeamlist)
            {
                if(!setOfUserId.contains(oppwarp.opp.User__c))
                {
                    Opportunity__Share oppShr  = new Opportunity__Share();
                    Opportunity_Team__c oppteam =  new Opportunity_Team__c();
                    oppShr.ParentId =oppId;
                    oppteam.Opportunity__c =oppId;  
                    System.debug('oppShr.ParentId :::'+oppShr.ParentId ); 
                   
                    // Set the ID of user or group being granted access.
                    oppShr.UserOrGroupId = oppwarp.opp.User__c;
                    oppteam.User__c=oppwarp.opp.User__c;  
                    setOfUserId.add(oppwarp.opp.User__c); 
                    System.debug('oppShr.UserOrGroupId :::'+oppShr.UserOrGroupId ); 
                    
                    // Set the access level.
                    System.debug('selectOpportunityAccess:::'+oppwarp.selectOpportunityAccess +'TeamRole::'+oppwarp.selectedTeamRole);
                    if(oppwarp.selectOpportunityAccess =='Read/Write')
                    {
                        oppShr.AccessLevel = 'Edit';
                    }
                    if(oppwarp.selectOpportunityAccess =='Read only')
                    {
                        oppShr.AccessLevel = 'Read';
                    }
            
                    oppteam.Team_Role__c=oppwarp.selectedTeamRole;
                    oppteam.Staff__c=oppwarp.opp.Staff__c;
        
                    System.debug('oppShr.AccessLevel:::'+oppShr.AccessLevel);
                    if(oppteam.Team_Role__c != 'None' )
                    {
                        ToinsertOpportunityTeamList.add(oppteam);
                        opportunityShareList.add(oppShr); 
                    }
                }
                
            }
            
            if(opportunityShareList != null && opportunityShareList.size() >0)
            {
                insert opportunityShareList;
                System.debug('opportunityShareList :'+opportunityShareList);
            }
            if(ToinsertOpportunityTeamList != null && ToinsertOpportunityTeamList.size() >0)
            {
                insert ToinsertOpportunityTeamList;
            }
        }
        catch(Exception e)
        {
              System.debug('Error message in sharing opportunity'+e.getMessage());
        }
        Id idOfproposal =PropId;
        Pagereference page = new Pagereference('/'+oppId); 
        page.setRedirect(true);
        return page;
    }
    
    public PageReference cancel()
    {
        Pagereference page = new Pagereference('/'+OppRec.id); 
        page.setRedirect(true);
        return page;
    }
    
    public class OpportunityTeamWrapper
    {
        public Opportunity_Team__c opp{get;set;}
        public String selectedTeamRole{get;set;}
        public String selectOpportunityAccess{get;set;}
        public OpportunityTeamWrapper()
        {
           opp = new Opportunity_Team__c ();
           selectedTeamRole = '';
           selectOpportunityAccess='';
        }   
    }  
}*/
}