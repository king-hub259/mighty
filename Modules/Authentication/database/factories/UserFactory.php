<?php

namespace Modules\Authentication\Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;

class UserFactory extends Factory
{
    /**
     * The name of the factory's corresponding model.
     */
    protected $model = \Modules\Authentication\Models\User::class;

    /**
     * Define the model's default state.
     */
    public function definition(): array
    {
        return [
            'institute_id' => 1,
            'branch_id' => 1,
            'name' => $this->faker->name(),
            'email' => $this->faker->unique()->safeEmail(),
            'password' => Hash::make('12345678'), // default password for testing
            'phone' => $this->faker->unique()->phoneNumber(),
            'image' => 'profile.png', // default image
            'role_id' => 1, // default role
            'email_verified_at' => now(),
            'status' => 1, // default status
            'user_type' => 'Admin', // default user type
            'facebook' => $this->faker->url(),
            'twitter' => $this->faker->url(),
            'linkedin' => $this->faker->url(),
            'google_plus' => $this->faker->url(),
            'user_status' => 1, // default user status
            'remember_token' => Str::random(10),
            'deleted_at' => null, // no soft delete by default
        ];
    }
}
