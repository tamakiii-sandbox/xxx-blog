<?php

namespace App\Controller\User;

use App\ArrayIterator;
use App\Entity\User;
use Symfony\Component\HttpFoundation\JsonResponse;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Validator\ConstraintViolationInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;
use Symfony\Component\HttpKernel\Exception\NotFoundHttpException;

class DeleteController
{
    public function index(
        int $id,
        Request $request,
        EntityManagerInterface $em,
        ValidatorInterface $validator
    ) {
        $repository = $em->getRepository(User::class);
        $user = $repository->find($id);

        if (!$user instanceof User) {
            throw new NotFoundHttpException('User not found');
        }

        $em->remove($user);
        $em->flush();

        return new JsonResponse([
            'users' => [],
        ]);
    }
}
