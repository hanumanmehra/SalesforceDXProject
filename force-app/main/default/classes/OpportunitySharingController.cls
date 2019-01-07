Public class  OpportunitySharingController{
    /*public List<Opportunity_SFDC__Share> allShareOppootunityList {get;set;}
    
    public OpportunitySharingController(ApexPages.StandardController contrl){
         allShareOppootunityList  =  new  List<Opportunity_SFDC__Share>();
         String oppId = contrl.getId();
         if(oppId  != null)
         allShareOppootunityList =  [SELECT Id,AccessLevel,UserOrGroupId,UserOrGroup.Name,UserOrGroup.Type,ParentId,RowCause FROM Opportunity_SFDC__Share WHERE ParentId =: oppId ];
         System.debug('allShareOppootunityList ::::::::'+allShareOppootunityList);
    }*/
    
    /*Test class*/
    /*@IsTest
public class OpportunitySharingController_Test {
    public Static testMethod void  opportunitySharing() {
        Profile testProfile = [SELECT Id FROM profile WHERE Name = 'System Administrator' LIMIT 1];
        List<User> userlist  = new List<User>();
        User usr = TestDataGenerator.createUser('testuser', 'atest1','test1@gmail.com','leadsitest@demo.com','atest1',testProfile ,'America/Los_Angeles','en_US','UTF-8','en_US');
        userlist.add(usr);
        User usr2 = TestDataGenerator.createUser('testuser2', 'atest2','test2@gmail.com','leadsitest2@demo.com','atest2',testProfile ,'GMT','en_US','UTF-8','en_US');
        userlist.add(usr2);
        insert  userlist;
        //System.assert(null,usr);
       System.debug('Userlist'+userlist+ 'user1'+userlist[0]);
       
       Account acc = TestDataGenerator.createAccount('Test Acccount'); 
       insert acc;       
       Contact con = TestDataGenerator.createContact('Test',acc);
       con.OwnerId =userlist[0].id; 
       insert con;
       
       Opportunity_SFDC__c  cosOpp =TestDataGenerator.createOppSFDC('Test opportunnity',acc,'Prospecting',Date.today().addmonths(5)); 
        insert cosOpp;
       
        Test.startTest();
               Apexpages.currentPage().getparameters().put('Id',+cosOpp .id);  
               ApexPages.StandardController asp = new ApexPages.StandardController(cosOpp ); 
               OpportunitySharingController oppSahre = new OpportunitySharingController(asp );
        Test.StopTest();
    }
}*/
}