using HappyPaws.Core.Dtos.Product;
using HappyPaws.Core.Dtos.UserFavourite;
using HappyPaws.Core.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Common.Services.RecommenderSystemService
{
    public class RecommenderSystemService : IRecommenderSystemService
    {
        public RecommenderSystemService()
        {
        }

        public Dictionary<int, double> CalculateUserSimilarities(int userId, List<UserFavouriteDto> favourites)
        {
            var userFavourites = favourites
                .GroupBy(f => f.UserId)
                .ToDictionary(g => g.Key, g => g.Select(f => f.ProductId).ToHashSet());

            var userSimilarity = new Dictionary<int, double>();
            if (!userFavourites.ContainsKey(userId))
                return userSimilarity;

            var targetUserProducts = userFavourites[userId];

            foreach (var userFavourite in userFavourites)
            {
                int otherUserId = userFavourite.Key;
                if (otherUserId == userId) continue;

                var otherUserProducts = userFavourite.Value;

                var commonProducts = targetUserProducts.Intersect(otherUserProducts).Count();
                var totalProducts = targetUserProducts.Union(otherUserProducts).Count();

                double similarity = (double)commonProducts / totalProducts;
                if(similarity > 0)
                userSimilarity[otherUserId] = similarity;
            }

            return userSimilarity;
        }
        public List<int> RecommendProducts(int userId, int size, List<UserFavouriteDto> favourites)
        {
            var userFavorites = favourites
           .Where(f => f.UserId == userId)
           .Select(f => f.ProductId)
           .ToHashSet();

            var userSimilarities = CalculateUserSimilarities(userId, favourites);

            var candidateProducts = new Dictionary<int, double>();

            if (!userSimilarities.Any())
                return new List<int>();

            var sortedSimilarUsers = userSimilarities.OrderByDescending(u => u.Value);

            var recommendedProductIds = new HashSet<int>();

            foreach (var similarUser in sortedSimilarUsers)
            {
                var similarUserFavorites = favourites
                    .Where(f => f.UserId == similarUser.Key)
                    .Select(f => f.ProductId);

                foreach (var product in similarUserFavorites)
                {
                    if (userFavorites.Contains(product) || recommendedProductIds.Contains(product))
                        continue;

                    if (!candidateProducts.ContainsKey(product))
                        candidateProducts[product] = 0;

                    candidateProducts[product] += similarUser.Value;
                    recommendedProductIds.Add(product);
                }
            }

            return  candidateProducts
                .OrderByDescending(p => p.Value)
                .Take(size)
                .Select(p => p.Key)
                .ToList();

        }

    }
}
