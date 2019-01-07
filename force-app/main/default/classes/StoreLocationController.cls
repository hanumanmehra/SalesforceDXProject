public with sharing class StoreLocationController
{
    public  Store_Location__c slc ;
    public String stringofNear{get;set;}
    public Integer selectDistance{get;set;}
    public List<Store_Location__c> listofNearestLocation{get;set;}
    public  decimal lati=0.00;
    public  decimal lung =0.00;
    
    
    //constructor
    public StoreLocationController(ApexPages.StandardController contrl)
    {
        listofNearestLocation=  new List<Store_Location__c> ();
        slc = [SELECT Street__c,City__c,Location__c,State__c,Postal_Code__c,Country__c,Location__Latitude__s,Location__Longitude__s FROM Store_Location__c where Id =:contrl.getId()];
        lati = slc.Location__Latitude__s;
        lung = slc.Location__Longitude__s;
        //System.debug('slc'+slc + 'lati' +lati +'lung' +lung);
        distance(); 
    } 
    
    //selectlist
     public List<SelectOption> getItems() { 
        List<SelectOption> selectlist = new List<SelectOption>();
        selectlist.add(new SelectOption('1',' 1  mile'));
        selectlist.add(new SelectOption('5',' 5  mile'));
        selectlist.add(new SelectOption('10',' 10  mile'));
        selectlist.add(new SelectOption('25',' 25  mile'));
        selectlist.add(new SelectOption('50',' 50  mile'));
        selectlist.add(new SelectOption('100',' 100  mile'));
        return selectlist;
    }
      
    //method for calulate distance from current store
    public PageReference distance() 
    {
        List<Store_Location__c> slclist = new List<Store_Location__c> ();
        //System.debug('lati' +lati +'lung' +lung); 
        stringofNear='';
        listofNearestLocation=  new List<Store_Location__c> ();
        String queryStr = 'SELECT Name,Street__c,City__c,State__c,Postal_Code__c,Country__c,Location__Latitude__s,Location__Longitude__s FROM Store_Location__c WHERE DISTANCE(Location__c,';
        if(selectDistance != null)
        {
             slclist = Database.query('Select Name,Street__c,City__c,State__c,Postal_Code__c,Country__c,Location__Latitude__s,Location__Longitude__s,Location__c FROM Store_Location__c WHERE DISTANCE( Location__c, GEOLOCATION(' + lati + ', ' + lung + ' ), \'mi\') < '+selectDistance);
        }
        else
        {
             slclist = Database.query('Select Name,Street__c,City__c,State__c,Postal_Code__c,Country__c,Location__Latitude__s,Location__Longitude__s,Location__c FROM Store_Location__c WHERE DISTANCE( Location__c, GEOLOCATION(' + lati + ', ' + lung + ' ), \'mi\') < 1');
        }
        //System.debug('slclist'+slclist);
        //System.debug('slclist'+slclist.size());     
        //System.debug('slc.selectDistance'+selectDistance);
        
        for(integer k =0; k< slclist.size() ; k++)
        {
            if(slc.Id !=slclist[k].Id)
            stringofNear+=slclist[k].Location__Latitude__s+',' +slclist[k].Location__Longitude__s +',' +slclist[k].Name +',' +slclist[k].Street__c +',' +slclist[k].City__c +',' +slclist[k].State__c +',' +slclist[k].Country__c +',' +slclist[k].Id +';';
        }
        //System.debug('stringofNear'+stringofNear);
            
        return null;
    }
    
}