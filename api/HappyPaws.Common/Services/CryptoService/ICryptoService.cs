using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Common.Services.CryptoService
{
    public interface ICryptoService
    {
        string GenerateSalt();
        string GenerateHash(string input, string salt);
        string CleanSalt(string salt);
        bool Verify(string hash, string salt, string input);
    }
}
