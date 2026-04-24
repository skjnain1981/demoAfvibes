global class DailyLeadProcessor implements Schedulable {
    global void execute(SchedulableContext ctx) {
        List<lead> updateleadlist = new List<lead>();
        List<lead> leadlist = [select id, LeadSource from lead where LeadSource=Null OR LeadSource=''];
        for(lead obj : leadlist){
            obj.LeadSource= 'Dreamforce';
            updateleadlist.add(obj);
        }
        
        if(!updateleadlist.IsEmpty()){
        update updateleadlist;
        }
        
    }
}