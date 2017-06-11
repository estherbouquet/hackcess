import com.mashape.unirest.http.*;
import com.mashape.unirest.http.exceptions.UnirestException;

boolean little_print(String face, String message, String endpoint, String api_key) {
  try {
    String msg = "{\"message\": \"" + message.replace("\"", "\\\"") +"\", \"face\": \"" + face.replace("\"", "\\\"") + "\"}";
    println(msg);
    com.mashape.unirest.http.HttpResponse<String> request = Unirest.post(endpoint+"?api_key="+api_key)
      .body(msg)
      .asString();
  
    println(request.getBody());
    return true;
  } catch (Exception e) {
    println(e);
    return false;
  }
}

void keyPressed() {
 if (key == 'a') {
  String msg = join(loadStrings("debut.html"), "\\n") 
    + join(loadStrings("conversation-"+int(random(1,4))+".html"), "\\n") 
    + join(loadStrings("tutoriel-"+int(random(1,4))+".html"), "\\n") 
    + join(loadStrings("fin.html"), "\\n");
  
  little_print("noface", msg, 
  "http://berg.deuxfleurs.fr/ext_api/v1/printer/1/print_html", "pVMtKnKLPihg8zEpRdDHBMtK5ugC38qp");
 }
}