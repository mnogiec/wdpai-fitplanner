<?php

require_once 'AppController.php';

class SecurityController extends AppController { 

    public function login() {
        if($this->isGet()) {
            return $this->render('login');
        }

        //TODO check if user is authenticated
        $email = $_POST['email'];
        $password = $_POST['password'];

        $url = "http://$_SERVER[HTTP_HOST]";
        header("Location: {$url}/dashboard");
    }
}