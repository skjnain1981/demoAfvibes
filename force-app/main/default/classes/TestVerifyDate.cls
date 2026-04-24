@istest
public class TestVerifyDate{

    public static testmethod void method1(){
        
        Date dt1 = date.today();
        Date dt2 = date.today().adddays(28);
        Date dt3 = date.today().addmonths(1);
        
        test.startTest();
        VerifyDate.CheckDates(dt1,dt2);
        
        VerifyDate.CheckDates(dt1,dt3);
        
        test.stopTest();
    }
}