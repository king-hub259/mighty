<?php

namespace App\Enums;

enum RoleEnum: int
{
    case SUPERADMIN = 1;
    case ADMIN = 2;
    case MANAGER = 3;
    case EMPLOYEE = 4;
}
