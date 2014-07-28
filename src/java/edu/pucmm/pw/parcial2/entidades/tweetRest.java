/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package edu.pucmm.pw.parcial2.entidades;

import java.io.Serializable;

/**
 *
 * @author DavidA
 */
public class tweetRest implements Serializable{
    
    public String contenido;
    public String imagenNombre;
    public byte[] imagen;
    public boolean isPublic;
    public String username;
    
    public tweetRest(){
    
    }
    
}
