/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package edu.pucmm.pw.parcial2.webservices;

import edu.pucmm.pw.parcial2.entidades.Tweet;
import edu.pucmm.pw.parcial2.entidades.Usuario;
import edu.pucmm.pw.parcial2.servicios.HashtagServicio;
import edu.pucmm.pw.parcial2.servicios.TweetServicio;
import edu.pucmm.pw.parcial2.servicios.UsuarioServicio;
import java.awt.Image;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.inject.Inject;
import javax.jws.WebMethod;
import javax.jws.WebParam;
import javax.jws.WebService;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Richard
 */
@WebService(serviceName = "CiguaWS")
public class CiguaWS {

    @Inject
    HttpServletRequest request;
    @Inject
    UsuarioServicio us;
    @Inject
    TweetServicio ts;
    @Inject
    HashtagServicio hs;

    /**
     * Web service operation
     * @param contenido
     * @param imagenNombre
     * @param t
     * @param isPublic
     * @param username
     * @param imagen
     * @return 
     * @throws java.io.FileNotFoundException 
     */
    @WebMethod(operationName = "crearTweet")
    public Boolean crearTweet(@WebParam(name = "contenido") String contenido,
            @WebParam(name = "imagenNombre") String imagenNombre,
            @WebParam(name = "imagen") byte[] imagen,
            @WebParam(name = "isPublic") boolean isPublic,
            @WebParam(name = "username") String username) throws FileNotFoundException, IOException {
        Usuario u = us.getUsuario(username);

        if(u != null){
            //Si se incluyo una imagen se debe guardar en el servidor.
            String of = null;
            if(imagen != null){
                of = request.getServletContext().getRealPath(imagenNombre);
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
            return true;
        }
        return false;
    }

    /**
     * Web service operation
     * @param username
     * @param password
     * @return 
     */
    @WebMethod(operationName = "authenticateUser")
    public Boolean authenticateUser(@WebParam(name = "username") String username, @WebParam(name = "password") String password) {
        //TODO write your implementation code here:
        int res = us.VerificarUsuario(username, password);
        return res == 1;
    }

    /**
     * Web service operation
     * @param username
     * @return 
     */
    @WebMethod(operationName = "getTweetsByUser")
    public List<Tweet> getTweetsByUser(@WebParam(name = "username") String username) {
        //TODO write your implementation code here:
        //primero validamos el username.
        Usuario u = us.getUsuario(username);
        if(u != null){
            return ts.getTimeline(u);
        }
        return null;
    }

    /**
     * Web service operation
     * @param imageRoute
     * @return 
     */
    @WebMethod(operationName = "getImage")
    public byte[] getImage(@WebParam(name = "imageRoute") String imageRoute) {
        try {
            //Obtenemos X imagen desde el servidor y la convertimos en un arreglo de bytes
            FileInputStream is = new FileInputStream(imageRoute);
            byte[] imagen = null;
            int bytesRead = is.read(imagen);
            return imagen;
        } catch (FileNotFoundException ex) {
            Logger.getLogger(CiguaWS.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(CiguaWS.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    /**
     * Web service operation
     */
    @WebMethod(operationName = "getCantTweets")
    public Long getCantTweets(@WebParam(name = "username") String username) {
        try{
            Usuario u = us.getUsuario(username);
            return ts.getCantTweetsUsuario(u);
        }
        catch(Exception ex){
            System.err.println(ex.getMessage());
            return -1L;
        }
    }

    /**
     * Web service operation
     */
    @WebMethod(operationName = "getFollowingCount")
    public Long getFollowingCount(@WebParam(name = "username") String username) {
        try{
            Usuario u = us.getUsuario(username);
            return ts.getFollowingCount(u);
        }
        catch(Exception ex){
            System.err.println(ex.getMessage());
            return -1L;
        }
    }

    /**
     * Web service operation
     */
    @WebMethod(operationName = "getFollowersCount")
    public Long getFollowersCount(@WebParam(name = "username") String username) {
        try{
            Usuario u = us.getUsuario(username);
            return ts.getFollowersCount(u);
        }
        catch(Exception ex){
            System.err.println(ex.getMessage());
            return -1L;
        }
    }

    /**
     * Web service operation
     */
    @WebMethod(operationName = "getUser")
    public Usuario getUser(@WebParam(name = "username") String username) {
        try{
            return us.getUsuario(username);
        }
        catch(Exception ex){
            System.err.println(ex.getMessage());
            return null;
        }
    }

    /**
     * Web service operation
     */
    @WebMethod(operationName = "getUserByTweetId")
    public Usuario getUserByTweetId(@WebParam(name = "tweetId") int tweetId) {
        try{
            return us.getUsuarioByTweetId(tweetId);
        }
        catch(Exception ex){
            System.err.println(ex.getMessage());
            return null;
        }
    }

}
