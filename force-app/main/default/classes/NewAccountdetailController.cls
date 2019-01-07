public Class NewAccountdetailController
{
    public Map<String,Integer> mapOfRelatedObject{get;set;}
    public List<Account> accountlist{get;set;}
    public NewAccountdetailController(ApexPages.StandardController controller)
    { 
        mapOfRelatedObject =  new Map<String,Integer>();
        accountlist =  new List<Account>();
        accountlist =[Select id, Name,(Select Id ,Name From Contacts),(Select Id,Name From opportunities),(Select Id from Cases) From Account where Id =:controller.getId()];
        if(accountlist != null && accountlist.size() >0)
        {
            System.debug('accountlist ::'+accountlist  +'Contactlist::'+accountlist[0].Contacts.size()+'Opportunities::'+accountlist[0].Opportunities.size());
            mapOfRelatedObject.put('Contacts',accountlist[0].Contacts.size());
            mapOfRelatedObject.put('Opportunities',accountlist[0].Opportunities.size());
            mapOfRelatedObject.put('Cases',accountlist[0].Cases.size());
        }
    }
    
    public PageReference CancelData(){
        PageReference pg;  
        pg = new PageReference('/0062800000DMUkD');
        pg.setRedirect(true);
 
      return pg;
        
    } 
}