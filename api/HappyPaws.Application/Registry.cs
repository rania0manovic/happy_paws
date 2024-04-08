using FluentValidation;
using HappyPaws.Application.Interfaces;
using HappyPaws.Application.Services;
using HappyPaws.Application.Validators;
using HappyPaws.Core.Dtos.Address;
using HappyPaws.Core.Dtos.Allergy;
using HappyPaws.Core.Dtos.Appointment;
using HappyPaws.Core.Dtos.Brand;
using HappyPaws.Core.Dtos.City;
using HappyPaws.Core.Dtos.Country;
using HappyPaws.Core.Dtos.EmailVerificationRequest;
using HappyPaws.Core.Dtos.Employee;
using HappyPaws.Core.Dtos.Image;
using HappyPaws.Core.Dtos.Order;
using HappyPaws.Core.Dtos.Pet;
using HappyPaws.Core.Dtos.PetAllergy;
using HappyPaws.Core.Dtos.PetBreed;
using HappyPaws.Core.Dtos.PetMedication;
using HappyPaws.Core.Dtos.PetType;
using HappyPaws.Core.Dtos.Product;
using HappyPaws.Core.Dtos.ProductCategory;
using HappyPaws.Core.Dtos.ProductCategorySubcategory;
using HappyPaws.Core.Dtos.ProductImage;
using HappyPaws.Core.Dtos.ProductReview;
using HappyPaws.Core.Dtos.ProductSubcategory;
using HappyPaws.Core.Dtos.User;
using HappyPaws.Core.Dtos.UserCart;
using HappyPaws.Core.Dtos.UserFavourite;
using Microsoft.Extensions.DependencyInjection;

namespace HappyPaws.Application
{
    public static class Registry
    {
        public static void AddApplication(this IServiceCollection services)
        {
            services.AddScoped<IAddressesService, AddressesService>();
            services.AddScoped<IAppointmentsService, AppointmentsService>();
            services.AddScoped<IBrandsService, BrandsService>();
            services.AddScoped<ICitiesService, CitiesService>();
            services.AddScoped<ICountriesService, CountriesService>();
            services.AddScoped<IEmployeesService, EmployeesService>();
            services.AddScoped<IImagesService, ImagesService>();
            services.AddScoped<IOrdersService, OrdersService>();
            services.AddScoped<IPetAllergiesService, PetAllergiesService>();
            services.AddScoped<IPetMedicationsService, PetMedicationsService>();
            services.AddScoped<IPetBreedsService, PetsBreedsService>();
            services.AddScoped<IPetsService, PetsService>();
            services.AddScoped<IPetTypesService, PetTypesService>();
            services.AddScoped<IProductCategoriesService, ProductCategoriesService>();
            services.AddScoped<IProductImageService, ProductImagesService>();
            services.AddScoped<IProductReviewsService, ProductReviewsService>();
            services.AddScoped<IProductsService, ProductsService>();
            services.AddScoped<IProductSubcategoriesService, ProductSubcategoriesService>();
            services.AddScoped<IUserCartsService, UserCartsService>();
            services.AddScoped<IUserFavouritesService, UserFavouritesService>();
            services.AddScoped<IUsersService, UsersService>();
            services.AddScoped<IEmailVerificationRequestsService, EmailVerificationRequestsService>();
            services.AddScoped<IProductCategorySubcategoriesService, ProductCategorySubcategoriesService>();
        }

        public static void AddValidators(this IServiceCollection services)
        {
            services.AddScoped<IValidator<AddressDto>, AddressValidator>();
            services.AddScoped<IValidator<AppointmentDto>, AppointmentValidator>();
            services.AddScoped<IValidator<BrandDto>, BrandValidator>();
            services.AddScoped<IValidator<CityDto>, CityValidator>();
            services.AddScoped<IValidator<CountryDto>, CountryValidator>();
            services.AddScoped<IValidator<EmployeeDto>, EmployeeValidator>();
            services.AddScoped<IValidator<ImageDto>, ImageValidator>();
            services.AddScoped<IValidator<OrderDto>, OrderValidator>();
            services.AddScoped<IValidator<PetAllergyDto>, PetAllergyValidator>();
            services.AddScoped<IValidator<PetMedicationDto>, PetMedicationValidator>();
            services.AddScoped<IValidator<PetBreedDto>, PetBreedValidator>();
            services.AddScoped<IValidator<PetDto>, PetValidator>();
            services.AddScoped<IValidator<PetTypeDto>, PetTypeValidator>();
            services.AddScoped<IValidator<ProductCategoryDto>, ProductCategoryValidator>();
            services.AddScoped<IValidator<ProductImageDto>, ProductImageValidator>();
            services.AddScoped<IValidator<ProductReviewDto>, ProductReviewValidator>();
            services.AddScoped<IValidator<ProductDto>, ProductValidator>();
            services.AddScoped<IValidator<ProductSubcategoryDto>, ProductSubcategoryValidator>();
            services.AddScoped<IValidator<UserCartDto>, UserCartValidator>();
            services.AddScoped<IValidator<UserFavouriteDto>, UserFavouriteValidator>();
            services.AddScoped<IValidator<UserDto>, UserValidator>();
            services.AddScoped<IValidator<EmailVerificationRequestDto>, EmailVerificationRequestValidator>();
            services.AddScoped<IValidator<ProductCategorySubcategoryDto>, ProductCategorySubcategoryValidator>();
        }
    }
}
