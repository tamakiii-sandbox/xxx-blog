<?php
namespace App\Controller;

use App\Entity\User;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Response;
use Doctrine\ORM\EntityManagerInterface;

class LuckyController
{
    public function number(EntityManagerInterface $em)
    {
        $number = random_int(0, 100);

        $repository = $em->getRepository(User::class);
        $users = $repository->findAll();

        return new JsonResponse([
          'luckey_number' => $number,
          'users' => array_map(
              function(User $user) {
                  return [
                      'id' => $user->getId(),
                      'display_name' => $user->getDisplayName(),
                  ];
              }, $users),
        ]);
    }
}
