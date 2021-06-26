package DataEntity;

public class MasterCardData {
    private int number;
    private String name;
    private String axis;
    private String illust;
    private String preceding;
    private String trailing;
    
    public void setNumber(int number){
        this.number = number;
    }
    public void setName(String name){
        this.name = name;
    }
    public void setAxis(String axis){
        this.axis = axis;
    }
    public void setIllust(String illust){
        this.illust = illust;
    }
    public void setPreceding(String preceding){
        this.preceding = preceding;
    }
    public void setTrailing(String trailing){
        this.trailing = trailing;
    }
    public int getNumber(){
        return number;
    }
    public String getName(){
        return name;
    }
    public String getAxis(){
        return axis;
    }
    public String getIllust(){
        return illust;
    }
    public String getPreceding(){
        return preceding;
    }
    public String getTrailing(){
        return trailing;
    }
}