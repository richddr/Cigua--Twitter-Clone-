/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package edu.pucmm.pw.parcial2.webservices;

import edu.pucmm.pw.parcial2.entidades.Estadistica;
import edu.pucmm.pw.parcial2.entidades.Tweet;
import edu.pucmm.pw.parcial2.entidades.Usuario;
import edu.pucmm.pw.parcial2.entidades.tweetRest;
import edu.pucmm.pw.parcial2.servicios.HashtagServicio;
import edu.pucmm.pw.parcial2.servicios.TweetServicio;
import edu.pucmm.pw.parcial2.servicios.UsuarioServicio;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.Consumes;
import javax.ws.rs.DefaultValue;
import javax.ws.rs.FormParam;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.UriInfo;

/**
 * REST Web Service
 *
 * @author DavidA
 */
@Path("ciguaRest")
public class CiguaRest {

    @Context
    private UriInfo context;
    
    @Context
    private HttpServletRequest req;

    /**
     * Creates a new instance of HolaMundoRest
     */
    public CiguaRest() {
    }

    /**
     * Retrieves representation of an instance of edu.pucmm.pw.clase_12072014.rest.CiguaRest
     * @return an instance of java.lang.String
     */
    @GET
    @Produces("application/json")
    public String getJson() {
        //TODO return proper representation object
        return "{\"valor\" : \"Hola Mundo REST - JAX-RS\"}";
    }
    
    @Path("timeline/{usuario}")
    @GET
    @Produces("application/json") //o json
    public List<Tweet> getTweets(@PathParam("usuario") String nombreUsuario){
        List<Tweet> l=new ArrayList<>();
         
        if(nombreUsuario != null)
        {
            UsuarioServicio us = new UsuarioServicio();
            System.out.println("Usuario :"+nombreUsuario);
            Usuario user = us.getUsuario(nombreUsuario);
            if(user != null)
            {
              TweetServicio ts = new TweetServicio();
              l = ts.getTimeline(user); 
            }
        }
        return l;
    }
    
    //Realiza el login y retorna el usuario
    @Path("login")
    @POST
    @Produces("application/json")
    @Consumes("application/x-www-form-urlencoded")
    public Usuario loginUsuario(@FormParam("username") String username, @FormParam("password") String password){
        
        Usuario u = null;
        
        UsuarioServicio us = new UsuarioServicio();
        int result = us.VerificarUsuario(username, password);
        if(result == 1){
            //datos validados correctamente, se agrega el usuario a la sesion logueado
            u = us.getUsuario(username);
            u.setPassword("");
        }
        return u;
    }
    
    @Path("getUser")
    @POST
    @Produces("application/json")
    @Consumes("application/x-www-form-urlencoded")
    public Usuario getUser(@FormParam("username") String username) {
        try{
            UsuarioServicio us = new UsuarioServicio();
            return us.getUsuario(username);
        }
        catch(Exception ex){
            System.err.println(ex.getMessage());
            return null;
        }
    }
    
   
    
    @Path("Estadisticas")
    @POST
    @Produces("application/json")
    @Consumes("application/x-www-form-urlencoded")
    public Estadistica Estadisticas(@FormParam("username") String username) {
        try{
            UsuarioServicio us = new UsuarioServicio();
             TweetServicio ts = new TweetServicio();
            Usuario u = us.getUsuario(username);
            Estadistica est = new Estadistica();
            est.CantTweets = ts.getCantTweetsUsuario(u);
            est.FollowersCount = ts.getFollowersCount(u);
            est.FollowingCount = ts.getFollowingCount(u);
            return est;
        }
        catch(Exception ex){
            System.err.println(ex.getMessage());
            return null;
        }
    }
    @Path("getUserByTweetId")
    @POST
    @Produces("application/json")
    @Consumes("application/x-www-form-urlencoded")
     public Usuario getUserByTweetId(@FormParam("tweetId") int tweetId) {
        try{
             UsuarioServicio us = new UsuarioServicio();
            return us.getUsuarioByTweetId(tweetId);
        }
        catch(Exception ex){
            System.err.println(ex.getMessage());
            return null;
        }
    }
     
      @Path("crearTweetRest")
    @POST
    @Produces("application/json")
    @Consumes("application/json")
     public Tweet crearTweetRest(tweetRest twtrst) throws FileNotFoundException, IOException {
         
           String contenido = twtrst.contenido;
           String imagenNombre = twtrst.imagenNombre;
           byte[] imagen = twtrst.imagen;
           boolean isPublic = twtrst.isPublic;
           String username = twtrst.username;
           
         UsuarioServicio us = new UsuarioServicio();
         HashtagServicio hs = new HashtagServicio();
         TweetServicio ts = new TweetServicio();
         
        Usuario u = us.getUsuario(username);

        if(u != null){
            //Si se incluyo una imagen se debe guardar en el servidor.
            String of = null;
            if(imagen != null){
                of = req.getServletContext().getRealPath(imagenNombre);
                FileOutputStream os = new FileOutputStream(of);
                os.write(imagen);
                
                System.out.println("------------ARREGLO DE BYTES NO ES NULO------------");
                System.out.println("IMAGEN BYTES SIZE:" + imagen.length);
                System.out.println("NOMBRE IMAGEN CLIENTE:" + imagenNombre);
                System.out.println("OF:" + of);
            }
            int idTweet = ts.crearTweet(contenido, imagenNombre, isPublic, new Date(), u);
            //Analizamos el tweet.
            hs.analizeTweet(idTweet);
            return ts.getTweet(idTweet);
        }
        return null;
    }
   
}