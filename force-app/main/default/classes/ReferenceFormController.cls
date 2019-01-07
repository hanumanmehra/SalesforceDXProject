Public class ReferenceFormController {
/*
    public Reference_Form__c referenceRecord{get;set;}
    public Employer__c employerRecord{get;set;}
    public List<Employer__c> listOfEmployer{get;set;}
    public boolean hireBoolean{get;set;}
    public boolean noHireBoolean{get;set;}
    public Id accountIds;
    public Integer rowNum{get;set;}
    
    public ReferenceFormController (ApexPages.StandardController controller ){
        hireBoolean = false;
        noHireBoolean =  false;
        accountIds= controller.getId();
        listOfEmployer =  new List<Employer__c>();
        referenceRecord =  new Reference_Form__c();
        employerRecord =  new Employer__c ();
        employerRecord.Applicant__c = accountIds; 
        listOfEmployer.add(employerRecord);    
        referenceRecord.Account__c =accountIds;  
    }
    
    
     public void addNew(){
        try{
            employerRecord =  new Employer__c ();
            employerRecord.Applicant__c = accountIds; 
            listOfEmployer.add(employerRecord); 
            System.debug('listOfEmployer::'+listOfEmployer);
        }
        catch(Exception ex){
            System.debug('Error message in add row'+ex.getMessage());
        }
    }
    
    public void delRow(){
        integer listSize =listOfEmployer.size() -1; 
        System.debug('listSize :::'+listSize );
        if(listSize != null && listSize >0) {
            listOfEmployer.remove(listSize);
        }
        system.debug('listOfEmployer'+listOfEmployer);
    }

    
    public pageReference saveReferenceData(){
        try
        {
            if(referenceRecord != null && referenceRecord.Name != null){
            System.debug(' before insert referenceRecord '+referenceRecord );  
                if(referenceRecord.Would_You_Hire__c == true){
                    referenceRecord.No_Hire__c =  false;
                    referenceRecord.No_Hire_Comments__c=  '';
                } 
                insert referenceRecord ;
            System.debug(' before insert referenceRecord '+referenceRecord );
            }
            if(listOfEmployer != null && listOfEmployer.size() >0){
                insert listOfEmployer;
            }
        }
        catch(Exception ex)
        {
            System.debug('Error message in add row'+ex.getMessage());
        }
    
        Pagereference page = new Pagereference('/'+accountIds); 
        page.setRedirect(true);
        return page;    
    }
     public pageReference cancel(){
        Pagereference page = new Pagereference('/'+accountIds); 
        page.setRedirect(true);
        return page;   
    }
    
    public pageReference hireBooleanMethod() {
        if(hireBoolean == false){
            hireBoolean = true;
            
        }
        else{
             hireBoolean = false;
        }
        return null;
    }
    
    public pageReference noHireBooleanMethod() {
        if(noHireBoolean == false){
            noHireBoolean = true;
        }
        else{
             noHireBoolean = false;
        }
        return null;
    }

*/
    
}