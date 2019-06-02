/////////////////////////////////
//Javascript for web-interface//
///////////////////////////////

    function fn_option(){
       var select = document.getElementById("second");
var i;
for (i = 0; i < 2; i++)
{
  select.options[i] = null;
}
        var x=document.getElementById("first").value;
        if(x==3)
        {    
         
 
          document.getElementById('second').innerHTML="<option value=\"correctional officer\" >abc</option>";
        }
        else if(x==4)
        {
           
    var i1 = document.getElementById("second");
    var optioni1 = document.createElement("option");
    optioni1.text = "Select";
    i1.add(optioni1);
    var i = document.getElementById("second");
    var option = document.createElement("option");
    option.text = "deputy sheriff d2b";
    option.value="deputy sheriff d2b";
    i.add(option);
    var j = document.getElementById("second");
    var option1 = document.createElement("option");
    option1.text = "correctional officer";
    option1.value="correctional officer";
    j.add(option1);
    
       
    
        }
      
        }
