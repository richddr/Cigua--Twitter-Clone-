using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RestCiguaClient.Entidades
{
    class Estadistica
    {
        public long CantTweets { get; set; }
        public long FollowersCount { get; set; }
        public long FollowingCount { get; set; }
        public Estadistica()
        {

        }
    }
}
