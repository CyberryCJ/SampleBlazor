using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using StudentRegBlazor.Server.Model;
using StudentRegBlazor.Server.Services;

namespace StudentRegBlazor.Server.Controllers
{
    [Route("api/[controller]")]
    public class StudentController : Controller
    {
        readonly IStudentServices _iStudent;

        public StudentController(IStudentServices studentServices)
        {
            _iStudent = studentServices;
        }

        [HttpGet("[action]")]
        public async Task<List<Students>> StudentList()
        {
            var ss = await _iStudent.StudentList();
            return ss;
        }

        [HttpPost("[action]")]
        public async Task Create([FromBody] Students students)
        {
           
            if(ModelState.IsValid)
           await _iStudent.AddStudent(students);

        }

        [HttpPut("[action]")]
        public async Task Edit([FromBody] Students students)
        {

            if (ModelState.IsValid)
                await _iStudent.UpdateStudent(students);

        }

        [HttpDelete("[action]")]
        public async Task Delete([FromBody] Students students)
        {

            if (ModelState.IsValid)
                await _iStudent.DeleteStudent(students);

        }

        [HttpPost("[action]")]
        public async Task<List<Students>> Login([FromBody] Students students)
        {
         
            var ss = await _iStudent.Check(students.UserName, students.Password);
            return ss;

        }


    }
}
