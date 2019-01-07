@isTest
public Class ConvertLead_Test
{
    public Static testMethod void leadCoversionWithNewOpportunity()
    {
     /*  Profile testProfile = [SELECT Id FROM profile WHERE Name = 'System Administrator' LIMIT 1];
       List<User> userlist  = new List<User>();
       User usr = TestDataGenerator.createUser('testuser', 'atest1','test1@gmail.com','leadsitest@demo.com','atest1',testProfile ,'America/Los_Angeles','en_US','UTF-8','en_US');
       userlist.add(usr);
       User usr2 = TestDataGenerator.createUser('testuser2', 'atest2','test2@gmail.com','leadsitest2@demo.com','atest2',testProfile ,'GMT','en_US','UTF-8','en_US');
       userlist.add(usr2);
       insert  userlist;
       //System.assert(null,usr);
       System.debug('Userlist'+userlist+ 'user1'+userlist[0]);
       Lead led = TestDataGenerator.createLead(userlist[0],'USD' ,'Technomile Sales', 'Open-Not Contacted', 'Test Lead', 'Technotech');
       insert led ;  
       //System.assert(null,Usr);
       System.debug('led '+led );
       
       Account acc = TestDataGenerator.createAccount('Test Acccount'); 
       insert acc;
       System.debug('acc '+acc );
       
       Contact con = TestDataGenerator.createContact('Test',acc);
       con.OwnerId =userlist[0].id; 
       insert con;
       System.debug('con '+con );
        
        List<SelectOption> sellist = new  List<SelectOption>();
        sellist.add(new SelectOption('Closed - Converted', 'Closed - Converted')); 
        //insert sellist;
        led.Status = 'Closed - Converted';
        update led;
        //Opportunity_SFDC__c  cosOpp =TestDataGenerator.createCustomOpportunity(led.Company,acc,userlist[0]); 
        //insert cosOpp;
       //Database.LeadConvert leadConvert = new database.LeadConvert(); 
       
       Test.startTest();
           Apexpages.currentPage().getparameters().put('Id',+led.id);  
           ApexPages.StandardController asp = new ApexPages.StandardController(led); 
           ConvertLeadController ConLead = new ConvertLeadController(asp);
          ConLead.sendOwnerEmail = false;
           ConLead.accountselectlist();
           ConLead.acc = acc;
           ConLead.contactID =null;
           ConLead.convertLeadRecord();
           ConLead.accountChanged();
           ConLead.cancelConvertLead();
           ConLead.con = con;
           ConLead.accountLookedUp();
           //ConLead.getLeadStatus(); 
           ConLead.getLeadStatusOption();
           ConLead.convertLeadRecord(); 
       Test.stopTest();
       */            
    }
}