using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;

namespace Assignment
{
    public class Security
    {

        public static string hashing(string password, string salt)
        {
            // Combine the password and salt
            string combinedPassword = password + salt;


            var sha256 = SHA256.Create();
                
            byte[] bytes = Encoding.UTF8.GetBytes(combinedPassword);

                
            byte[] hash = sha256.ComputeHash(bytes);

            string hashPassword = Convert.ToBase64String(hash);

            return hashPassword;
        }
    }
}