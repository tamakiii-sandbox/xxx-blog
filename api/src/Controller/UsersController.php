<?php

namespace App\Controller;

use App\Entity\User;
use Symfony\Component\HttpFoundation\JsonResponse;
use Doctrine\ORM\EntityManagerInterface;

class UsersController
{
    public function index(EntityManagerInterface $em)
    {
        $repository = $em->getRepository(User::class);
        $users = $repository->findAll();

        return new JsonResponse([
            'users' => array_map(
                function (User $user) {
                    return [
                        'id' => $user->getId(),
                        'display_name' => $user->getDisplayName(),
                    ];
                },
                $users
            ),
        ]);
    }
}
