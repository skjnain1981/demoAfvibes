public class AccountUtils
{
    
    public static List<Account> accountsByState (String state)
    {
        return [SELECT Id,Name From Account WHERE BillingState =:state];
    }
    
}