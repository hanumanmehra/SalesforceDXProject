public class SurveyQuestion {
    
    public List<Survey_Question__c> listchoice{get;set;}
    public List<Survey_Format__c> aclist{get;set;}
    public String ac{get;set;}
    public set<Id> questId{get;set;}
    public boolean checked{get;set;}
    public List<Wrapperclass> wraplist {get;set;}
    public List<Survey_Choice__c> wrapcoic{get;set;}
    public List<Survey_Answer__c> listan {get;set;}
    //public Set<String> ansset{get;set;}
    //public map<Survey_Question__c,List<Survey_Choice__c>> mapans{get;set;}
    //public List<Survey_Question__c> listAns{get;set;}
    //public Map<Survey_Question__c,List<Survey_Choice__c>> wrap_map_acc{get; set;}
    
    
    public SurveyQuestion(){
        String ac= Apexpages.currentPage().getparameters().get('Id');
        //listAns= new List<Survey_Question__c>();
        listchoice =new List<Survey_Question__c>();
        aclist= new List<Survey_Format__c>();
        wraplist= new List<Wrapperclass>();
        wrapcoic= new  List<Survey_Choice__c>();
        listan =new List<Survey_Answer__c>();
        //List of assigment related to question
        aclist = [Select Survey_Question__r.S_No__c,Survey_Question__r.Question_Type__c,Survey_Question__r.Name From Survey_Format__c where Survey_Assignment__r.Id=:ac];
        System.debug('aclist ::'+aclist );
        questId= new set<Id>();
        
        for(Survey_Format__c qc : aclist){
            questId.add(qc.Survey_Question__c);
        }
        choice();  
    }
    
    public void choice(){
        //list of choice of question with choice
        listchoice=[Select Name,S_No__c,Question_Type__c,(Select name, Choice__c From Survey_Choices__r),(Select name From Survey_Answers__r) From Survey_Question__c where Id  =:questId];
        System.debug(' list of choice:'+listchoice[0].Survey_Choices__r);
        System.debug('List of Ans:'+listchoice[0].Survey_Answers__r);
        System.debug(' list of choice with que:: '+listchoice);
        //mapans= new map<Survey_Question__c,List<Survey_Choice__c>>();
        
        for(Survey_Question__c obj : listchoice){
            List<Survey_Choice__c> choicelst = obj.Survey_Choices__r;
            System.debug('choicelst'+choicelst);
            Wrapperclass wrcls = new Wrapperclass(obj);
            if(obj.Survey_Choices__r != null && obj.Survey_Choices__r.size() > 0){
                wrcls.wrapcoic = obj.Survey_Choices__r;
                for(Survey_Choice__c scr : obj.Survey_Choices__r ){ 
                    if(obj.Question_Type__c == 'Dropdown'){
                        wrcls.selopt.add(new SelectOption(scr.name,scr.name));
                    }
                }
                if(obj.Survey_Answers__r != null && obj.Survey_Answers__r.size() > 0){
                    wrcls.wrans = obj.Survey_Answers__r;
                }
                System.debug('wrcls:'+wrcls);
            }
            wraplist.add(wrcls);
            System.debug('List of wraplist:'+wraplist);
            Storebtn();
        } 
        
    }
    
    public void Storebtn(){
        for(Wrapperclass wrap :wraplist){
            System.debug('wrap'+wrap);
            Survey_Answer__c objans = new Survey_Answer__c();
            if(wrap.wrapqc.Question_Type__c == 'Dropdown'|| wrap.wrapqc.Question_Type__c == 'Checkboxes'|| wrap.wrapqc.Question_Type__c == 'Text'){
                objans.Response_Text__c= wrap.answer;
                objans.Survey_Question__r =wrap.wrapqc;
            } 
            if(wrap.wrapqc.Question_Type__c == 'Date'||wrap.wrapqc.Question_Type__c == 'Time' ){
                String dt = String.valueof(wrap.seldate);
                String tme =String.valueof(wrap.seltime);
                System.debug('String dt'+dt);
                objans.Response_Text__c =dt;
                objans.Response_Text__c =tme;
            }
            objans.Survey_Question__r =  wrap.wrapqc;
            System.debug('objans::'+objans);
            listan.add(objans);
        }   
        
    }
     public class Wrapperclass {
        
        public Survey_Question__c wrapqc{get;set;}
        public List<Survey_Choice__c> wrapcoic{get;set;}
        public List<Survey_Answer__c> wrans{set;get;}
        public String answer{get;set;}
        public date seldate{get;set;}
        public Time seltime{get;set;}
        public boolean ischecked{set;get;}
        public List<SelectOption> selopt{get;set;}
        
        //Constructor of wrapper class
        public Wrapperclass(Survey_Question__c acc) {
            this.wrapqc = acc;
            System.debug('acc'+acc);
            this.ischecked = false;
            wrapcoic = new  List<Survey_Choice__c>();
            selopt = new List<SelectOption>();
            wrans =  new List<Survey_Answer__c>();
            System.debug('selopt::'+selopt);
            System.debug('wrapcoic::'+wrapcoic);        
        }
    }
}