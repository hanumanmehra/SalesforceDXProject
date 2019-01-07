global Class DeleteAllOpportunityTeam
{
    /*webservice static void  deleteAllTeam(Id opporId)
    {
        System.debug('We are in static method opporId:::'+opporId);
        List<Opportunity_Team__c > oppotunityteamList = [Select Id,Name,Opportunity__c from Opportunity_Team__c where Opportunity__c =:opporId ];
        System.debug('oppotunityteamList :::'+oppotunityteamList);
        if(oppotunityteamList!= null && oppotunityteamList .size() >0)
        {
            List<Opportunity__Share> sharesToDelete = [SELECT Id FROM Opportunity__Share WHERE ParentId =:opporId AND RowCause = 'Manual'];
            if(!sharesToDelete.isEmpty())
            {
                Database.Delete(sharesToDelete, false);
            }
            delete oppotunityteamList;
        }
    }*/
    
    /*global class EditAllProposalLineItemController
{
    public String proposalId;
    public List<Proposal_Line_Items__c> proposalLineItemList{ get; set; }
 

    public EditAllProposalLineItemController(ApexPages.StandardController controller) {
        proposalId = ApexPages.currentPage().getParameters().get('id');
        
        //proposalLineItemList = new List<ProposalLineItemWrapper>();
        if(proposalId  != null){
            proposalLineItemList = [Select id,Product__c,Discount__c,Fee_Description__c,ListPrice__c,Quantity__c,UnitPrice__c,Total_Price__c,Proposal_Name__c from Proposal_Line_Items__c where Proposal_Name__c=: proposalId];
        }
       
    }

    public pageReference SavePage()
    {
       
        try{
            update proposalLineItemList;
        } 
        catch(Exception e){
            System.debug('Exception = '+e);
        }
        Pagereference page = new Pagereference('/'+proposalId); 
        page.setRedirect(true);
        return page;
    }


    public PageReference Cancel()
    {
        Pagereference page = new Pagereference('/'+proposalId ); 
        page.setRedirect(true);
        return page;
    }
    
}*/
}