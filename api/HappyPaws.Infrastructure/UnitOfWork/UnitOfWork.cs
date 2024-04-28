using HappyPaws.Infrastructure.Interfaces;
using Microsoft.EntityFrameworkCore.Storage;

namespace HappyPaws.Infrastructure
{
    public class UnitOfWork : IUnitOfWork
    {
        private readonly DatabaseContext _databaseContext;
        public readonly IUserAddressesRepository UserAddressesRepository;
        public readonly IAppointmentsRepository AppointmentsRepository;
        public readonly IBrandsRepository BrandsRepository;
        public readonly ICitiesRepository CitiesRepository;
        public readonly ICountriesRepository CountriesRepository;
        public readonly IEmployeesRepository EmployeesRepository;
        public readonly IImagesRepository ImagesRepository;
        public readonly IOrdersRepository OrdersRepository;
        public readonly IOrderDetailsRepository OrderDetailsRepository;
        public readonly IPetAllergiesRepository PetAllergiesRepository;
        public readonly IPetMedicationsRepository PetMedicationsRepository;
        public readonly IPetBreedsRepository PetBreedsRepository;
        public readonly IPetsRepository PetsRepository;
        public readonly IPetTypesRepository PetTypesRepository;
        public readonly IProductCategoriesRepository ProductCategoriesRepository;
        public readonly IProductImagesRepository ProductImagesRepository;
        public readonly IProductReviewsRepository ProductReviewsRepository;
        public readonly IProductsRepository ProductsRepository;
        public readonly IProductSubcategoriesRepository ProductSubcategoriesRepository;
        public readonly IUserCartsRepository UserCartsRepository;
        public readonly IUserFavouritesRepository UserFavouritesRepository;
        public readonly IUsersRepository UsersRepository;
        public readonly IEmailVerificationRequestsRepository EmailVerificationRequestsRepository;
        public readonly IProductCategorySubcategoriesRepository ProductCategorySubcategoriesRepository;
        public readonly INotificationsRepository NotificationsRepository;
        public readonly IDonationsRepository DonationsRepository;

        public UnitOfWork(DatabaseContext databaseContext, IAppointmentsRepository appointmentsRepository, IBrandsRepository brandsRepository, ICitiesRepository citiesRepository, ICountriesRepository countriesRepository, IEmployeesRepository employeesRepository, IImagesRepository imagesRepository, IOrdersRepository ordersRepository, IPetAllergiesRepository petAllergiesRepository, IPetBreedsRepository petBreedsRepository, IPetsRepository petsRepository, IPetTypesRepository petTypesRepository, IProductCategoriesRepository productCategoriesRepository, IProductImagesRepository productImagesRepository, IProductReviewsRepository productReviewsRepository, IProductsRepository productsRepository, IProductSubcategoriesRepository productSubcategoriesRepository, IUserCartsRepository userCartsRepository, IUserFavouritesRepository userFavouritesRepository, IUsersRepository usersRepository, IEmailVerificationRequestsRepository emailVerificationRequestsRepository, IProductCategorySubcategoriesRepository productCategorySubcategoryRepository, IPetMedicationsRepository petMedicationsRepository, IUserAddressesRepository userAddressesRepository, IOrderDetailsRepository orderDetailsRepository, INotificationsRepository notificationsRepository, IDonationsRepository donationsRepository)
        {
            _databaseContext = databaseContext;
            AppointmentsRepository = appointmentsRepository;
            BrandsRepository = brandsRepository;
            CitiesRepository = citiesRepository;
            CountriesRepository = countriesRepository;
            EmployeesRepository = employeesRepository;
            ImagesRepository = imagesRepository;
            OrdersRepository = ordersRepository;
            PetAllergiesRepository = petAllergiesRepository;
            PetBreedsRepository = petBreedsRepository;
            PetsRepository = petsRepository;
            PetTypesRepository = petTypesRepository;
            ProductCategoriesRepository = productCategoriesRepository;
            ProductImagesRepository = productImagesRepository;
            ProductReviewsRepository = productReviewsRepository;
            ProductsRepository = productsRepository;
            ProductSubcategoriesRepository = productSubcategoriesRepository;
            UserCartsRepository = userCartsRepository;
            UserFavouritesRepository = userFavouritesRepository;
            UsersRepository = usersRepository;
            EmailVerificationRequestsRepository = emailVerificationRequestsRepository;
            ProductCategorySubcategoriesRepository = productCategorySubcategoryRepository;
            PetMedicationsRepository = petMedicationsRepository;
            UserAddressesRepository = userAddressesRepository;
            OrderDetailsRepository = orderDetailsRepository;
            NotificationsRepository = notificationsRepository;
            DonationsRepository = donationsRepository;
        }

        public async Task<IDbContextTransaction> BeginTransactionAsync(CancellationToken cancellationToken = default)
        {
            return await _databaseContext.Database.BeginTransactionAsync(cancellationToken);
        }

        public async Task CommitTransactionAsync(CancellationToken cancellationToken = default)
        {
            await _databaseContext.Database.CommitTransactionAsync(cancellationToken);
        }

        public async Task RollbackTransactionAsync(CancellationToken cancellationToken = default)
        {
            await _databaseContext.Database.RollbackTransactionAsync(cancellationToken);
        }

        public async Task<int> SaveChangesAsync(CancellationToken cancellationToken = default)
        {
            return await _databaseContext.SaveChangesAsync(cancellationToken);
        }
    }
}
