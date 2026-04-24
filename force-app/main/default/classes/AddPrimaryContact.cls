public class AddPrimaryContact implements Queueable{
    public Contact con;
    public String state;
    
    public AddPrimaryContact(Contact c, String strstate){
        con = c;
        state = strstate;
    }

    public void execute(QueueableContext context) {
         List<Account> accountlist = new List<Account>();
         List<contact> contactlist = new List<contact>();
         accountlist = [select id from account where BillingState=:state limit 200];
        
         for(account acc : accountlist){
             contact objCon = con.clone();
             objCon.lastname = 'test';
             objCon.accountID = acc.id;
             contactlist.add(objCon);
         }
         
         if(!contactlist.IsEmpty()){
             insert contactlist;
         }
    }
}