/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package edu.pucmm.pw.parcial2.servicios;

import edu.pucmm.pw.parcial2.entidades.Hashtag;
import edu.pucmm.pw.parcial2.entidades.Tweet;
import java.io.Serializable;
import java.util.AbstractCollection;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.enterprise.context.ApplicationScoped;
import javax.inject.Named;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;

/**
 *
 * @author Richard
 */
@Named
@ApplicationScoped
public class HashtagServicio implements Serializable{
    EntityManagerFactory emf = Persistence.createEntityManagerFactory("parcial2_grupo1_MicrobloggingPU");
    private EntityManager em = emf.createEntityManager();
    
    public HashtagServicio() {
    }
    
    public void analizeTweet(int idTweet){
        //esta funcion se encarga de analizar un tweet y buscar los hashtags que contenga y agregarlos a la bdd...
        Tweet t = em.find(Tweet.class, idTweet);
        TweetServicio ts = new TweetServicio();
        if(t != null){
            String[] tPart = t.getContenido().split(" ");
            List<String> listHtNombres = getListHtNames();
            
            for(String s : tPart){
                if(s.charAt(0) == '#'){
                    //es un HT, verificamos si existe en la bdd de HT's
                    
                    if(listHtNombres.contains(s)){
                        //buscamos ese HT y le agregamos el id de este tweet
                        Hashtag ht = getSingleHT(s);
                        
                        em.getTransaction().begin();
                        List<Tweet> tweetCollection = ht.getTweetList();
                        tweetCollection.add(t);
                        ht.setTweetList(tweetCollection);
                        em.getTransaction().commit();
                    }
                    else{
                        //no lo contiene, lo agregamos
                        Hashtag ht = new Hashtag();
                        ht.setNombre(s);
                        List<Tweet> tweetCollection = new ArrayList<>();
                        tweetCollection.add(t);
                        ht.setTweetList(tweetCollection);
                        persist(ht);
                    }
                }
            }
        }
    }
    
    public Hashtag getSingleHT(String s){
        try{
            String jpql = "select h from Hashtag h where h.nombre = ?1";
            Query qq = em.createQuery(jpql);
            qq.setParameter(1, s);
            return (Hashtag)qq.getSingleResult();
        }
        catch(Exception ex){
            System.err.println(ex.getMessage());
            return null;
        }
    }
    
    public List<String> getListHtNames(){
        try{
            String jpql = "select h.nombre from Hashtag h";
            Query q = em.createQuery(jpql);
            return q.getResultList();
        }
        catch(Exception ex){
            System.err.println(ex.getMessage());
            return null;
        }
    }
    
    public void persist(Object object) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(object);
            em.getTransaction().commit();
        } catch (Exception e) {
            Logger.getLogger(getClass().getName()).log(Level.SEVERE, "exception caught", e);
            em.getTransaction().rollback();
        } finally {
            em.close();
        }
    }
    
    
}
