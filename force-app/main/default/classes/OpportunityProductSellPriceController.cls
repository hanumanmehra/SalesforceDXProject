public Class OpportunityProductSellPriceController
{
    /*public String selPriceBook;
    public String pricebookentryId{get;set;}
    public String pricebookName{get;set;}
    public String selectProductField{get;set;}
    public List<Pricebook2> priceBookList;
    public List<selctedProductWrapper> productToSelectedList{get;set;}
    public String qouteId;
    public Quote quoteRecord;
    
    public List<Product2> productList{get;set;}
    public List<productWrapper> productWrapperList{get;set;}
    
    public String fiterFieldOfProduct{get;set;}
    
    //constructor
    public OpportunityProductSellPriceController(ApexPages.StandardController controller) 
    {
        pricebookentryId= '';
        qouteId = controller.getId();
        quoteRecord =  new Quote ();
  
        priceBookList = new List<Pricebook2>();
        productList =  new List<Product2>();
        productWrapperList = new List<productWrapper>();
        ProductToSelectedList = new List<selctedProductWrapper>();
        
        priceBookList = [Select Name,Price_Book_Name__c,IsActive from Pricebook2 where   IsActive =true ];
        quoteRecord = [Select Name,Pricebook2Id,Pricebook2.Name,OpportunityId,(select Id,PricebookEntryId from QuoteLineItems) from Quote Where Id =:qouteId];
        
        //System.debug('quoteRecord'+quoteRecord);
        if(quoteRecord.Pricebook2Id != null)
        {
              pricebookName=quoteRecord.Pricebook2.Name;   
        }
        
        //System.debug('pricebookName ::'+pricebookName);
        if(pricebookName == null)
        {
           System.debug('We are in if condition');
           getItems();
        }
        else
        {
           selPriceBook =pricebookName;
           SelPriceBookNext();
        }
    }
     
    public String getselectPriceBook()
    {
        return selPriceBook;
    }
    
    public  void setselectPriceBook( String selPriceBook)  
    {
        this.selPriceBook= selPriceBook;
    }
    
    //get method for list SelectOptions of Sobject
    public List<SelectOption> getItems() 
    { 
        List<SelectOption> selectlist = new List<SelectOption>();
        if(priceBookList != null && priceBookList.size() >0)
        {
            for(Pricebook2 pbook: priceBookList)
            {
                    System.debug('Price book:::'+pbook.Name);
                    selectlist.add(new SelectOption(pbook.Name,pbook.Name));
            }
            //System.debug('selectlist:::'+selectlist);
        }
        return selectlist;  
    }
    
    // Method for Selected Price Book 
    public PageReference SelectedPriceBook()
    {
        Opportunity oppList = [Select Id,Name,Pricebook2Id from Opportunity Where Id =:quoteRecord.OpportunityId];
        if(priceBookList != null && priceBookList.size() >0)
        {
           for(Pricebook2 pb :priceBookList )
           {
               if(pb.Name == selPriceBook)
               {
                   oppList.Pricebook2Id =pb.Id; 
                   quoteRecord.Pricebook2Id = pb.Id;  
                   pricebookName = pb.Name;  
               }
           }
           update quoteRecord;
           update oppList ;
        }
        PageReference page = new Pagereference('/apex/OpportunityProductSellPrice?id='+qouteId);
        page.setRedirect(true);
        return page;    
    } 
    
    //SelectList for filter field
    public List<SelectOption> getFieldName() 
    { 
        List<SelectOption> selectlist = new List<SelectOption>();
        selectlist.add(new SelectOption('Name','Product Name'));
        selectlist.add(new SelectOption('ProductCode','Part Number'));
        return selectlist;  
    }
    
    //Method For get all records of  product according to selected price book
    public void SelPriceBookNext()
    {
        try
        {
            productWrapperList = new List<productWrapper>();
            String querystr='';
            
            if(fiterFieldOfProduct != null && fiterFieldOfProduct !='')
            {
                String field = fiterFieldOfProduct + '%';
                string tempInput = ' '+selectProductField+ ' LIKE  \'' +field + '\''  ;
    
                querystr = 'Select Name,ProductCode,IsActive,Description from Product2 where'+ tempInput + ' And ' +'Id In (Select Product2Id from PricebookEntry where Pricebook2.Name =\''+selPriceBook+'\')'+'AND IsActive = true'+' Limit 1000';
                //System.debug('querystr ::::'+querystr);
                productList  =  Database.query(querystr) ;
            }
            else
            {
                productList =  Database.query('Select Name,ProductCode,IsActive,Description from Product2 where Id In (Select Product2Id from PricebookEntry where Pricebook2.Name =:selPriceBook) AND IsActive = true  Limit 1000');
                //System.debug('querystr in else part ::::'+productList );
            }
            
            if(productList != null && productList.size() >0)
            {
                for(Product2  pd: productList)
                {
                    productWrapper pdwrap = new productWrapper();
                    pdwrap.prod =pd;
                    productWrapperList.add(pdwrap);
                }
                //System.debug('productWrapperList::::'+productWrapperList);
            }
        } 
         catch(exception e)
        {
            System.debug('Error message '+e.getmessage());
        }   
    }
    
    //Method for Selected Product for Quote line Item
    public void selectedProduct()
    {
        if(productWrapperList != null && productWrapperList.size() >0)
        {
            for(productWrapper mod : productWrapperList)
            {
                if(mod.isCheck)
                {
                   selctedProductWrapper selwrap = new selctedProductWrapper();
                   selwrap.produ=mod.prod;
                   selwrap.selPriceBook = pricebookName != null ? pricebookName : selPriceBook;
                   ProductToSelectedList.add(selwrap); 
                }
            }
        }
        //System.debug('ProductToSelected  :::'+ProductToSelectedList);    
    }
    
    // Remote use for the salesPrice
    @RemoteAction
    public Static List<Discount_Matrix__c> sellpriceMatrixList(String st,String productId,String priceBook)
    {
        Integer quantityOflineProduct =  Integer.valueof(st);
        List<Discount_Matrix__c> matrixList = [Select Name,Min_Range__c,Max_Range__c,Sale_Price__c,PriceBook_Type__c,Product__c from Discount_Matrix__c where Product__c =:productId AND (Min_Range__c  <=:quantityOflineProduct  AND (Max_Range__c >=:quantityOflineProduct OR Max_Range__c =null) AND PriceBook_Type__c=:priceBook) ];
        System.debug('matrixList ' +matrixList);
        return matrixList ;
    }
    
    //save record of Quote lineitem
    
    public PageReference saveRecord()
    {
        try
        {
            List<PricebookEntry>  pricebookentryList;
            Opportunity oppList;
            map<String,PricebookEntry> mapOfPriceBookEntry = new map<String,PricebookEntry>();
            list<QuoteLineItem> quoteLineItemList =  new list<QuoteLineItem>();
            //System.debug('quoteRecord.Pricebook2Id ::'+quoteRecord.Pricebook2Id);
            
            if(quoteRecord.Pricebook2Id != null)
            {
                pricebookentryList  = [Select Id ,Name,Product2Id,Pricebook2Id from PricebookEntry where Pricebook2Id=: quoteRecord.Pricebook2Id] ;
                //System.debug('pricebookentryList  in If'+pricebookentryList);
            }
            else
            {
                pricebookentryList  = [Select Id ,Name,Product2Id,Pricebook2.Name,Pricebook2.Id from PricebookEntry where Pricebook2.Name =:selPriceBook] ;
       
            }
            
            if(pricebookentryList  != null && pricebookentryList.Size() >0 )
            {
                for(PricebookEntry  pc : pricebookentryList)
                {
                    mapOfPriceBookEntry.put(pc.Product2Id,pc);
                }
            }
            
            //Add new qouteLineItems
            for(selctedProductWrapper selprod : ProductToSelectedList)
            {
                QuoteLineItem qcLintitem  =  new QuoteLineItem();
                if(selprod.quantity != 0 && selprod.salesprice !=0.00)
                {
                    qcLintitem.Quantity = selprod.quantity;
                    qcLintitem.UnitPrice = selprod.salesprice;
                    qcLintitem.QuoteId = qouteId;
                    qcLintitem.Product2Id= selprod.produ.Id;
                    qcLintitem.PricebookEntryId= mapOfPriceBookEntry.get(selprod.produ.Id).Id;
                    quoteLineItemList.add(qcLintitem);
                }
            }
            
            //System.debug('quoteLineItemList'+quoteLineItemList);
            if(quoteLineItemList != null && quoteLineItemList.size() >0)
            {
                insert quoteLineItemList;
            }
        }
        
        catch(exception e)
        {
            System.debug('Error message '+e.getmessage());
        }
        
        PageReference page = new Pagereference('/'+qouteId);
        page.setRedirect(true);
        return page;
    }
    
    //method  for Cancel Button 
    public PageReference cancelRecord()
    {
       PageReference page = new Pagereference('/'+qouteId);
       page.setRedirect(true);
       
       return page; 
    }
    
    public PageReference cancelProduct()
    {
       PageReference page = new Pagereference('/'+qouteId);
       page.setRedirect(true);
       return page; 
    }
    
    //Wrapper class For Product with checkboxes
    public Class productWrapper
    {
        public Product2  prod{get;set;}
        public Boolean isCheck{get;set;}
        
        public productWrapper()
        {
            prod = new Product2();
            isCheck = false;
        }
    }
    
    //Wrapper class For selected Product binds with Pricebook,quantity and salesprice
    public Class selctedProductWrapper
    {
        public Product2 produ{get;set;}
        public Integer quantity{get;set;}
        public Decimal salesprice{get;set;}
        public String selPriceBook{get;set;}
        
        public selctedProductWrapper ()
        {
            produ= new Product2 ();
            quantity = 0;
            salesprice =0.00; 
            selPriceBook='';
        }
    }*/
}