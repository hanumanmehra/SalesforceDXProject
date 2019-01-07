//@isTest(SeeAllData=true)
public Class  OpportunityProductSellPrice_test
{
   /* public static testMethod void opportunityProductUnitTest()
    {
        Account acc=  new Account();
        acc.Name='TestAccount';
        Insert acc;
        System.assertNotEquals(null,acc);
        
        Contact con = new Contact ();
        con.LastName='testcontact1';
        con.AccountId =acc.Id;
        insert con;
        System.assertNotEquals(null,con);
        
        //opportunity Record
        Opportunity opp = new Opportunity();
        opp.Name= 'TestOpportunity';
        opp.CloseDate =  System.today();
        opp.AccountId = acc.Id;
        opp.StageName = 'Qualification';
        insert opp;
        System.assertNotEquals(null,opp);
        
        Pricebook2 pricebook =  new Pricebook2();
        pricebook.Name= 'Government Price Book';
        pricebook.IsActive =true; 
        insert pricebook ;
        System.assertNotEquals(null,pricebook);
        
        Quote  qc = new Quote();
        qc.Name = 'TestQuoteOfTestopportunity'; 
        //qc.AccountId =acc.Id;
        qc.OpportunityId =  opp.Id;
        qc.ContactId = con.Id;
        qc.Pricebook2Id = pricebook.Id; 
        qc.Quote_Date__c =  System.Today();
        qc.Period_of_Performance_From__c =  System.Today();
        qc.Expiration_Date__c = '60 days';
        qc.Status= 'Draft';
        qc.Estimated_Delivery_Timeframe__c = '60 days';
        qc.Terms_and_Conditions__c ='customer reminds term and conditions';
        qc.Payment_Terms__c ='payment by cod and net banking';
        insert qc;
        System.assertNotEquals(null,qc);
        
        Product2 prod =  new Product2();
        prod.Name='Freestate Annual Subscriber License – Hosted - Named User';
        prod.ProductCode ='FS-NU-1-HOST';
        prod.IsActive = true;
        insert prod;
        System.assertNotEquals(null,prod);
        
        
        opp.Pricebook2Id =  Test.getStandardPricebookId();
        update opp;
        PricebookEntry pribookentryStd =  new PricebookEntry();
        
        pribookentryStd.Pricebook2Id =Test.getStandardPricebookId();
        pribookentryStd.Product2Id = prod.Id;
        pribookentryStd.UnitPrice = 102244.00;
        pribookentryStd.IsActive =  true;
        pribookentryStd.UseStandardPrice=False;
        insert pribookentryStd;
        System.assertNotEquals(null,pribookentryStd);
        
        PricebookEntry pribookentry =  new PricebookEntry();
        pribookentry.Pricebook2Id = pricebook.Id;
        pribookentry.Product2Id = prod.Id;
        pribookentry.UnitPrice = 112244.00;
        pribookentry.IsActive =  true;
        pribookentry.UseStandardPrice=FALSE;
        insert pribookentry;
        System.assertNotEquals(null,pribookentry);
        
        Discount_Matrix__c dcmat = new Discount_Matrix__c();
        dcmat.Min_Range__c =1;
        dcmat.Max_Range__c =  20;
        dcmat.PriceBook_Type__c = 'Government Price Book';
        dcmat.Sale_Price__c=72205;
        dcmat.Product__c= prod.Id;
        insert dcmat;
        System.assertNotEquals(null,dcmat);
        
        QuoteLineItem qcLintitem  =  new QuoteLineItem();
        qcLintitem.Quantity = 10;
        qcLintitem.UnitPrice = dcmat.Sale_Price__c;
        qcLintitem.QuoteId = qc.id;
        qcLintitem.Product2Id= prod.Id;
        qcLintitem.PricebookEntryId= pribookentry.Id;
        insert qcLintitem;
        System.assertNotEquals(null,qcLintitem);
        
        Test.startTest();
            Apexpages.currentPage().getparameters().put('Id',+qc.id);  
            ApexPages.StandardController asp = new ApexPages.StandardController(qc);
            OpportunityProductSellPriceController oppProduct = new OpportunityProductSellPriceController(asp); 
            
            oppProduct.qouteId = qc.id;
            oppProduct.selectProductField ='Name' ;
            oppProduct.selPriceBook = 'Government Price Book';
            oppProduct.fiterFieldOfProduct ='Freestate Annual Subscriber License – Hosted - Named User';
            
            
            oppProduct.getselectPriceBook(); 
            oppProduct.getItems();
            //oppProduct.SelectedPriceBook();
            oppProduct.getFieldName();
            oppProduct.SelPriceBookNext();
            oppProduct.setselectPriceBook(oppProduct.selPriceBook);
            oppProduct.productWrapperList[0]. isCheck =true;
            oppProduct.selectedProduct();
            oppProduct.ProductToSelectedList[0].quantity=10;
            oppProduct.ProductToSelectedList[0].salesprice = 20000;
            oppProduct.saveRecord();
            oppProduct.cancelRecord();
            oppProduct.cancelProduct(); 
            OpportunityProductSellPriceController.sellpriceMatrixList('10', prod.Id, oppProduct.selPriceBook);
        Test.stopTest();    
    }
    
    public static testMethod void opportunityProductUnitTest2()
    {
        Account acc=  new Account();
        acc.Name='TestAccount2';
        Insert acc;
        System.assertNotEquals(null,acc);
        
        Contact con = new Contact ();
        con.LastName='testcontact2';
        con.AccountId =acc.Id;
        insert con;
        System.assertNotEquals(null,con);
        
        //opportunity Record
        Opportunity opp = new Opportunity();
        opp.Name= 'TestOpportunity2';
        opp.CloseDate =  System.today();
        opp.AccountId = acc.Id;
        opp.StageName = 'Qualification';
        insert opp;
        System.assertNotEquals(null,opp);
        
        Pricebook2 pricebook =  new Pricebook2();
        pricebook.Name= 'Commerical Price Book';
        pricebook.IsActive =true; 
        insert pricebook ;
        System.assertNotEquals(null,pricebook);
        
        Quote  qc = new Quote();
        qc.Name = 'TestQuoteOfTestopportunity2'; 
        //qc.AccountId =acc.Id;
        qc.OpportunityId =  opp.Id;
        qc.ContactId = con.Id;
        qc.Pricebook2Id = pricebook.Id; 
        qc.Quote_Date__c =  System.Today();
        qc.Period_of_Performance_From__c =  System.Today();
        qc.Expiration_Date__c = '60 days';
        qc.Status= 'Draft';
        qc.Estimated_Delivery_Timeframe__c = '60 days';
        qc.Terms_and_Conditions__c ='customer reminds term and conditions';
        qc.Payment_Terms__c ='payment by cod and net banking';
        insert qc;
       System.assertNotEquals(null,qc);
        List<Product2> productlist =  new List<Product2>();
        Product2 prod =  new Product2();
        prod.Name='Freestate Annual Subscriber License – Hosted - Named User';
        prod.ProductCode ='FS-NU-1-HOST';
        prod.IsActive = true;
        //insert prod;
        //System.assertNotEquals(null,prod);
        productlist.add(prod);      
       
        Product2 prod2 =  new Product2();
        prod2.Name='Freestate Annual Subscriber License – Hosted - Named User';
        prod2.ProductCode ='FS-NU-1-HOST';
        prod2.IsActive = true;
        productlist.add(prod2);
        insert productlist;
        //System.assertNotEquals(null,prod2);
        
        
        opp.Pricebook2Id =  Test.getStandardPricebookId();
        update opp;
        PricebookEntry pribookentryStd =  new PricebookEntry();
        
        pribookentryStd.Pricebook2Id =Test.getStandardPricebookId();
        pribookentryStd.Product2Id = prod.Id;
        pribookentryStd.UnitPrice = 104244.00;
        pribookentryStd.IsActive =  true;
        pribookentryStd.UseStandardPrice=False;
        insert pribookentryStd;
        System.assertNotEquals(null,pribookentryStd);
        
        PricebookEntry pribookentry =  new PricebookEntry();
        pribookentry.Pricebook2Id = pricebook.Id;
        pribookentry.Product2Id = prod.Id;
        pribookentry.UnitPrice = 112344.00;
        pribookentry.IsActive =  true;
        pribookentry.UseStandardPrice=FALSE;
        insert pribookentry;
        System.assertNotEquals(null,pribookentry);
        
        Discount_Matrix__c dcmat = new Discount_Matrix__c();
        dcmat.Min_Range__c =1;
        dcmat.Max_Range__c =  20;
        dcmat.PriceBook_Type__c = 'Commercial Price Book';
        dcmat.Sale_Price__c=76205;
        dcmat.Product__c= prod.Id;
        insert dcmat;
        System.assertNotEquals(null,dcmat);
        
        QuoteLineItem qcLintitem  =  new QuoteLineItem();
        qcLintitem.Quantity = 10;
        qcLintitem.UnitPrice = dcmat.Sale_Price__c;
        qcLintitem.QuoteId = qc.id;
        qcLintitem.Product2Id= prod.Id;
        qcLintitem.PricebookEntryId= pribookentry.Id;
        insert qcLintitem;
        System.assertNotEquals(null,qcLintitem);
        
        Test.startTest();
            Apexpages.currentPage().getparameters().put('Id',+qc.id);  
            ApexPages.StandardController asp2 = new ApexPages.StandardController(qc);
            OpportunityProductSellPriceController oppProduct2 = new OpportunityProductSellPriceController(asp2); 
            
            oppProduct2.qouteId = qc.id;
            
            oppProduct2.selPriceBook = '';
            oppProduct2.getselectPriceBook(); 
            oppProduct2.getItems();
            oppProduct2.SelectedPriceBook();
        Test.stopTest();    
    }*/
}