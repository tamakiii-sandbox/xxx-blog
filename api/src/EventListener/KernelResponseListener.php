<?php

namespace App\EventListener;

use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpKernel\Event\ResponseEvent;

class KernelResponseListener
{
    public function onKernelResponse(ResponseEvent $event)
    {
        if ($json = self::getJsonResponse($event->getResponse())) {
            $event->setResponse($json);
        }
    }

    private static function getJsonResponse(Response $response): ?JsonResponse
    {
        if (!$response instanceof JsonResponse) {
            if ($response instanceof Response) {
                if ($response->getStatusCode() != 200) {
                    return new JsonResponse(
                        ['error' => $response->getContent()],
                        $response->getStatusCode(),
                    );
                } else {
                    return new JsonResponse(
                        ['content' => $response->getContent()],
                        $response->getStatusCode(),
                    );
                }
            } elseif (is_array($response)) {
                return new JsonResponse($response, 200);
            }
        }

        return null;
    }
}
