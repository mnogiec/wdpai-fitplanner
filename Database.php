<?php

require_once 'src/utils/utils.php';

class Database
{
    private static $instance = null;
    private $username;
    private $password;
    private $host;
    private $database;
    private $port;

    public function __construct()
    {
        $this->username = env('DB_USERNAME');
        $this->password = env('DB_PASSWORD');
        $this->host = env('DB_HOST');
        $this->database = env('DB_DATABASE');
        $this->port = env('DB_PORT');
    }

    public static function getInstance()
    {
        if (self::$instance === null) {
            self::$instance = new self();
        }
        return self::$instance;
    }

    private function __clone()
    {
    }

    private function __wakeup()
    {
    }

    public function connect()
    {
        try {
            $conn = new PDO(
                "pgsql:host=$this->host;port=$this->port;dbname=$this->database",
                $this->username,
                $this->password,
                ["sslmode" => "prefer"]
            );

            $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
            return $conn;
        } catch (PDOException $e) {
            die("Connection failed: " . $e->getMessage());
        }
    }
}