using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RestCiguaClient.Entidades
{
    class Tweet
    {

        public int id { get; set; }

        public String contenido { get; set; }
        public DateTime fechaCreacion { get; set; }
        public String imagen { get; set; }
        public Boolean isPublic { get; set; }
        public List<Hashtag> hashtagList { get; set; }
        public Usuario idUsuario { get; set; }

    public Tweet() {
    }

    public Tweet(int id) {
        this.id = id;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getContenido() {
        return contenido;
    }

    public void setContenido(String contenido) {
        this.contenido = contenido;
    }

    public DateTime getFechaCreacion() {
        return fechaCreacion;
    }

    public void setFechaCreacion(DateTime fechaCreacion) {
        this.fechaCreacion = fechaCreacion;
    }

    public String getImagen() {
        return imagen;
    }

    public void setImagen(String imagen) {
        this.imagen = imagen;
    }

    public Boolean getIsPublic() {
        return isPublic;
    }

    public void setIsPublic(Boolean isPublic) {
        this.isPublic = isPublic;
    }

    public List<Hashtag> getHashtagList() {
        return hashtagList;
    }

    public void setHashtagList(List<Hashtag> hashtagList) {
        this.hashtagList = hashtagList;
    }

    public Usuario getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(Usuario idUsuario) {
        this.idUsuario = idUsuario;
    }

    }
}
