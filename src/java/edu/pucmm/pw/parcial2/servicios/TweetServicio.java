/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package edu.pucmm.pw.parcial2.servicios;

import edu.pucmm.pw.parcial2.entidades.Tweet;
import edu.pucmm.pw.parcial2.entidades.Usuario;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
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
public class TweetServicio implements Serializable{
    EntityManagerFactory emf = Persistence.createEntityManagerFactory("parcial2_grupo1_MicrobloggingPU");
    private EntityManager em = emf.createEntityManager();
    
    public TweetServicio() {
    }
    
    public int crearTweet(String contenido, String image, boolean isPublic, Date fechaCreacion, Usuario usuario){
        em.getTransaction().begin();
        Tweet t = new Tweet();
        t.setContenido(contenido);
        t.setIsPublic(isPublic);
        t.setImagen(image);
        t.setIdUsuario(usuario);
        t.setFechaCreacion(fechaCreacion);
        
        persist(t);
        em.getTransaction().commit();
        return t.getId();
    }
    
    public List<Tweet> getTweetsByHashtag(String ht){
        try{
            String sql = "SELECT t.* FROM TWEET t, HASHTAG h, TWEET_HASHTAG th WHERE t.id=twEET_ID AND th.HASHTAG_ID=h.id  AND h.NOMBRE =?1 ORDER BY  t.FECHA_CREACION DESC";
            Query q = em.createNativeQuery(sql, Tweet.class);
            q.setParameter(1, ht);
            List<Tweet> tweets = q.getResultList();
            if(tweets != null){
                return tweets;
            }
            return null;
        }
        catch(Exception ex){
            System.err.println(ex.getMessage());
            return null;
        }
    }
    
    public Tweet getTweet(int idTweet){
        return em.find(Tweet.class, idTweet);
    }
    
    public List<Tweet> getTimeline(Usuario user){
        try{
            UsuarioServicio us = new UsuarioServicio();
            String jpql;
            Query q;
            if(us.getUsuarioSeguidorCount() > 0L){
                jpql = "SELECT DISTINCT t.* FROM TWEET t, USUARIO_SEGUIDOR us WHERE t.ID_USUARIO = ?1 OR (us.USUARIO_ID =?2  and t.ID_USUARIO = us.SEGUIDOR_ID) ORDER BY t.FECHA_CREACION DESC";
                q = em.createNativeQuery(jpql, Tweet.class);
                q.setParameter(1, user.getId());
                q.setParameter(2, user.getId());
                List<Tweet> tl = q.getResultList();
                return tl;
            }
            else{
                return getTimelineUser(user);
            }
            
            
            
        }
        catch(Exception ex){
            System.err.println(ex.getMessage());
            return null;
        }
    }
    
    public Long getCantTweetsUsuario(Usuario user){
        try{
            String jpql = "select count(t) from Tweet t where t.idUsuario=?1";
            Query q = em.createQuery(jpql);
            q.setParameter(1, user);
            Long cant  = (Long) q.getSingleResult();
            if(cant >= 0){
                return cant;
            }
            else{
                return -1L;
            }
            
        }
        catch(Exception ex){
            return -1L;
        }
    }
    
    public Long getFollowersCount(Usuario user){
        try{
            String sql = "SELECT count(*) FROM USUARIO_SEGUIDOR WHERE USUARIO_ID=?1";
            Query q = em.createNativeQuery(sql);
            q.setParameter(1, user.getId());
            Long cant = (Long)q.getSingleResult();
            if(cant >= 0){
                return cant;
            }
            else{
                return -1L;
            }
        }
        catch(Exception ex){
            System.err.println(ex.getMessage());
            return -1L;
        }
    }
    
    public List<Usuario> getFollowers(Usuario user){
        try{
            String sql = "SELECT U.* FROM USUARIO U, USUARIO_SEGUIDOR US WHERE US.SEGUIDOR_ID =?1 AND U.ID=US.USUARIO_ID ";
            Query q = em.createNativeQuery(sql, Usuario.class);
            q.setParameter(1, user.getId());
            List<Usuario> followers = q.getResultList();
            return followers;
        }
        catch(Exception ex){
            System.err.println(ex.getMessage());
            return null;
        }
    }
    
    public Long getFollowingCount(Usuario user){
        try{
            String sql = "SELECT count(*) FROM USUARIO_SEGUIDOR WHERE SEGUIDOR_ID=?1";
            Query q = em.createNativeQuery(sql);
            q.setParameter(1, user.getId());
            Long cant = (Long)q.getSingleResult();
            if(cant >= 0){
                return cant;
            }
            else{
                return -1L;
            }
        }
        catch(Exception ex){
            System.err.println(ex.getMessage());
            return -1L;
        }
    }
    
    public List<Usuario> getFollowing(Usuario user){
        try{
            String sql = "SELECT U.* FROM USUARIO U, USUARIO_SEGUIDOR US WHERE US.USUARIO_ID =?1 AND U.ID=US.SEGUIDOR_ID";
            Query q = em.createNativeQuery(sql, Usuario.class);
            q.setParameter(1, user.getId());
            List<Usuario> following = q.getResultList();
            return following;
        }
        catch(Exception ex){
            System.err.println(ex.getMessage());
            return null;
        }
    }
    
    public List<Tweet> getTimelineUser(Usuario user){
        try{
            String jpql = "select t from Tweet t where t.idUsuario = ?1 order by t.fechaCreacion desc";
            Query q = em.createQuery(jpql);
            q.setParameter(1, user);
            List<Tweet> tl = q.getResultList();
            if(tl != null){
                return tl;
            }
            else{
                return null;
            }
        }
        catch(Exception ex){
            return null;
        }
    }
    
    public List<Tweet> getTimelineUserPublic(Usuario user){
        try{
            String jpql = "select t from Tweet t where t.idUsuario = ?1 and t.isPublic = true order by t.fechaCreacion desc";
            Query q = em.createQuery(jpql);
            q.setParameter(1, user);
            List<Tweet> tl = q.getResultList();
            if(tl != null){
                return tl;
            }
            else{
                return null;
            }
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
