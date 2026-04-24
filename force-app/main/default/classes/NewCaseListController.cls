public class NewCaseListController{

    public List<Case> getNewCases(){
        List<Case> caselist = new List<Case>();
        caselist = [select id,CaseNumber from case where status='New'];
        return caselist;
    }

}