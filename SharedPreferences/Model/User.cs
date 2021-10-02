using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace SharedPreferences.Model
{
    public class User
    {
        [Key, Required, MaxLength(40)]
        public string UserName { get; set; }

        [Required]
        public string Password { get; set; }

        [Required, MaxLength(30)]
        public string Access { get; set; }

        [Required, MaxLength(20)]
        public string Color { get; set; }

        [Required, MaxLength(20)]
        public string State { get; set; }
    }
}
