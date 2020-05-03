<?php

namespace App\Controller\User;

use App\Entity\User;
use Symfony\Component\HttpFoundation\JsonResponse;
use Doctrine\ORM\EntityManagerInterface;

class GetController
{
    public function index(
        int $id,
        EntityManagerInterface $em
    ) {
        $repository = $em->getRepository(User::class);
        $user = $repository->find($id);

        return new JsonResponse([
            'users' => array_map(
                function (User $user) {
                    return [
                        'id' => $user->getId(),
                        'display_name' => $user->getDisplayName(),
                    ];
                },
                [$user]
            ),
        ]);
    }
}
