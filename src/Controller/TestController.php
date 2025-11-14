<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Attribute\Route;

class TestController extends AbstractController
{
    #[Route(path: '/', name: 'index', methods: ['GET'])]
    public function index(): Response
    {
        $users = [
            ['id' => 1, 'name' => 'John Doe', 'email' => 'john@example.com', 'role' => 'Admin'],
            ['id' => 2, 'name' => 'Jane Smith', 'email' => 'jane@example.com', 'role' => 'User'],
            ['id' => 3, 'name' => 'Bob Johnson', 'email' => 'bob@example.com', 'role' => 'Moderator'],
            ['id' => 4, 'name' => 'Alice Brown', 'email' => 'alice@example.com', 'role' => 'User'],
        ];

        $serverData = [
            'currentTime' => new \DateTime(),
            'phpVersion' => PHP_VERSION,
            'symfonyVersion' => 7.3,
            'users' => [
                ['name' => 'Admin User', 'role' => 'Administrator'],
                ['name' => 'Demo User', 'role' => 'User'],
            ]
        ];
        
        return $this->render('index.html.twig', [
            'server_data' => $serverData,
            'users' => $users
        ]);
    }
    
    #[Route('/page-with-vue', name: 'vue_page')]
    public function vuePage(): Response
    {
        return $this->render('vue_page.html.twig');
    }

    #[Route('/api/users', name: 'api_users', methods: ['GET'])]
    public function getUsers(): JsonResponse
    {
        // В реальном приложении здесь будет запрос к БД
        $users = [
            ['id' => 1, 'name' => 'John Doe', 'email' => 'john@example.com'],
            ['id' => 2, 'name' => 'Jane Smith', 'email' => 'jane@example.com'],
            ['id' => 3, 'name' => 'Bob Johnson', 'email' => 'bob@example.com'],
        ];
        sleep(1);
        return $this->json($users);
    }
}
