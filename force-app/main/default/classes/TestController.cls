public with sharing class TestController {
    public List<String> lstSections { get; set; }

    public TestController(){
        lstSections = new List<String>();
    }

    public PageReference addSection() {

        lstSections.add('dummy');

        return null;
    }

}