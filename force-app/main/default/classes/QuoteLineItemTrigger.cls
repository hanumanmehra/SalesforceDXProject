public class QuoteLineItemTrigger
{
    /*trigger QuoteLineItemTrigger on QuoteLineItem (before insert,before update) 
{  
    if(!StopRecurssion.isProcessed)
    {
        StopRecurssion.isProcessed = true;
        list<QuoteLineItem > listqLineItem = trigger.New; 
        system.debug('Name listqLineItem::'+listqLineItem); 
        Set<Id> productIds= new Set<Id>();
        Set<Id> priceBookEntrySetIds= new Set<Id>();
        system.debug('Name listqLineItem1::'+listqLineItem);
        
        for(QuoteLineItem qLineItem: listqLineItem)
        {
           System.debug('qLineItem.PricebookEntryId'+qLineItem.PricebookEntryId);
            priceBookEntrySetIds.add(qLineItem.PricebookEntryId);
            
            if(Trigger.isInsert ||(Trigger.isUpdate && (qLineItem.Product2Id!= Trigger.oldMap.get(qLineItem.Id).Product2Id|| qLineItem.Quote!= trigger.oldMap.get(qLineItem.Id).Quote || qLineItem.UnitPrice != trigger.oldMap.get(qLineItem.Id).UnitPrice ))){
                system.debug('Name Product2Id::'+qLineItem.Product2Id);
                productIds.add(qLineItem.Product2Id);
                if(Trigger.isUpdate && qLineItem.Product2Id!= Trigger.oldMap.get(qLineItem.id).Product2Id)
                {
                    productIds.add(Trigger.oldMap.get(qLineItem.id).Product2Id);
                    System.debug('qLineItem.PricebookEntryId'+qLineItem.PricebookEntryId);
                }
                System.debug('productIds:::'+productIds+ 'priceBookEntrySetIds:::'+priceBookEntrySetIds);
            }
        }
        
        if(productIds.size() > 0 && priceBookEntrySetIds.size() >0)
        {
            
            List<QuoteLineItem> quoteLineItemToInsert =   new List<QuoteLineItem>();
            List<PricebookEntry> priceBookProductlist = [Select Name,Pricebook2.Name,ProductCode,Product2Id from PricebookEntry where Id In:priceBookEntrySetIds];
            System.debug('productlist :::'+priceBookProductlist );
            
             //List Of Custom setting object
            Map<String,PriceBookCustomSetting__c > mapOfRangeWiseCustomSetting =  new Map<String,PriceBookCustomSetting__c > ();
            List<PriceBookCustomSetting__c > priceBookCustomSetList = [Select Name,From_License__c,To_License__c,PriceBookType__c,  PartNumber_of_Pricebook__c,Sales_Price_Per_License__c from PriceBookCustomSetting__c];
           
            If(priceBookCustomSetList != null && priceBookCustomSetList.size() > 0 )
            {
                for(PriceBookCustomSetting__c  customset :priceBookCustomSetList )
                {
                    // if(mapOfRangeWiseCustomSetting.keyset().contains(customset.PartNumber_of_Pricebook__c))
                    mapOfRangeWiseCustomSetting.put(customset.PartNumber_of_Pricebook__c,customset  );
                }
                System.debug('mapOfRangeWiseCustomSetting:::'+mapOfRangeWiseCustomSetting);
            }
            
             
            if(priceBookProductlist  !=null && priceBookProductlist .size() >0)
            {
                for(PricebookEntry pbookentry : priceBookProductlist )
                {
                    for(QuoteLineItem  qcLineItem : listqLineItem)
                    {
                        
                        //System.debug('pbookentry.Id ::'+pbookentry.Id + 'qcLineItem .PricebookEntryId :: '+qcLineItem .PricebookEntryId +'part number'+pbookentry.ProductCode + 'Price book:::'+mapOfRangeWiseCustomSetting.get(pbookentry.ProductCode).PriceBookType__c);
                        if(pbookentry.Id == qcLineItem .PricebookEntryId && pbookentry.Pricebook2.Name == 'Government Price Book')
                        {
                            
                                if(qcLineItem.Quantity < 20)
                                {
                                    qcLineItem.UnitPrice = 102244.00;
                                }
                                
                                else if(qcLineItem.Quantity  >= 20 && qcLineItem.Quantity  < 30)
                                {
                                    qcLineItem.UnitPrice = 82188.00;
                                }
                                
                                else if(qcLineItem.Quantity  >= 30 && qcLineItem.Quantity  < 45)
                                {
                                    qcLineItem.UnitPrice = 68818.00;
                                }
                                
                                else if(qcLineItem.Quantity  >= 45 && qcLineItem.Quantity  < 70)
                                {
                                    qcLineItem.UnitPrice = 55447.00;
                                }
                                else if(qcLineItem.Quantity  >= 70  && qcLineItem.Quantity  < 95)
                                {
                                    qcLineItem.UnitPrice = 46088.00;
                                }
                                else if(qcLineItem.Quantity  >= 95 && qcLineItem.Quantity  < 120)
                                {
                                    qcLineItem.UnitPrice = 38066.00;
                                }
                                else if(qcLineItem.Quantity  >= 120 && qcLineItem.Quantity  < 145)
                                {
                                    qcLineItem.UnitPrice = 34054.00;
                                }
                                
                                else if(qcLineItem.Quantity  >= 145 && qcLineItem.Quantity  < 170)
                                {
                                    qcLineItem.UnitPrice = 30044.00;
                                }
                                
                                else if(qcLineItem.Quantity  >= 170 && qcLineItem.Quantity  < 195)
                                {
                                    qcLineItem.UnitPrice = 27235.00;
                                }
                                
                            
                                else if(qcLineItem.Quantity  >= 195 && qcLineItem.Quantity  < 495)
                                {
                                    qcLineItem.UnitPrice = 24695.00;
                                }
                                
                                else 
                                {
                                    qcLineItem.UnitPrice = 19347.00;
                                } 
                         }  
                    }  
                }
            }  
        } 
    } 
}*/
}