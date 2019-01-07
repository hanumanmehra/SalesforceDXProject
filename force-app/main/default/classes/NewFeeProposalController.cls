global class NewFeeProposalController 
{
   /* global class NewFeeProposalController 
{
    public String OppId;
    Public Opportunity__c OppRec {get;set;}
    public Boolean ErrorFlag{get;set;}
    public List<ProposalLineItemWrapper> ProposalLineItems{ get; set; }
    public String PropId{get;set;}
    Public Proposal__c proposal {get;set;}
    public Integer rowNum{get;set;}
    public String proposalName{get;set;}

    public NewFeeProposalController (ApexPages.StandardController controller) 
    {
        OppId = ApexPages.currentPage().getParameters().get('id');
        PropId = ApexPages.currentPage().getParameters().get('pid');
        ProposalLineItems= new List<ProposalLineItemWrapper>();
        proposal = new Proposal__c();
        proposalName = 'Quote _'+OppId +'_' +string.valueof(Datetime.now());
          
        OppRec = [Select id,name,Account__c,Synced_Proposal__c,PriceBook2__c,(select Id from Proposal__r) from opportunity__c where id  =: OppId Limit 1];
        System.debug('OppRec :::'+OppRec +'OppRec Proposal__r'+OppRec.Proposal__r.size());
        ErrorFlag = false;
        ProposalLineItemWrapper proposalwrap = new ProposalLineItemWrapper();
        proposalwrap.pcLine=new Proposal_Line_Items__c();
        ProposalLineItems.add(proposalwrap);
        System.debug('ProposalLineItems:::'+ProposalLineItems);   
    }
    
    
   
    
    
     public void addRow()
     {
        try
        {
            ProposalLineItemWrapper proposalwrap = new ProposalLineItemWrapper();
            proposalwrap.pcLine=new Proposal_Line_Items__c(); 
            ProposalLineItems.add(proposalwrap);
            System.debug('ProposalLineItems::'+ProposalLineItems);
        }
        catch(Exception ex)
        {
            System.debug('Error message in add row'+ex.getMessage());
        }
    }
    
    
     public void delRow()
    {
        rowNum = Integer.valueOf(apexpages.currentpage().getparameters().get('index'));
        if(rowNum != null)
        {
            ProposalLineItems.remove(rowNum);
        }
        system.debug('--ProposalLineItems--'+ProposalLineItems);
    }
    
    public pageReference SavePage()
    {  
        Product2  product = [Select Name,ProductCode,IsActive,Description from Product2 where Id In (Select Product2Id from PricebookEntry where Pricebook2.Name =:'Standard Price Book')];
        System.debug('product ::'+product );
        PricebookEntry  pricebookentryList  = [Select Id,Name,Product2Id,Pricebook2Id,Product2.Name from PricebookEntry where Pricebook2.Name=: 'Standard Price Book'] ;
        System.debug('product ::'+pricebookentryList );
        try
        {
            Map<Id,Proposal__c > mapOfIdsOrProposal =  new Map<Id,Proposal__c >();
            if(OppRec.Proposal__r.size() == 0)
            {
                Id recordTypeSync;
                List<RecordType> recordTypes = [SELECT Id,Name, Description FROM RecordType WHERE IsActive=true AND SobjectType='Proposal__c' AND (Name='Other' OR Name='Sync')];   
                System.debug('REcord type name :::'+recordTypes );
                for(RecordType rt: recordTypes)
                {
                    if(rt.Name== 'Sync')  
                    {
                     recordTypeSync = rt.Id; 
                    }
                }
                proposal.Syncing__c = true;
                proposal.RecordTypeId =recordTypeSync;
                System.debug('proposal11 ::'+proposal);
            } 
            if(PropId == null)
            {
                 if(ProposalLineItems[0].salesprice >0.00)
                 {
                     System.debug('proposal12 ::'+proposal);
                     proposal.Name =proposalName;
                     proposal.Opportunity__c  = OppId;
                     proposal.Account_Name__c = OppRec.Account__c;
                     insert proposal;
                 }
                else
                {
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.ERROR,'sales price never be less than zero ')); 
                    return null;
                }  
            }
            List<Proposal_Line_Items__c> toInsertProposalLineItem = new List<Proposal_Line_Items__c>();  
            System.debug(' List in save method QlI'+ProposalLineItems);
            for(ProposalLineItemWrapper pc:  ProposalLineItems )
            {
               if(pc.salesprice > 0.00)
               {
                   Proposal_Line_Items__c proposalLineItem = new Proposal_Line_Items__c();
                   proposalLineItem.TT_Practice__c =pc.pcLine.TT_Practice__c;
                   proposalLineItem.TT_Office__c=  pc.pcLine.TT_Office__c;
                   proposalLineItem.Status__c='Pending';
                   proposalLineItem.Quantity__c =1.00;
                   proposalLineItem.Proposal_Name__c  = proposal.Id !=null ?proposal.Id:PropId;
                   proposalLineItem.Product__c = pricebookentryList.Product2Id;
                   proposalLineItem.Description__c = pc.description;
                   proposalLineItem.UnitPrice__c = pc.salesprice;
                   proposalLineItem.Total_Price__c = proposalLineItem.Quantity__c * pc.salesprice;
                   
                   toInsertProposalLineItem.add(proposalLineItem);
               }
               else
               {
                   ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.ERROR,'sales price never be less than zero ')); 
                   return null;
               }
            }
            if(toInsertProposalLineItem.size() >0)
            {
                insert toInsertProposalLineItem;
                System.debug('toInsertProposalLineItem'+toInsertProposalLineItem);
            }
        }
        catch(Exception ex)
        {
            System.debug('Error message in add row'+ex.getMessage());
        }
        
        Id idOfproposal =proposal.Id !=null ?proposal.Id:PropId;
        if(idOfproposal  == null )
        {
           idOfproposal  = oppId; 
        }
        Pagereference page = new Pagereference('/'+idOfproposal); 
        page.setRedirect(true);
        return page;
    }

    public PageReference Cancel()
    {
        Pagereference page = new Pagereference('/'+OppRec.id); 
        page.setRedirect(true);
        return page;
    }
    
    webservice static void startSync(Id ProvId)
    {
        System.debug('We are in static method ProvId :::'+ProvId);
        Id recordTypeOther;
        Id recordTypeSync;
        Map<Id,Proposal__c > mapOfIdsOrProposal =  new Map<Id,Proposal__c >();
        
        List<RecordType> recordTypes = [SELECT Id,Name, Description FROM RecordType WHERE IsActive=true AND SobjectType='Proposal__c' AND (Name='Other' OR Name='Sync')];   
        System.debug('REcord type name :::'+recordTypes );
        for(RecordType rt: recordTypes )
        {
            if(rt.Name== 'Sync')  
            {
                recordTypeSync = rt.Id; 
            }
          else
          {
            recordTypeOther =rt.Id;
          }
        }
        List<Proposal__c>  propList = [Select Id ,Name,Syncing__c,Opportunity__c,Total_Price__c from  Proposal__c];
        List<Proposal__c>  ToUpdatepropList = new List<Proposal__c> ();
  
        System.debug('propList '+propList ); 
        if(propList  != null && propList.size() >0)
        {
            for(Proposal__c pc:propList)
            {
                if(pc.Syncing__c == true)
                {
                    pc.Syncing__c =false;
                    pc.RecordTypeId =recordTypeOther;
                    ToUpdatepropList.add(pc);
                }
                if(pc.Id == ProvId)
                {
                   pc.Syncing__c = true;
                   pc.RecordTypeId =recordTypeSync;
                   ToUpdatepropList.add(pc);
                   System.debug('Total Price::'+pc.Total_Price__c+'Proposal record::'+pc);
                   mapOfIdsOrProposal.put(pc.Opportunity__c,pc);
                }
            }
            update ToUpdatepropList;
        }  
    }
    
    webservice static void stopSync(Id ProvId)
    {
        Id recordTypeOther;
        Id recordTypeSync;
         
        List<RecordType> recordTypes = [SELECT Id,Name, Description FROM RecordType WHERE IsActive=true AND SobjectType='Proposal__c' AND (Name='Other' OR Name='Sync')];   
        System.debug('REcord type name :::'+recordTypes );
        for(RecordType rt: recordTypes )
        {
          if(rt.Name== 'Sync')  
          {
             recordTypeSync = rt.Id; 
          }
          else
          {
              recordTypeOther =rt.Id;
          }
        }
        
        List<Proposal__c>  propList = [Select Id ,Name,Syncing__c,Opportunity__c,RecordTypeId from  Proposal__c where RecordTypeId =:recordTypeSync];
        List<Proposal__c>  ToUpdatepropList = new List<Proposal__c> ();
        if(propList  != null && propList.size() >0)
        {
            for(Proposal__c pc:propList)
            {
                if(pc.Syncing__c == true)
                {
                    pc.Syncing__c =false;
                    pc.RecordTypeId =recordTypeOther ;
                    ToUpdatepropList.add(pc);
                }
            }
            update ToUpdatepropList;
        }     
    }
    
    
    public class ProposalLineItemWrapper
    {
        public Proposal_Line_Items__c pcLine{get;set;}
        public String description{get;set;}
        public Decimal salesprice{get;set;}
        public ProposalLineItemWrapper()
        {
            pcLine = new Proposal_Line_Items__c ();
            description ='';
            salesprice = 0.00;
        }
        
    }  
} */
}