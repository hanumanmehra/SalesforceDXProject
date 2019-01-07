Public class Test {
    public   String Msg{get;Set;}
    public Test () {
      Msg =  '';
     
       ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.FATAL,+Msg ));
       Msg = 'End test';
       
       
           return;
             ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.FATAL,+Msg ));
    }
}