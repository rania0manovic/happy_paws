using HappyPaws.Infrastructure.Interfaces;
using HappyPaws.Infrastructure.Repositories;
using Microsoft.Extensions.DependencyInjection;

namespace HappyPaws.Infrastructure
{
    public static class Registry
    {
        public static void AddInfrastructure(this IServiceCollection services)
        {
            services.AddScoped<IAddressesRepository, AddressesRepository>();
            services.AddScoped<IAppointmentsRepository, AppointmentsRepository>();
            services.AddScoped<IBrandsRepository, BrandsRepository>();
            services.AddScoped<ICitiesRepository, CitiesRepository>();
            services.AddScoped<ICountriesRepository, CountriesRepository>();
            services.AddScoped<IEmployeesRepository, EmployeesRepository>();
            services.AddScoped<IImagesRepository, ImagesRepository>();
            services.AddScoped<IOrdersRepository, OrdersRepository>();
            services.AddScoped<IPetAllergiesRepository, PetAllergiesRepository>();
            services.AddScoped<IPetMedicationsRepository, PetMedicationsRepository>();
            services.AddScoped<IPetBreedsRepository, PetBreedsRepository>();
            services.AddScoped<IPetsRepository, PetsRepository>();
            services.AddScoped<IPetTypesRepository, PetTypesRepository>();
            services.AddScoped<IProductCategoriesRepository, ProductCategoriesRepository>();
            services.AddScoped<IProductImagesRepository, ProductImagesRepository>();
            services.AddScoped<IProductReviewsRepository, ProductReviewsRepository>();
            services.AddScoped<IProductsRepository, ProductsRepository>();
            services.AddScoped<IProductSubcategoriesRepository, ProductSubcategoriesRepository>();
            services.AddScoped<IUserCartsRepository, UserCartsRepository>();
            services.AddScoped<IUserFavouritesRepository, UserFavouritesRepository>();
            services.AddScoped<IUsersRepository, UsersRepository>();
            services.AddScoped<IEmailVerificationRequestsRepository, EmailVerificationRequestsRepository>();
            services.AddScoped<IProductCategorySubcategoriesRepository, ProductCategorySubcategoriesRepository>();

            services.AddScoped<IUnitOfWork, UnitOfWork>();

        }
    }
}
