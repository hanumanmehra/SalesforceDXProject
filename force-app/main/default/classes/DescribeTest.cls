@isTest
public with sharing class DescribeTest 
    { 
    public static testMethod void SobjectTest() 
    {
        Test.startTest();
        
        Account ac = new Account();
        ac.Name='anuj';
        ac.AccountNumber = 'Cdgsghdhhd232';
        ac.Active__c = 'yes';
        ac.BillingCity = 'Jaipur';
        ac.BillingCountry = 'India';
        //ac.Phone = 45856516263;
        insert ac;
        
        Contact con = new Contact();
        con.AssistantName ='shivendra';
        con.Birthdate =Date.Today();
        con.Email= 'Hanumankahar@gmail.com';
        //con.IsDeleted = false;
        con.FirstName = 'Hanuman';
        con.LastName = 'Mehra';
        insert con;
        
        
        
            
        DescribeSobject obj = new DescribeSobject();
        obj.selobject = 'Account';  
        //obj.selectobject();
        obj.getselectobject();
        obj.setselectobject('Account'); 
        obj.fieldsOfObject();
        List<String> selfieldsList = new List<String> ();
            selfieldsList.add('Name');
            selfieldsList.add('AccountNumber');
            selfieldsList.add('Active__c');
        obj.selfields=selfieldsList;
        obj.getselectfields();
        obj.setselectfields(selfieldsList);
        
        obj.getItems();
        obj.getfieldItems();
        obj.inputvalue = 'c';
        
        List<SObject> searchlst =  new List<SObject>();
        
        Account ac1 = new Account();
        ac1.Name='chethan';
        ac1.AccountNumber = 'Cdhhdhdhd';
        ac1.Active__c = 'yes';
        
        Account ac2 = new Account();
        ac2.Name='chinku';
        ac2.AccountNumber = 'cfgsgsdhsh';
        ac2.Active__c = 'yes';
        searchlst.add(ac1);
        searchlst.add(ac2);
        insert searchlst;
        
        obj.Iselect = false;
        obj.inputmethod(); 
        
        //obj.selfieldsofobj();
        
        //obj.getItems();
        Test.stopTest();
        
    }
    
    public static testMethod void SobjectTest2() 
    {
        Test.startTest();
        
        Account ac = new Account();
        ac.Name='anuj';
        ac.AccountNumber = 'Cdgsghdhhd232';
        ac.Active__c = 'yes';
        ac.BillingCity = 'Jaipur';
        ac.BillingCountry = 'India';
        //ac.Phone = 45856516263;
        insert ac;
        
        Contact con = new Contact();
        con.AssistantName ='shivendra';
        con.Birthdate =Date.Today();
        con.Email= 'Hanumankahar@gmail.com';
        //con.IsDeleted = false;
        con.FirstName = 'Hanuman';
        con.LastName = 'Mehra';
        insert con;
            
        DescribeSobject obj = new DescribeSobject();
        obj.selobject = 'None';  
        //obj.selectobject();
        List<String> selfieldsList = new List<String> ();
        
        obj.selfields=selfieldsList;
        obj.getselectfields();
        obj.setselectfields(selfieldsList);
        //obj.fieldsOfObject();
        obj.getselectobject();
        obj.setselectobject('None'); 
        Test.stopTest();
        
    }
    
    public static testMethod void SobjectTest3() 
    {
        Test.startTest();
        
        Account ac = new Account();
        ac.Name='anuj';
        ac.AccountNumber = 'Cdgsghdhhd232';
        ac.Active__c = 'yes';
        ac.BillingCity = 'Jaipur';
        ac.BillingCountry = 'India';
        //ac.Phone = 45856516263;
        insert ac;
        
        Contact con = new Contact();
        con.AssistantName ='shivendra';
        con.Birthdate =Date.Today();
        con.Email= 'Hanumankahar@gmail.com';
        //con.IsDeleted = false;
        con.FirstName = 'Hanuman';
        con.LastName = 'Mehra';
        insert con;
        
        Case cs = new Case();
        //cs.CaseNumber= '000098788';
        //cs.LastModifiedDate = date.today();
        cs.Priority = 'high';
        cs.Status = 'Closed';
        //con.IsDeleted = false;
        //con.FirstName = 'Hanuman';
        //con.LastName = 'Mehra';
        insert cs;
        
        
            
        DescribeSobject obj = new DescribeSobject();
        obj.selobject = 'case';  
        //obj.selectobject();
        List<String> selfieldsList = new List<String> ();
            selfieldsList.add('Priority');
            selfieldsList.add('Status');
            //selfieldsList.add('Active__c');
        //obj.selfields=selfieldsList;
        obj.getselectfields();
        obj.setselectfields(selfieldsList);
        obj.fieldsOfObject();
        obj.getselectobject();
        obj.setselectobject('Case'); 
        obj.getItems();
        obj.getfieldItems();
        obj.inputvalue = 'c';
        
        List<SObject> searchlst =  new List<SObject>();
        
        Account ac1 = new Account();
        ac1.Name='chethan';
        ac1.AccountNumber = 'Cdhhdhdhd';
        ac1.Active__c = 'yes';
        
        Account ac2 = new Account();
        ac2.Name='chinku';
        ac2.AccountNumber = 'cfgsgsdhsh';
        ac2.Active__c = 'yes';
        searchlst.add(ac1);
        searchlst.add(ac2);
        insert searchlst;
        
        obj.Iselect = false;
        obj.inputmethod(); 
        
        //obj.selfieldsofobj();
        //obj.getItems();
        Test.stopTest();
        
    }
    
    

}