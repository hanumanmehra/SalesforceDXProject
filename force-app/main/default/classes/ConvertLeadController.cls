public Class ConvertLeadController
{
   /*public Class ConvertLeadController
{
    public Lead currLead{get;set;}
    public Contact con{get;set;}
    public Boolean sendOwnerEmail{get;set;}
    public String selectedAccount{get;set;}
    public String company{get;set;}
    public String  leadId;
    public Contact contactID {get;set;}
    public  Account acc{get;set;}
    public Boolean doNotCreateOppty {get; set;}
    public List<SelectOption> accounts {get; set;}
    public boolean checkSelAccount{get;set;}
    public String selectedContact{get;set;}
    
    
    public ConvertLeadController(ApexPages.StandardController controller)
    {
        contactID  =  new Contact();
        acc =  new Account();
        checkSelAccount =false;
        Database.LeadConvert leadConvert = new database.LeadConvert();
        if (contactId == null) {
            contactID = new Contact(OwnerId = leadConvert.ownerId);
        }
       accounts =  new List<SelectOption>();
       currLead =  new Lead();
       con =  new Contact();
       leadId = controller.getId();
       System.debug('LaedId :::'+leadId ); 
       currLead   =  [Select Name,OwnerId,Company,ConvertedAccountId,isConverted,Status from Lead Where Id =:leadId Limit 1];
       company = currLead.Company;
       contactID = new Contact(OwnerId = currLead.ownerId);
       System.debug('currLead   :::'+currLead); 
       accountselectlist();         
    }
    
    public void accountselectlist()
    {
        try {
            System.debug('Com'+company);
            List<Account> acclist =[SELECT Id, Name,(select Id,Name from Contacts) FROM Account WHERE Name =:company Limit 1];
            System.debug('Acconut '+acc );
            if(acclist  != null && acclist.size() >0) {
                acc = acclist[0]; 
                accounts.add(new SelectOption('Existing', 'Attach to Existing: ' +acc.Name));
            }
            accounts.add(new SelectOption('NEW', 'Create New Account: ' + company));
            System.debug('accounts ::'+accounts);
        }
        catch(exception e){
            System.debug('Error message '+e.getmessage());
        }  
        
    }
    
    public void accountChanged(){
        System.debug('selectedAccount'+selectedAccount);
    }
    public void accountLookedUp() {
        System.debug('selectedAccount'+selectedAccount);
        acc = [SELECT Id, Name,(select Id,Name from Contacts) FROM Account WHERE Id = :con.AccountId];
        if (acc  != null ) 
        {
            accounts.add(new SelectOption('Existing', 'Attach to Existing: ' +  acc.Name));
        }  
    }
    
    // set up the Lead Status pick list
    public List<SelectOption> getLeadStatusOption() 
    {         
        List<SelectOption> selectlist = new List<SelectOption>();
        //get the lead statuses
        LeadStatus [] ls = [select MasterLabel from LeadStatus where IsConverted=true order by SortOrder];
        // if there is more than 1 lead status option, add a NONE option  
        if (ls.size() > 1) {
            selectlist.add(new SelectOption('NONE', '-None'));
        }
        
        // add the rest of the lead status options
        for (LeadStatus convertStatus : ls) {
            selectlist.add(new SelectOption(convertStatus.MasterLabel, convertStatus.MasterLabel));
        } 
        return selectlist; 
    }
    
    public  PageReference  convertLeadRelatedAccountContacts()
    {
        PageReference   pr;
        if(selectedAccount != 'Existing')
        {
             pr=  convertLeadRecord();
             //System.debug('we are in else if');
        }
        else
        {
            boolean existingContact =  false;
            for(contact con :acc.Contacts)
            {
                if(con.name == currLead.Name)
                {
                    existingContact= true;
                }
            }
            if(acc.Name == company && existingContact ==  true)
            {
               checkSelAccount =true;
               getContactOption();  
            }
            else
            {
                pr=  convertLeadRecord();
            }
        }
        if(pr != null)
        {
            return pr;
        }
        return null;   
    }
    
    public PageReference convertLeadRecord()
    {
        // This is the lead convert object that will convert the lead 
        Database.LeadConvert leadConvert = new database.LeadConvert();    
        Id accountsId ;  
        //set lead ID
        leadConvert.setLeadId(currLead.Id); 
        try {
            if(selectedContact != null && selectedContact !='NEW') {
                leadConvert.setContactId(selectedContact);
            }
              
           if(acc.Id  != null && selectedAccount =='Existing' || (selectedContact != null && selectedContact =='NEW')) {
                leadConvert.setAccountId(acc.Id); 
            } 
            
            
            //set the lead convert status
            System.debug('currLead.Status::::'+currLead.Status );
            leadConvert.setConvertedStatus(currLead.Status);
            //set the variable to create or not create an opportunity
            leadConvert.setDoNotCreateOpportunity(true);  
            //set the owner id
            leadConvert.setOwnerId(currLead.ownerID);
            //set whether to have a notification email
            leadConvert.setSendNotificationEmail(sendOwnerEmail);
            System.debug('leadConvert :: '+leadConvert);
            //convert the lead
            Database.LeadConvertResult leadConvertResult = Database.convertLead(leadConvert);
            if((acc.Id  == null || acc.Id  != null) && selectedAccount =='NEW') {
                accountsId = leadConvertResult.getAccountId(); 
                System.debug('accountsId  :: '+accountsId );
            }            
            System.debug('accountsId'+accountsId +'leadConvertResult '+leadConvertResult  +'leadConvertResult.success' +leadConvertResult.success);
            //Create a custom opportunity
            System.debug('Company '+Company +'lead Account'+leadConvertResult.getAccountId());
            if(doNotCreateOppty == false)
            {   
                System.debug('We are in custom opoortunity');
                Opportunity_SFDC__c oppSfdc =  new Opportunity_SFDC__c ();
                oppSfdc.Name =   Company +'-';
                oppSfdc.Account__c = leadConvertResult.getAccountId(); 
                oppSfdc.Opportunity_Owner__c = currLead.ownerID;
                //oppSfdc.CloseDate__c = Date.newInstance(2020, 12, 31);
                oppSfdc.CloseDate__c = Date.today().addmonths(5);
                oppSfdc.Amount__c = 0.0;
                oppSfdc.Type__c='Salesforce-Services-Only';
                insert oppSfdc;
            }
            
            if(acc.Id  != null && selectedAccount =='Existing') {
                accountsId = acc.Id; 
            } 
        }
        catch(exception e)
        {
            System.debug('Error message '+e.getmessage());
        }  
        
        PageReference page = new Pagereference('/'+accountsId);
        System.debug('page'+page);
        page.setRedirect(true);
        return page;
    }
    
    public List<SelectOption> getContactOption() 
    {  
        System.debug('we are in select listoption');   
        List<SelectOption> selectlist = new List<SelectOption>();
        if( acc.contacts != null)
        {
            for(contact con : acc.contacts) {
                if(con.name == currLead.Name )
                {
                    selectlist.add(new SelectOption(con.Id,'Attach to Existing: ' +con.name)) ;
                    //checkSelAccount =true;
                }
            }
        }
        
        selectlist.add(new SelectOption('NEW', 'Create New Contact: ' + currLead.Name));
        System.debug('selectlist'+selectlist);
        return selectlist; 
    }
      
    public PageReference cancelConvertLead()
    {
        System.debug('We are convert lead');
        PageReference page = new Pagereference('/'+leadId);
        System.debug('page'+page);
        page.setRedirect(true);
        return page;
    }
}*/
}