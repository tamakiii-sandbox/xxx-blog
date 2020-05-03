<?php

namespace App\EventListener;

use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpKernel\Event\ExceptionEvent;
use Symfony\Component\HttpKernel\Exception\HttpExceptionInterface;

class ExceptionListener
{
    public function onKernelException(ExceptionEvent $event)
    {
        $exception = $event->getThrowable();

        if ($exception instanceof HttpExceptionInterface) {
            $response = new JsonResponse([
                'error' => [
                    'message' => $exception->getMessage(),
                    'code' => $exception->getStatusCode(),
                ]
            ]);
            $response->headers->replace($exception->getHeaders());
        } else {
            $response = new JsonResponse([
                'error' => [
                    'message' => $exception->getMessage(),
                    'code' => Response::HTTP_INTERNAL_SERVER_ERROR,
                ]
            ]);
        }

        $event->setResponse($response);
    }
}
