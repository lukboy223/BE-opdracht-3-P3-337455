<?php

class Magazijn
{
    private $db;

    public function __construct()
    {
        $this->db = new Database();
    }

    public function GetMagaijnProduct()
    {
        try {

            $sql = "CALL spReadMagazijnProduct()";

            $this->db->query($sql);

            return $this->db->resultSet();
            
        } catch (Exception $e) {
            
            logger(__LINE__, __METHOD__, __FILE__, $e->getMessage());
        }
    }
    public function ReadProductLeverancierById($id){
        try {

            $sql = "CALL spReadProductLeverancierById($id)";

            $this->db->query($sql);

            return $this->db->resultSet();
            
        } catch (Exception $e) {
            
            logger(__LINE__, __METHOD__, __FILE__, $e->getMessage());
        }
    }
    public function ReadProductPerAllergeenById($id){
        try {

            $sql = "CALL spReadProductPerAllergeenById($id)";

            $this->db->query($sql);

            return $this->db->resultSet();
            
        } catch (Exception $e) {
            
            logger(__LINE__, __METHOD__, __FILE__, $e->getMessage());
        }
    }
   
}
