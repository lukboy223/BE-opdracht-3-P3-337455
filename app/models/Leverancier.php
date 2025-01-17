<?php

class Leverancier
{
    private $db;

    public function __construct()
    {
        $this->db = new Database();
    }

    public function LeverancierOverzicht($offset, $itemsPerPage){
        try {

            $sql = "CALL spReadLeverancierLimit(:offset, :itemsPerPage)";
            $this->db->query($sql);
            $this->db->bind(':offset', $offset, PDO::PARAM_INT);
            $this->db->bind(':itemsPerPage', $itemsPerPage, PDO::PARAM_INT);

            return $this->db->resultSet();
            
        } catch (Exception $e) {
            
            logger(__LINE__, __METHOD__, __FILE__, $e->getMessage());
        }
    }
    public function getTotalLeveranciers()
    {
        try {
            $sql = "SELECT COUNT(*) as total FROM Leverancier";
            $this->db->query($sql);
            return $this->db->single()->total;
        } catch (Exception $e) {
            logger(__LINE__, __METHOD__, __FILE__, $e->getMessage());
        }
    }
    public function ReadContactById(int $id){
        try {

            $sql = "CALL spReadContactById($id)";

            $this->db->query($sql);

            return $this->db->single();
            
        } catch (Exception $e) {
            
            logger(__LINE__, __METHOD__, __FILE__, $e->getMessage());
        }
    }
    public function ReadProductLeverancierByLevId($id){
        try {

            $sql = "CALL spReadProductLeverancierByLevId($id)";

            $this->db->query($sql);

            return $this->db->resultSet();
            
        } catch (Exception $e) {
            
            logger(__LINE__, __METHOD__, __FILE__, $e->getMessage());
        }
    }
    public function ReadLeverancierById($id){
        try {

            $sql = "CALL spReadLeverancierById($id)";

            $this->db->query($sql);

            return $this->db->single();
            
        } catch (Exception $e) {
            
            logger(__LINE__, __METHOD__, __FILE__, $e->getMessage());
        }
    }
    public function ReadProductLeverancierByProId($productId)
    {
        try {

            $sql = "CALL spReadProductLeverancierByProId(:id)";

            $this->db->query($sql);

            $this->db->bind(':id', $productId, PDO::PARAM_INT);

            return $this->db->resultSet();
            
        } catch (Exception $e) {
            
            logger(__LINE__, __METHOD__, __FILE__, $e->getMessage());
        }
    }
    public function UpdateLeverancierPerProduct($data){
        try {

            $sql = "CALL spUpdateLeverancierPerProduct(:PPLID, :DatumLev, :AantalLev)";

            $this->db->query($sql);

            $this->db->bind(':PPLID', $data['PPLId'], PDO::PARAM_INT);
            $this->db->bind(':DatumLev', $data['DatumLev'], PDO::PARAM_STR);
            $this->db->bind(':AantalLev', $data['AantalLev'], PDO::PARAM_INT);

            return $this->db->execute();
            
        } catch (Exception $e) {
            
            logger(__LINE__, __METHOD__, __FILE__, $e->getMessage());
        }
    }
    public function UpdateLeverancier($data){
        try {

            $sql = "CALL hujihyhujspUpdateLeverancier(:LeverancierId, :LeverancierNaam, :ContactPersoon, :LeverancierNummer, :Mobiel, :ContactId, :Straat, :Huisnummer, :Postcode, :Stad)";

            $this->db->query($sql);

            $this->db->bind(':LeverancierId', $data['LeverancierId'], PDO::PARAM_INT);
            $this->db->bind(':LeverancierNaam', $data['LeverancierNaam'], PDO::PARAM_STR);
            $this->db->bind(':ContactPersoon', $data['ContactPersoon'], PDO::PARAM_STR);
            $this->db->bind(':LeverancierNummer', $data['LeverancierNummer'], PDO::PARAM_STR);
            $this->db->bind(':ContactId', $data['ContactId'], PDO::PARAM_INT);
            $this->db->bind(':Mobiel', $data['Mobiel'], PDO::PARAM_STR);
            $this->db->bind(':Straat', $data['Straat'], PDO::PARAM_STR);
            $this->db->bind(':Huisnummer', $data['Huisnummer'], PDO::PARAM_STR);
            $this->db->bind(':Postcode', $data['Postcode'], PDO::PARAM_STR);
            $this->db->bind(':Stad', $data['Stad'], PDO::PARAM_STR);

            return $this->db->execute();
            
        } catch (Exception $e) {
            return false;
            logger(__LINE__, __METHOD__, __FILE__, $e->getMessage());
        }
    }
}
