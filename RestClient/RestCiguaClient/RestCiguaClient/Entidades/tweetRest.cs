using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RestCiguaClient.Entidades
{
    class tweetRest
    {
        public string contenido { get; set; }
        public string imagenNombre { get; set; }
        public byte[] imagen { get; set; }
        public bool isPublic { get; set; }
        public string username { get; set; }

        public tweetRest()
        {

        }
    }
}
