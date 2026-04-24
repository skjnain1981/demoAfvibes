@istest
public class TestRestrictContactByName{

    public static testmethod void method1(){
        
        contact con = new contact();
        con.lastname='INVALIDNAME';
        
        try{
            insert con;
        }
        catch(exception ex){}
    }
}