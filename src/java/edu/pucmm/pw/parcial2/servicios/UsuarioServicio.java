/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package edu.pucmm.pw.parcial2.servicios;

import edu.pucmm.pw.parcial2.entidades.Usuario;
import java.io.Serializable;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.enterprise.context.ApplicationScoped;
import javax.inject.Named;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.NoResultException;
import javax.persistence.Persistence;
import javax.persistence.Query;

/**
 *
 * @author Richard
 */
@Named
@ApplicationScoped
public class UsuarioServicio implements Serializable{
    EntityManagerFactory emf = Persistence.createEntityManagerFactory("parcial2_grupo1_MicrobloggingPU");
    private EntityManager em = emf.createEntityManager();
    
    public UsuarioServicio() {
    }
    
    public boolean followUsuario(String user, String userToFollow){
        em.getTransaction().begin();
        Usuario uF = getUsuario(userToFollow);
        Usuario u = getUsuario(user);
        List<Usuario> usuarioCollection = uF.getUsuarioList();
        
        
        if(u == null)
            return false;
        usuarioCollection.add(u);
        
        uF.setUsuarioList(usuarioCollection);
        em.getTransaction().commit();
        return true;
    }
    
    public boolean unfollowUsuario(String user, String userToUnFollow){
        em.getTransaction().begin();
        Usuario u = getUsuario(user);
        Usuario uUf = getUsuario(userToUnFollow);
        List<Usuario> usuarioCollection = uUf.getUsuarioList();
        
        
        if(u == null){
            return false;
        }
        usuarioCollection.remove(u);
        em.getTransaction().commit();
        return true;
    }
    
    public boolean UserFollowsUser(Usuario user, Usuario uF){
        try{
            return uF.getUsuarioList().contains(user);
        }
        catch(Exception ex){
            System.err.println(ex.getMessage());
            return false;
        }
    }
    
    public int VerificarUsuario(String username, String password){
        try{
            String jpql = "select u from Usuario u where u.username = ?1";
            Query q = em.createQuery(jpql);
            q.setParameter(1, username);
            //q.setParameter(2, password);
            Usuario user = (Usuario)q.getSingleResult();
            if(user != null){
                //usuario existe, verificamos que tiene la clave correcta.
                if(user.getPassword().equals(password)){
                    //clave correcta...
                    return 1;
                }
                else{
                    //clave incorrecta...
                    return -2;
                }
            }else{
                //usuario no existe o fue mal escrito....
                return -1;
            }
        }
        catch(Exception ex){
            System.err.println(ex.getMessage());
            return -1;
        }
    }
    
    public Long getUsuarioSeguidorCount(){
        try{
            String sql = "SELECT count(*) from USUARIO_SEGUIDOR";
            Query q = em.createNativeQuery(sql);
            Long cant = (Long)q.getSingleResult();
            return cant;
        }
        catch(Exception ex){
            System.err.println(ex.getMessage());
            return -1L;
        }
    }
    
    public int crearUsuario(String username, String password, String nombre, String apellido, Date fechaNacimiento, String fotoUsuario){
        Usuario user = new Usuario();
        user.setUsername(username);
        user.setPassword(password);
        user.setNombre(nombre);
        user.setApellido(apellido);
        user.setFechaNacimiento(fechaNacimiento);
        user.setFotoUsuario(fotoUsuario);
        
        persist(user);
        return user.getId();
    }
    
    public boolean VerificarUsuario(String username){
        try{
            String jpql = "select u from Usuario u where u.username = ?1";
            Query q = em.createQuery(jpql);
            q.setParameter(1, username);
            Usuario user = (Usuario)q.getSingleResult();
            if(user != null){
                if(user.getUsername().equals(username)){
                    return true;
                }
            }
            return false;
        }
        catch(NoResultException ex){
            return false;
        }
    }
    
    public Usuario getUsuario(String username){
        try{
            String jpql = "select u from Usuario u where u.username =?1";
            Query q = em.createQuery(jpql);
            q.setParameter(1, username);
            Usuario u = (Usuario)q.getSingleResult();
            return u;
        }
        catch(Exception e){
            System.err.println(e.getMessage());
            return null;
        }
    }
    
    public Usuario getUsuarioByTweetId(int tweetId){
        try{
            String sql = "SELECT U.* FROM TWEET  T, USUARIO U WHERE T.ID =?1 AND T.ID_USUARIO=U.ID";
            Query q = em.createNativeQuery(sql, Usuario.class);
            q.setParameter(1, tweetId);
            Usuario u = (Usuario)q.getSingleResult();
            return u;
        }
        catch(Exception e){
            System.err.println(e.getMessage());
            return null;
        }
    }
    
    public List<Usuario> getUsersByMatchingUsername(String username){
        try{
            String sql = "SELECT * FROM USUARIO where USERNAME LIKE ?1";
            Query q = em.createNativeQuery(sql, Usuario.class);
            q.setParameter(1, "%" + username + "%");
            List<Usuario> users = q.getResultList();
            if(users != null){
                return users;
            }
            return null;
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
