using HappyPaws.Core.Dtos.UserFavourite;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Common.Services.RecommenderSystemService
{
    public interface IRecommenderSystemService
    {
        Dictionary<int, double> CalculateUserSimilarities(int userId, List<UserFavouriteDto> favourites);
        List<int> RecommendProducts(int userId, int size, List<UserFavouriteDto> favourites);
    }
}
