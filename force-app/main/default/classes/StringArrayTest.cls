public class StringArrayTest{

    public static List<String> generateStringArray(Integer len){
        List<String> lst = new List<String>();
        
        for(Integer i=0;i<len;i++){
            lst.add('Test ' + i);
        }
        return lst;
    }
}