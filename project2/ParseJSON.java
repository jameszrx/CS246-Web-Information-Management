import java.io.*;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

public class ParseJSON {
  public static void main(String[] args) throws Exception {

    // Read the given json file and parse it using JSONParser
    JSONParser parser = new JSONParser();
    JSONObject jsonObject = (JSONObject)parser.parse(new FileReader("./data/simplewiki-abstract.json"));

    // Once we have the JSONObject, we can access the different fields by using the 'get' method.
    // The 'get' method returns a value of type Object. We must cast the returned value to the correct type.
    JSONObject simplewiki = (JSONObject)jsonObject.get("simplewiki");
    JSONArray pages = (JSONArray)simplewiki.get("page");

    //Create a file that contains the documents in a format that can be indexed using the Elasticsearch bulk API.
    String dest = "./data/" + args[0] + ".json";
    
    PrintWriter writer = new PrintWriter(dest, "UTF-8");

    int i = 1;
    String header = "{\"index\" : { \"_index\": \"" + args[0] +"\", \"_type\": \"wikipage\", \"_id\": \"%s\"}}";
    //String header = "{\"index\" : { \"_index\": \"task2a\", \"_type\": \"wikipage\", \"_id\": \"%s\"}";
    for(Object page : pages) {
      // Use the bulk indexing api from elasticsearch to index the file.
      // TODO: Add the headers needed for using bulk indexing API.
      // Ensure that the _id for the entry in the index matches the line number of that document.
   		String currHeader = String.format(header, String.valueOf(i));
   		writer.println(currHeader);
      // Write Json Page entry to file
      writer.println(page);
      //writer.println();
      i++;
    }

    writer.close();
  }
}
