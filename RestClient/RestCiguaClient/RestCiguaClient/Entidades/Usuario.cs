using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RestCiguaClient.Entidades
{
    class Usuario
    {
        public int id { get; set; }
        public string apellido { get; set; }
        public DateTime fechaNacimiento { get; set; }
        public String fotoUsuario { get; set; }
        public String nombre { get; set; }
        public String password { get; set; }
        public String username { get; set; }
        public List<Usuario> usuarioList { get; set; }
        public List<Usuario> usuarioList1 { get; set; }
        public List<Hashtag> hashtagList { get; set; }
        public List<Tweet> tweetList { get; set; }

            public Usuario() {
    }

    public Usuario(int id) {
        this.id = id;
    }

    public Usuario(int id, String password, String username) {
        this.id = id;
        this.password = password;
        this.username = username;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getApellido() {
        return apellido;
    }

    public void setApellido(String apellido) {
        this.apellido = apellido;
    }

    public DateTime getFechaNacimiento()
    {
        return fechaNacimiento;
    }

    public void setFechaNacimiento(DateTime fechaNacimiento)
    {
        this.fechaNacimiento = fechaNacimiento;
    }

    public String getFotoUsuario() {
        return fotoUsuario;
    }

    public void setFotoUsuario(String fotoUsuario) {
        this.fotoUsuario = fotoUsuario;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public List<Usuario> getUsuarioList() {
        return usuarioList;
    }

    public void setUsuarioList(List<Usuario> usuarioList) {
        this.usuarioList = usuarioList;
    }

    public List<Usuario> getUsuarioList1() {
        return usuarioList1;
    }

    public void setUsuarioList1(List<Usuario> usuarioList1) {
        this.usuarioList1 = usuarioList1;
    }

    public List<Hashtag> getHashtagList() {
        return hashtagList;
    }

    public void setHashtagList(List<Hashtag> hashtagList) {
        this.hashtagList = hashtagList;
    }

    public List<Tweet> getTweetList() {
        return tweetList;
    }

    public void setTweetList(List<Tweet> tweetList) {
        this.tweetList = tweetList;
    }

    }
}
