﻿using HappyPaws.Core.Entities;
using HappyPaws.Core.Models;
using HappyPaws.Core.SearchObjects;
using HappyPaws.Infrastructure.Interfaces;
using HappyPaws.Infrastructure.Other;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Infrastructure.Repositories
{
    public class ProductsRepository : BaseRepository<Product, int, ProductSearchObject>, IProductsRepository
    {
        public ProductsRepository(DatabaseContext databaseContext) : base(databaseContext)
        {
        }
        public override async Task<PagedList<Product>> GetPagedAsync(ProductSearchObject searchObject, CancellationToken cancellationToken = default)
        {
            return await DbSet.Include(x => x.ProductCategorySubcategory).ThenInclude(x => x.ProductCategory)
                .Include(x => x.ProductCategorySubcategory).ThenInclude(x => x.ProductSubcategory)
                .Include(x => x.ProductImages.Take(searchObject.TakePhotos)).ThenInclude(x => x.Image)
                .Where(x => (searchObject.SubcategoryId==null || x.ProductCategorySubcategory.ProductSubcategoryId == searchObject.SubcategoryId)
                && (searchObject.CategoryId == null || x.ProductCategorySubcategory.ProductCategoryId == searchObject.CategoryId)
                && (searchObject.ProductOrBrandName == null || (x.Name.Contains(searchObject.ProductOrBrandName) || x.Brand.Name.Contains(searchObject.ProductOrBrandName)))
                ).ToPagedListAsync(searchObject, cancellationToken);
        }
        public override async Task<Product?> GetByIdAsync(int id, CancellationToken cancellationToken = default)
        {
            return await DbSet
                .Include(x=>x.ProductImages).ThenInclude(x=>x.Image)
                .FirstOrDefaultAsync(x=>x.Id==id, cancellationToken);
        }

    }
}

