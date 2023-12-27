using Microsoft.AspNetCore.Cryptography.KeyDerivation;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Common.Services.CryptoService
{
    public class CryptoService : ICryptoService
    {
        public string GenerateHash(string input, string salt)
        {
            var valueBytes = KeyDerivation.Pbkdf2(
                password: input,
                salt: Encoding.UTF8.GetBytes(salt),
                prf: KeyDerivationPrf.HMACSHA512,
                iterationCount: 10000,
                numBytesRequested: 256 / 8
            );

            return Convert.ToBase64String(valueBytes);
        }

        public string GenerateSalt()
        {
            byte[] randomBytes = new byte[128 / 8];

            using (var generator = RandomNumberGenerator.Create())
            {
                generator.GetBytes(randomBytes);
                return Convert.ToBase64String(randomBytes);
            }
        }
        public string CleanSalt(string salt)
        {
            return salt.Replace('+', '!');
        }
        public bool Verify(string hash, string salt, string input)
        {
            var genHash = GenerateHash(input, salt);
            return genHash == hash;
        }
    }
}

