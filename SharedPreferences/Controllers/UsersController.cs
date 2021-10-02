using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using SharedPreferences.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SharedPreferences.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class UsersController : ControllerBase
    {
        SharedPreferencesDbContext _context;

        public UsersController(SharedPreferencesDbContext context)
        {
            this._context = context;
        }

        [HttpGet("All")]
        public IActionResult GetUser()
        {
            var result = _context.Users.ToList();
            return Ok(result);
        }

        [HttpPost]
        public IActionResult GetUser(UserInput user)
        {
            var result = _context.Users.
                FirstOrDefault(u => u.UserName == user.UserName && u.Password == user.Password);

            if(result != null)
            {
                return Ok(result);
            }
            else
            {
                return BadRequest(new {
                    error = "Credenciales invalidas"
                });
            }
        }
    }
}
