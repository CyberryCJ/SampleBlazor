using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace StudentRegBlazor.Shared
{
   public  class StudentShared
    {
        public string Id { get; set; }

        [Required]
        public string FirstName { get; set; }
        public string Mi { get; set; }
        public string LastName { get; set; }
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}")]
        [DataType(DataType.Date)]
        public DateTime Birthdate { get; set; }
        public string Address { get; set; }
        [MaxLength(100)]
        public string Email { get; set; }
        [MaxLength(50)]
        [MinLength(2)]
        public string UserName { get; set; }
        [MaxLength(50)]
        [MinLength(8)]
        public string Password { get; set; }
        public string Token { get; set; }
    }
}
