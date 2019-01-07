public class SubmitCaseController {
    
    public Case c { get; set; }
    
    public String acctNum { get; set; } 
    public Attachment attachment {
  get {
      if (attachment == null)
        attachment = new Attachment();
      return attachment;
    }
  set;
  }
    public SubmitCaseController() {
        c = new Case();
    }
    
    public PageReference submitCase() {
    System.debug('acctNum'+acctNum);
        List<Account> accts = [SELECT Id FROM Account WHERE AccountNumber = :acctNum];
        system.debug('accts '+accts);
        if (accts.size() != 1) {
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.FATAL, 'Invalid account number');
            ApexPages.addMessage(msg);
            return null;
        } else {
            try {
                c.AccountId = accts[0].Id;
                system.debug('c'+c);
                // now look for an associated contact with the same email
                Contact cnt = [SELECT Id FROM Contact WHERE AccountId = :c.AccountId AND Email = :c.SuppliedEmail LIMIT 1];
                if (cnt != null) 
                    c.ContactId = cnt.Id;
                   system.debug('c2 '+c);
                    
                //Specify DML options to ensure the assignment rules are executed
                Database.DMLOptions dmlOpts = new Database.DMLOptions();
                dmlOpts.assignmentRuleHeader.useDefaultRule = true;
                dmlOpts.EmailHeader.triggerAutoResponseEmail = true;
                c.setOptions(dmlOpts);

                // Insert the case
                INSERT c;
                
                //Blob picture = req.requestBody;
                attachment.ParentId = c.Id;
                attachment.ContentType = 'image/jpg';
                attachment.Name = 'VehiclePicture';
                
                insert attachment;                
                return new PageReference('/'+c.Id);
            } catch (Exception e) {
                ApexPages.addMessages(e);
                return null;
            }
        }
    }
}