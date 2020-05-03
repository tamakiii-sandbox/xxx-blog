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

class UpdateController
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

        $user->setDisplayName($request->get('display_name'));

        $errors = $validator->validate($user);

        if (count($errors)) {
            return new JsonResponse([
                'errors' => ArrayIterator::map($errors, function (ConstraintViolationInterface $error) {
                    return [
                        'message' => $error->getMessageTemplate(),
                        'property_path' => $error->getPropertyPath(),
                    ];
                })
            ], 400);
        }

        $repository = $em->getRepository(User::class);
        $em->persist($user);
        $em->flush();

        $new = $repository->find($user);

        return new JsonResponse([
            'users' => array_map(
                function (User $user) {
                    return [
                        'id' => $user->getId(),
                        'display_name' => $user->getDisplayName(),
                    ];
                },
                [$new]
            ),
        ]);
    }
}
