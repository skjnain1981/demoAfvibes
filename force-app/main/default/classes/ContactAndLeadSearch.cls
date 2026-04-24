public class ContactAndLeadSearch{
    
    public static List<List< SObject>> searchContactsAndLeads(string str){
        List<List<sObject>> searchList = [FIND:str RETURNING Contact(id where (lastname=:str)), lead(id where (lastname=:str))];
    
        return searchList;
    }
}