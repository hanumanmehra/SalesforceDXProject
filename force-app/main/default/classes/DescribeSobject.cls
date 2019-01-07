public  class DescribeSobject 
{   
    public map<String,SObject> mapofsearch{get;set;}
    public Map<String, Schema.SObjectType> sobjecjMap; 
    public String selobject; 
    
    public List<String> selfields{get;set;}
    public Map<String,Schema.SObjectField> mfields;
    
    public Boolean Iselect{get;set;}
    public String inputvalue{get;set;}
    public List<SObject> searchlist{get;set;}
    
    //Constructor
    public DescribeSobject()
    {
        Iselect = false;
        searchlist = new List<SObject>();
        mapofsearch = new map<String,SObject>(); 
        mfields = new Map<String,Schema.SObjectField>(); 
        selfields =  new List<String>(); 
        
        sobjecjMap = Schema.getGlobalDescribe();   
        //System.debug('sobjecjlist'+sobjecjMap.values());
        //System.debug('sobjecjkeys'+sobjecjMap.keySet());   
    }
    
    //get and set method for Selectobject
    public String getselectobject()
    {
        return selobject;
    }
    
    public  void setselectobject( String selobject)  
    {
        this.selobject = selobject;
    }
    
    //get method for list SelectOptions of Sobject
    public List<SelectOption> getItems() 
    { 
        List<SelectOption> selectlist = new List<SelectOption>();
        for(String keys: sobjecjMap.keySet())
        {
            Schema.DescribeSObjectResult d = sobjecjMap.get(keys).getDescribe();
            if(d.isQueryable()== true)
            {
                selectlist.add(new SelectOption(d.getName(),d.getlabel()));
            }
        }
        selectlist.sort();
        return selectlist;  
    }
        
    // method of getfields of sobject
    public void fieldsOfObject()
    {
        searchlist = new List<SObject>();
        selfields = new List<String>();
        Iselect = false;
        inputvalue='';
        if(selobject !='None')
        {
            SObjectType objType = sobjecjMap.get(selobject);
            mfields = objType.getDescribe().fields.getMap();
            for(String keys: mfields.keySet())
            {
                Schema.DescribeFieldResult dsr=mfields.get(keys).getDescribe();
            }
            System.debug('-----objType----'+objType);
            System.debug('-----mfields----'+mfields.values()); 
            System.debug('mfields keys----'+mfields.keySet());
        }
        else
        {
            mfields = new Map<String,Schema.SObjectField>();
        }
    }
        
        
    //get and set method for Select fields
    public List<String>  getselectfields()
    {
        return selfields;
    }
    
    public  void setselectfields( List<String> selfields)            
    {
        this.selfields= selfields; 
    }
    
    
    //get method for list SelectOption of select fields
    public List<SelectOption> getfieldItems() 
    { 
        List<SelectOption> selectlist = new List<SelectOption>();   
        System.debug('mfields'+mfields.keySet());
         
        for(String keys: mfields.keySet())
        {
            Schema.DescribeFieldResult dsr=mfields.get(keys).getDescribe();
            if(dsr.isCreateable() != false && dsr.isSortable() != false)
            {
                selectlist.add(new SelectOption(dsr.getName(),dsr.GetLabel())); 
            }
            selectlist.sort();
        }
        return selectlist;  
    }
    
    
    // Method for the search by input value
    public void inputmethod()
    {   
        if(selfields != null && selfields.size() >0)
        {
            Iselect = true;
            String querystr = 'Select ';
            String filtercond = 'Where ('; 
            
            // get Each selected fields for dynamically binds in query
            for(String st:selfields)
            {
                System.debug('selfields'+selfields);
                //querystr += st +',';
                Schema.DescribeFieldResult desfield=mfields.get(st).getDescribe();
                System.debug('desfield.getSOAPType()'+desfield.getType() +'desfield'+desfield);
                
                querystr += st +',';
                
                if(String.valueof(desfield.getSoapType()) == 'String')
                {   
                        System.debug('desfield :::'+desfield);
                        if(inputvalue != null && inputvalue != '') 
                        {
                            filtercond +=' '+st +' LIKE  \''+'%' +inputvalue + '%\'' + ' or'; 
                        }
                }
                
            }
            
            
            if(querystr.endswith(','))
            {
                querystr = querystr.subString(0,querystr.length()-1); 
                querystr+=' From '+selobject;
                
                if(inputvalue == null || (inputvalue == ' ' || inputvalue == ''))
                {
                    searchlist =Database.query(querystr);
                }
            }    
                    
            if(filtercond.endswith('or') && filtercond.length()>0)
            {
                filtercond = filtercond.subString(0,filtercond.length()-1);
                filtercond = filtercond.subString(0,filtercond.length()-1);
                querystr += ' '+filtercond + ')';
            }
            
            System.debug('temp:::::'+filtercond+ '::::querystr:::'+querystr);
            try
            {
                System.debug('querystr'+querystr);
                List<SObject> templist = Database.query(querystr);
                
                for(SObject sc :templist)
                {
                    for(String str:selfields)
                    {
                        Schema.DescribeFieldResult desfield=mfields.get(str).getDescribe(); 
                        System.debug('sc:'+sc +'str:' +str);
                        searchlist.add(sc);
                    }
                }
                
            }
            catch(DMLException de)
            {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.ERROR,de.getmessage()));   
            } 
            
            System.debug('querystr::::'+querystr +'searchlist'+searchlist);
        }
    }
}