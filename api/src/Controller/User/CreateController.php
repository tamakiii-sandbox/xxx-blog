<?php

namespace App\Controller\User;

use App\ArrayIterator;
use App\Entity\User;
use Doctrine\Common\Util\Debug;
use Symfony\Component\HttpFoundation\JsonResponse;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpKernel\Exception\MethodNotAllowedHttpException;
use Symfony\Component\Validator\ConstraintViolationInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;

class CreateController
{
    public function index(
        Request $request,
        EntityManagerInterface $em,
        ValidatorInterface $validator
    ) {
        $user = User::factory(
            $request->request->get('display_name') ?? ''
        );

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
