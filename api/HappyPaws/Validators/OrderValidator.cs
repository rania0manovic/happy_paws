﻿using FluentValidation;
using HappyPaws.Core.Dtos.Order;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HappyPaws.Application.Validators
{
    public class OrderValidator : AbstractValidator<OrderDto>
    {
        public OrderValidator()
        {

        }
    }
}
