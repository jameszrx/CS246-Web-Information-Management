/**
 * Created by James on 10/10/2017.
 */
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.*;

public class GetWebpage {
    public static void main(String args[]) throws Exception {
        URL url = new URL(args[0]);
        HttpURLConnection httpConn;
        try{
            httpConn = (HttpURLConnection) url.openConnection();
            httpConn.setRequestMethod("GET");
            int responseCode = httpConn.getResponseCode();
            BufferedReader in = new BufferedReader(new InputStreamReader(httpConn.getInputStream()));
            String inputLine;
            StringBuffer strbuf = new StringBuffer();
            while((inputLine = in.readLine()) != null){
                strbuf.append(inputLine);
                strbuf.append("\n");
            }
            in.close();
            //System.out.println("response code: " + responseCode);
            System.out.print(strbuf.toString());
        } catch (IOException ioe){
            ioe.printStackTrace();
        }
    }
}
