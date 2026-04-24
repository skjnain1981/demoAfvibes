public class AccountHandler{

    public static Account insertNewAccount(String accountName){
        Account acc = new Account();
        try{
            acc.name=accountName;
            insert acc;
            return acc;
        }
        catch(DMLException ex){
            return null;
        }
    }
}