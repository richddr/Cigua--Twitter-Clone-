using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Runtime.Serialization;
using System.Net;
using System.Runtime.Serialization.Json;
using System.ServiceModel;
using System.IO;
using Newtonsoft.Json;
using RestCiguaClient.Entidades;

namespace RestCiguaClient
{
    class CiguaREST
    {
        static private string host = @"http://localhost:8080/parcial2_grupo1_Microblogging/webresources/ciguaRest";

        static private string getRequest(string URL)
        {
            WebRequest req = WebRequest.Create(@host + URL);
            req.Method = "GET";
            string ret = null;
            HttpWebResponse resp = req.GetResponse() as HttpWebResponse;
            if (resp.StatusCode == HttpStatusCode.OK)
            {
                using (Stream respStream = resp.GetResponseStream())
                {
                    StreamReader reader = new StreamReader(respStream, Encoding.UTF8);
                    ret = reader.ReadToEnd();
                }
            }
            else
            {
                Console.WriteLine(string.Format("Status Code: {0}, Status Description: {1}", resp.StatusCode, resp.StatusDescription));
            }
            return ret;
        }

        static private string postRequest(string URL, string Campos, bool json)
        {
            
            Uri address = new Uri(@host + URL);  
            HttpWebRequest request = WebRequest.Create(address) as HttpWebRequest;  
            request.Method = "POST";  
            if(!json)
             request.ContentType = "application/x-www-form-urlencoded";
            else
                request.ContentType = "application/json";

            string ret = null;
  
            // Create a byte array of the data we want to send  
            byte[] byteData = UTF8Encoding.UTF8.GetBytes(Campos);  
  
            // Set the content length in the request headers  
            request.ContentLength = byteData.Length;
           
                // Write data  
                using (Stream postStream = request.GetRequestStream())
                {
                    postStream.Write(byteData, 0, byteData.Length);
                }

                // Get response  
                using (HttpWebResponse response = request.GetResponse() as HttpWebResponse)
                {
                    // Get the response stream  
                    StreamReader reader = new StreamReader(response.GetResponseStream());

                    // Console application output  
                    ret = reader.ReadToEnd();
                }

  
            return ret;

        }

        static public Usuario realizarLogin(string usuario, string password)
        {
            StringBuilder data = new StringBuilder();
            data.Append("username=" + Uri.EscapeUriString(usuario));
            data.Append("&password=" + Uri.EscapeUriString(password));
            string json = postRequest("/login", data.ToString(), false);
            return JsonConvert.DeserializeObject<Usuario>(json);
           
        }

        static public List<Tweet> obtenerTimeline(string usuario)
       {       
            string json = getRequest("/timeline/" + usuario);
            return JsonConvert.DeserializeObject<List<Tweet>>(json);
       }

        static public Usuario getUserByTweetId(int usuario)
        {
            StringBuilder data = new StringBuilder();
            data.Append("tweetId=" + Uri.EscapeUriString(usuario.ToString()));
            string json = postRequest("/getUserByTweetId", data.ToString(), false);
            return JsonConvert.DeserializeObject<Usuario>(json);

        }

        static public Estadistica getEstadistica(string usuario)
        {

            StringBuilder data = new StringBuilder();
            data.Append("username=" + Uri.EscapeUriString(usuario));
            string json = postRequest("/Estadisticas", data.ToString(), false);
            return JsonConvert.DeserializeObject<Estadistica>(json);

        }

        static public Tweet crearTweet(string contenido, string imagenNombre, byte[] imagen, bool isPublic, string username)
        {
            tweetRest ntwt = new tweetRest();
            ntwt.contenido = contenido;
            ntwt.imagenNombre = imagenNombre;
            ntwt.imagen = imagen;
            ntwt.isPublic = isPublic;
            ntwt.username = username;



            string json = postRequest("/crearTweetRest", JsonConvert.SerializeObject(ntwt), true);
            return JsonConvert.DeserializeObject<Tweet>(json);

        }


    }
}
