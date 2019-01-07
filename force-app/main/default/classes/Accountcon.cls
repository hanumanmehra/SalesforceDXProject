public class Accountcon{
    public Contact con{get;set;}
    public List<opportunitywrap> listop{get;set;}
    public List<contactwrap> listcon{get;set;}
    
    public Accountcon(){
        listop = new List<opportunitywrap>();
        listcon = new List<contactwrap>();
        con = new Contact();
    }
    
    public void filldata(){
        listop = new List<opportunitywrap>();
        listcon = new List<contactwrap>();
        for(Contact con : [select name,id,email,AccountId,Phone,LastName from Contact where AccountId = :con.AccountId And AccountId != null]){
            contactwrap mod = new  contactwrap ();
            mod.con = con;
            listcon.add(mod);
        }
        for(Opportunity opp : [select name,StageName,CloseDate,AccountId from Opportunity where AccountId =: con.AccountId And AccountId != null]){
            opportunitywrap mod = new opportunitywrap();
            mod.opp = opp;
            listop.add(mod);   
        }
    }
    
    public void cloneData(){
        List<Contact> contactToInsert = new List<Contact>();
        List<Opportunity> opportunityToInsert = new List<Opportunity>();
        for(contactwrap mod : listcon){
            if(mod.ischeck){
                Contact con = mod.con.clone(false,true);
                contactToInsert.add(con);
            }
        }
        
        for(opportunitywrap mod : listop){
            if(mod.ischeck){
                opportunity  opp = mod.opp.clone(false,true);
                opportunityToInsert.add(opp);
            }
         }
         if(contactToInsert.size() > 0){
             insert contactToInsert ;
         }
         
         if(opportunityToInsert.size() > 0){
             insert opportunityToInsert;
         }
        
    }
    
    public class opportunitywrap{
        public boolean ischeck{get;set;}
        public opportunity opp{get;set;}
        
        public opportunitywrap(){
            ischeck = false;
            opp = new opportunity();
        }
    }
    public class contactwrap{
        public boolean ischeck{get;set;}
        public Contact con{get;set;}
        
        public contactwrap(){
            ischeck = false;
            con = new Contact ();
        }
    }
}