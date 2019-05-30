using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Options;
using Microsoft.IdentityModel.Tokens;
using MySql.Data.MySqlClient;
using StudentRegBlazor.Server.Helpers;
using StudentRegBlazor.Server.Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;

namespace StudentRegBlazor.Server.Services
{
    public interface IStudentServices
    {
        Task<List<Students>> StudentList();
        Task AddStudent(Students students);
        Task UpdateStudent(Students students);
        Task DeleteStudent(Students students);
        Task<List<Students>> Check(string user, string pwd);
    }
    public class StudentServices : IStudentServices
    {
        private readonly IConfiguration _configuration;
        private MySqlParameter _param = new MySqlParameter();
        MySqlTransaction _trn;

        private readonly AppSettings _appSettings;


        public StudentServices(IConfiguration configuration, IOptions<AppSettings> appSettings)
        {
            _configuration = configuration;
            _appSettings = appSettings.Value;
        }

        public string GetConnection()
        {
            var connection = _configuration.GetSection("ConnectionStrings").GetSection("StudentContext").Value;
            return connection;
        }

        public async Task<List<Students>> StudentList()
        {
            var connectionString = this.GetConnection();
          

            List<Students> lst = new List<Students>();

            using (var con = new MySqlConnection(connectionString))
            {
                try
                {
                    await con.OpenAsync();
                    var com = new MySqlCommand("SELECt `Id`,`Fname`,`Mi`,`Lname`,`Birthday`,`Address`,`Email` FROM tblstudinfo", con)
                    {
                        CommandType = CommandType.Text
                    };
                    var rdr = (MySqlDataReader)await com.ExecuteReaderAsync();

                    while (rdr.Read())
                    {
                        lst.Add(new Students
                        {
                            Id = rdr["Id"].ToString(),
                            FirstName = rdr["Fname"].ToString(),
                            Mi = rdr["Mi"].ToString(),
                            LastName = rdr["Lname"].ToString(),
                            Birthdate = (DateTime) rdr["Birthday"],
                            Address = rdr["Address"].ToString(),
                            Email = rdr["Email"].ToString()
                        });
                    }


                    return lst.ToList();
                }
                finally { con.Close(); }

            }
        }

        public async Task AddStudent(Students students)
        {
            var connectionString = this.GetConnection();
            int i = 0;

            using (var con = new MySqlConnection(connectionString))
            {
                try
                {
                    await con.OpenAsync();
                    var com = new MySqlCommand("Insert into tblstudinfo  () VALUES (@id,@fname,@mi,@lname,@bdate,@address,@email,@user,@pwd)",
                        con)
                    {
                        CommandType = CommandType.Text
                    };
                    com.Parameters.AddWithValue("@id", students.Id);
                    com.Parameters.AddWithValue("@fname", students.FirstName);
                    com.Parameters.AddWithValue("@mi", students.Mi);
                    com.Parameters.AddWithValue("@lname", students.LastName);
                    com.Parameters.AddWithValue("@bdate", students.Birthdate);
                    com.Parameters.AddWithValue("@address", students.Address);
                    com.Parameters.AddWithValue("@email", students.Email);
                    com.Parameters.AddWithValue("@user", students.UserName);
                    com.Parameters.AddWithValue("@pwd", students.Password);
                    i = await com.ExecuteNonQueryAsync();

                    //return i;
                }
                catch (Exception)
                {
                    //
                }
                finally { con.Close(); }
                //return i;
            }
        }


        public async Task UpdateStudent(Students students)
        {
            var connectionString = this.GetConnection();
            int i = 0;

            using (var con = new MySqlConnection(connectionString))
            {
                try
                {
                    await con.OpenAsync();
                    var com = new MySqlCommand("Update tblstudinfo Set `Fname`  =  @fname, `Mi`  = @mi, `Lname` = @lname, `Birthday` =  @bdate,  `Address`  = @address  WHERE `Id` =  @id ",
                        con)
                    {
                        CommandType = CommandType.Text
                    };
                    com.Parameters.AddWithValue("@id", students.Id);
                    com.Parameters.AddWithValue("@fname", students.FirstName);
                    com.Parameters.AddWithValue("@mi", students.Mi);
                    com.Parameters.AddWithValue("@lname", students.LastName);
                    com.Parameters.AddWithValue("@bdate", students.Birthdate);
                    com.Parameters.AddWithValue("@address", students.Address);
                    i = await com.ExecuteNonQueryAsync();

                    //return i;
                }
                catch (Exception)
                {
                    //
                }
                finally { con.Close(); }
                //return i;
            }
        }

        public async Task DeleteStudent(Students students)
        {
            var connectionString = this.GetConnection();
            int i = 0;

            using (var con = new MySqlConnection(connectionString))
            {
                try
                {
                    await con.OpenAsync();
                    var com = new MySqlCommand("DELETE FROM tblstudinfo  WHERE `Id` =  @id ",
                        con)
                    {
                        CommandType = CommandType.Text
                    };
                    com.Parameters.AddWithValue("@id", students.Id);
                    i = await com.ExecuteNonQueryAsync();

                    //return i;
                }
                catch (Exception)
                {
                    //
                }
                finally { con.Close(); }
                //return i;
            }
        }

        public async Task<List<Students>> Check(string user,string pwd)
        {
            var connectionString = this.GetConnection();


            List<Students> lst = new List<Students>();

            using (var con = new MySqlConnection(connectionString))
            {
                try
                {
                    await con.OpenAsync();
                    _trn = await con.BeginTransactionAsync().ConfigureAwait(true);
                    var com = new MySqlCommand("SELECt `Id`,`Fname`,`Mi`,`Lname`,`Email` FROM tblstudinfo Where UserName = @user  AND Pwd = @pwd", con)
                    {
                        CommandType = CommandType.Text
                    };

                    com.Parameters.Clear();
                    com.Parameters.AddWithValue("@user", user);
                    com.Parameters.AddWithValue("@pwd", pwd);


                    var rdr = await com.ExecuteReaderAsync();

                    if (rdr.Read())
                    {

                        lst.Add(new Students
                        {
                            Id = rdr["Id"].ToString(),
                            FirstName = rdr["Fname"].ToString(),
                            Mi = rdr["Mi"].ToString(),
                            LastName = rdr["Lname"].ToString(),
                            Email = rdr["Email"].ToString()


                        });

                        // authentication successful so generate jwt token
                        var tokenHandler = new JwtSecurityTokenHandler();
                        var key = Encoding.ASCII.GetBytes(_appSettings.Secret);
                        var tokenDescriptor = new SecurityTokenDescriptor
                        {
                            Subject = new ClaimsIdentity(new Claim[]
                            {
                                 new Claim(ClaimTypes.Name, lst[0].Id.ToString())
                            }),
                            Expires = DateTime.UtcNow.AddMinutes(20),
                            SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256Signature)
                        };
                        var token = tokenHandler.CreateToken(tokenDescriptor);
                        lst[0].Token = tokenHandler.WriteToken(token);
                    }
                   
                    rdr.Close();
                    _trn.Commit();
                    return lst.ToList();
                }
                catch (Exception ex)
                {
                    _trn.Rollback();
                }
                finally { con.Close(); }
                return lst.ToList();
            }
        }


    }
}
