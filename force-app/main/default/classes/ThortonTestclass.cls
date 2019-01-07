public Class ThortonTestclass
{
    /*@Istest
    public Class NewFeeProposalController_Test
    {
        public Static testMethod void feeProposal()
        {
            List<RecordType> recordTypes = [SELECT Id,Name FROM RecordType WHERE IsActive=true AND SobjectType='Contact' AND (Name='Employee Record Type')]; 
            System.debug('recordTypes :: '+recordTypes);
            if(recordTypes!= null && !recordTypes.isEmpty())
            {
            Profile testProfile = [SELECT Id FROM profile WHERE Name = 'System Administrator' LIMIT 1];
            List<User> userlist  = new List<User>();
            User usr = TestDataGenerator.createUser('testuser', 'atest1','test1@gmail.com','leadsitest@demo.com','atest1',testProfile ,'America/Los_Angeles','en_US','UTF-8','en_US');
            userlist.add(usr);
            insert userlist;
            System.assertNotEquals(null,userlist);
            
            
            Account acc=TestDataGenerator.createAccount('TestAccount');
            insert acc;
            System.assertNotEquals(null,acc);
            
            Contact con =TestDataGenerator.createContact ('TestContact',acc); 
            con.RecordTypeId =recordTypes[0].Id; 
            insert con;
            System.assertNotEquals(null,con);
            
            Opportunity__c oppor = TestDataGenerator.createOpportunity('TestOpportunity',acc,con,'lost',Date.Today(),5000,userlist[0],Date.Today(),Date.Today(),'Los Angles','Applied Science','Aviation'); 
            System.debug('oppor::'+oppor);
            insert oppor;
            System.assertNotEquals(null,oppor);
            
            product2 product =TestDataGenerator.createProduct('test Product','ahshbhdc'); 
            insert product;
            System.assertNotEquals(null,product);
             
            Pricebook2  pricebook = TestDataGenerator.createPriceBook('Standard Price Book');
            insert pricebook; 
            System.assertNotEquals(null,pricebook);
            
            PricebookEntry  pbentry = TestDataGenerator.createPriceBookEntry(product,2000.00);
            pbentry.Pricebook2Id =Test.getStandardPricebookId();
            //pbentry.Pricebook2.Name ='Standard Price Book';
            insert pbentry;
            System.assertNotEquals(null,pbentry);
            
            PricebookEntry  pbentry1 = TestDataGenerator.createPriceBookEntry(product,2000.00);
            pbentry1.Pricebook2Id =pricebook.Id;
            System.debug('pbentry2'+pbentry1);
            insert pbentry1;
            System.assertNotEquals(null,pbentry1);
            
            Proposal__c  prop = TestDataGenerator.createProposal('TestProposal',oppor);
            insert prop;
            System.assertNotEquals(null,prop);
            
            
            Test.startTest();
             Apexpages.currentPage().getparameters().put('Id',+oppor.id);  
             ApexPages.StandardController asp = new ApexPages.StandardController(oppor); 
             NewFeeProposalController  newFeeprop = new NewFeeProposalController (asp );
             newFeeprop.addRow();
             newFeeprop.ProposalLineItems[0].salesprice = 100.00;
             newFeeprop.ProposalLineItems[1].salesprice = 200.00;
             newFeeprop.SavePage();
             NewFeeProposalController.startSync(prop.Id);
            NewFeeProposalController.stopSync(prop.Id);
             newFeeprop.Cancel();
            Test.stopTest();
            }
        }
    }*/
    
    /*
    @istest
Public Class NewOpportunityTeamController_Test
{
   public Static testMethod void feeProposal()
   {
       List<RecordType> recordTypes = [SELECT Id,Name FROM RecordType WHERE IsActive=true AND SobjectType='Contact' AND (Name='Employee Record Type')]; 
       System.debug('recordTypes :: '+recordTypes);
       if(recordTypes!= null && !recordTypes.isEmpty())
       {
           Profile testProfile = [SELECT Id FROM profile WHERE Name = 'System Administrator' LIMIT 1];
           List<User> userlist  = new List<User>();
           User usr = TestDataGenerator.createUser('testuser', 'atest1','test1@gmail.com','leadsitest@demo.com','atest1',testProfile ,'America/Los_Angeles','en_US','UTF-8','en_US');
           userlist.add(usr);
           insert userlist;
           System.assertNotEquals(null,userlist);
           
           Account acc=TestDataGenerator.createAccount('TestAccount');
           insert acc;
           System.assertNotEquals(null,acc);
           
           Contact con =TestDataGenerator.createContact ('TestContact',acc); 
           con.RecordTypeId =recordTypes[0].Id; 
           insert con;
           System.assertNotEquals(null,con);
           
           Opportunity__c oppor = TestDataGenerator.createOpportunity('TestOpportunity',acc,con,'lost',Date.Today(),5000,userlist[0],Date.Today(),Date.Today(),'Los Angles','Applied Science','Aviation'); 
           insert oppor;
           System.assertNotEquals(null,oppor);
           
           Opportunity_Team__c opportunityTeam =  TestDataGenerator.createOpportunityTeam(userlist[0],con,oppor,'Coordinator','None'); 
           insert opportunityteam;
           System.assertNotEquals(null,opportunityteam);
           
           Test.startTest();
           Apexpages.currentPage().getparameters().put('Id',+oppor.id);  
           ApexPages.StandardController asp = new ApexPages.StandardController(oppor); 
           NewOpportunityTeamController  newOppTeam = new NewOpportunityTeamController (asp );
           newOppTeam.addRow();
           newOppTeam.SavePage();
           newOppTeam.getstagePicklistvalue();
           newOppTeam.getopportunityAccess();
           newOppTeam.Cancel();
           Test.stopTest();
       }  
   }*/
   
   /*
   @istest
Public Class NewOpportunityTeamController_Test
{
   public Static testMethod void feeProposal()
   {
       List<RecordType> recordTypes = [SELECT Id,Name FROM RecordType WHERE IsActive=true AND SobjectType='Contact' AND (Name='Employee Record Type')]; 
       System.debug('recordTypes :: '+recordTypes);
       if(recordTypes!= null && !recordTypes.isEmpty())
       {
           Profile testProfile = [SELECT Id FROM profile WHERE Name = 'System Administrator' LIMIT 1];
           List<User> userlist  = new List<User>();
           User usr = TestDataGenerator.createUser('testuser', 'atest1','test1@gmail.com','leadsitest@demo.com','atest1',testProfile ,'America/Los_Angeles','en_US','UTF-8','en_US');
           userlist.add(usr);
           insert userlist;
           System.assertNotEquals(null,userlist);
           
           Account acc=TestDataGenerator.createAccount('TestAccount');
           insert acc;
           System.assertNotEquals(null,acc);
           
           Contact con =TestDataGenerator.createContact ('TestContact',acc); 
           con.RecordTypeId =recordTypes[0].Id; 
           insert con;
           System.assertNotEquals(null,con);
           
           Opportunity__c oppor = TestDataGenerator.createOpportunity('TestOpportunity',acc,con,'lost',Date.Today(),5000,userlist[0],Date.Today(),Date.Today(),'Los Angles','Applied Science','Aviation'); 
           insert oppor;
           System.assertNotEquals(null,oppor);
           
           Opportunity_Team__c opportunityTeam =  TestDataGenerator.createOpportunityTeam(userlist[0],con,oppor,'Coordinator','None'); 
           insert opportunityteam;
           System.assertNotEquals(null,opportunityteam);
           
           Test.startTest();
           Apexpages.currentPage().getparameters().put('Id',+oppor.id);  
           ApexPages.StandardController asp = new ApexPages.StandardController(oppor); 
           NewOpportunityTeamController  newOppTeam = new NewOpportunityTeamController (asp );
           newOppTeam.addRow();
           newOppTeam.SavePage();
           newOppTeam.getstagePicklistvalue();
           newOppTeam.getopportunityAccess();
           newOppTeam.Cancel();
           Test.stopTest();
       }  
   }*/
   
   /*
   @isTest
public class EditAllProposalLineItemController_Test 
{
    public Static testMethod void editAllProposalLine()
    {
        List<RecordType> recordTypes = [SELECT Id,Name FROM RecordType WHERE IsActive=true AND SobjectType='Contact' AND (Name='Employee Record Type')]; 
        System.debug('recordTypes :: '+recordTypes);
        if(recordTypes!= null && !recordTypes.isEmpty())
        {
            Profile testProfile = [SELECT Id FROM profile WHERE Name = 'System Administrator' LIMIT 1];
            List<User> userlist  = new List<User>();
            User usr = TestDataGenerator.createUser('testuser', 'atest1','test1@gmail.com','leadsitest@demo.com','atest1',testProfile ,'America/Los_Angeles','en_US','UTF-8','en_US');
            userlist.add(usr);
            insert userlist;
            System.assertNotEquals(null,userlist);
            
            Account acc=TestDataGenerator.createAccount('TestAccount');
            insert acc;
            System.assertNotEquals(null,acc);
            
            Contact con =TestDataGenerator.createContact ('TestContact',acc); 
            con.RecordTypeId =recordTypes[0].Id;  
            insert con;
            System.assertNotEquals(null,con);
            
            Opportunity__c oppor = TestDataGenerator.createOpportunity('TestOpportunity',acc,con,'lost',Date.Today(),5000,userlist[0],Date.Today(),Date.Today(),'Los Angles','Applied Science','Aviation'); 
            insert oppor;
            System.assertNotEquals(null,oppor);
            
            product2 product =TestDataGenerator.createProduct('test Product','ahshbhdc'); 
            insert product;
            System.assertNotEquals(null,product);
             
            Pricebook2  pricebook = TestDataGenerator.createPriceBook('Standard Price Book');
            insert pricebook; 
            System.assertNotEquals(null,pricebook);
            PricebookEntry  pbentry = TestDataGenerator.createPriceBookEntry(product,2000.00);
            pbentry.Pricebook2Id =Test.getStandardPricebookId();
            //pbentry.Pricebook2.Name ='Standard Price Book';
            insert pbentry;
            System.assertNotEquals(null,pbentry);
            
            PricebookEntry  pbentry1 = TestDataGenerator.createPriceBookEntry(product,2000.00);
            pbentry1.Pricebook2Id =pricebook.Id;
            insert pbentry1;
            System.assertNotEquals(null,pbentry1);
            
            Proposal__c  prop = TestDataGenerator.createProposal('TestProposal',oppor);
            insert prop;
            System.assertNotEquals(null,prop);
            
            List<Proposal_Line_Items__c> proposallineList = new  List<Proposal_Line_Items__c>(); 
            Proposal_Line_Items__c proposalLineItem = TestDataGenerator.createProposalLineItem('Testing',prop,2500.00);
            proposallineList.add(proposalLineItem);
            Proposal_Line_Items__c proposalLineItem2 = TestDataGenerator.createProposalLineItem('Testing for testcls',prop,3500.00);
            proposallineList.add(proposalLineItem2);
            Proposal_Line_Items__c proposalLineItem3 = TestDataGenerator.createProposalLineItem('Testing for testcls data',prop,4500.00);
            proposallineList.add(proposalLineItem3);
            insert proposallineList;
            System.assertNotEquals(null,proposallineList);
            
            Test.startTest();
             Apexpages.currentPage().getparameters().put('Id',+prop.id);  
             ApexPages.StandardController asp = new ApexPages.StandardController(prop); 
             EditAllProposalLineItemController  newFeepropLine = new EditAllProposalLineItemController (asp);
             //newFeeprop.addRow();
             newFeepropLine.SavePage(); 
             newFeepropLine.Cancel();
            Test.stopTest();
        }
    }

}
}
}*/
}