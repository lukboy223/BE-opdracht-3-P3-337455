<?php

class Magazijns extends BaseController
{
    private $magaijnModel;

    public function __construct()
    {
        $this->magaijnModel = $this->model('Magazijn');
    }

    public function index()
    {

        $data = [
            'Magazijn'             => null,
            'message'               => '',
            'messageColor'          => '',
            'messageVisibility'     => 'none'
        ];

        $data['Magazijn'] = $this->magaijnModel->GetMagaijnProduct();
        if (is_null($data['Magazijn'])) {
            $this->indexError();
        }

        $this->view('magazijns/index', $data);
    }

    public function indexError($errorMessage = "Er is een probleem opgetreden met de database probeer het opnieuw op een later moment.")
    {
        $data = [
            'Magazijn'             => null,
            'message'               => $errorMessage,
            'messageColor'          => 'alert-danger',
            'messageVisibility'     => 'flex'
        ];

        $data['Magazijn'] = $this->magaijnModel->GetMagaijnProduct();

        $this->view('magazijns/index', $data);
    }

    public function viewLeverancier($id = 0, $Aantal = null)
    {

        $products = $this->magaijnModel->ReadProductLeverancierById($id);

        if (empty($products)) {
            $this->indexError("Geen informatie gevonden met dat product Id.");
        } else if ($Aantal == 0) {
            $data = [
                "LeverancierNaam"       => $products[0]->LeverancierNaam,
                "ContactPersoon"        => $products[0]->ContactPersoon,
                "LeverancierNummer"     => $products[0]->LeverancierNummer,
                "Mobiel"                => $products[0]->Mobiel,
                "Products"              => $products,
                'message'               => "Er is van dit product op dit moment geen voorraad aanwezig, de verwachte eerstvolgende levering is: " . $products[0]->DatumEerstVolgendeLevering,
                'messageColor'          => 'alert-danger',
                'messageVisibility'     => 'flex'
            ];
            $this->view('Magazijns/viewLeverancier', $data);

            header('Refresh:4;' .  URLROOT . '/Magazijns/index');
        } else {
            $data = [
                "LeverancierNaam"       => $products[0]->LeverancierNaam,
                "ContactPersoon"        => $products[0]->ContactPersoon,
                "LeverancierNummer"     => $products[0]->LeverancierNummer,
                "Mobiel"                => $products[0]->Mobiel,
                "Products"              => $products,
                'message'               => '0',
                'messageColor'          => '',
                'messageVisibility'     => 'none'
            ];
            $this->view('Magazijns/viewLeverancier', $data);
        }
    }

    public function viewAllergenen($id = 0)
    {
        $Allergenen = $this->magaijnModel->ReadProductPerAllergeenById($id);

        if (empty($Allergenen)) {
            $data = [
                'message'               => 'Geen allergenen gevonden voor dit product.',
                'messageColor'          => 'alert-success',
                'messageVisibility'     => 'flex',
                'Allergenen'            =>  null,
                'ProductNaam'           =>  null,
                'ProductBarcode'        =>  null
            ];
            $this->view('Magazijns/viewAllergeen', $data);

            header('Refresh:4;' .  URLROOT . '/Magazijns/index');
        } else {

            $data = [
                'message'               => '',
                'messageColor'          => '',
                'messageVisibility'     => 'none',
                'Allergenen'            => $Allergenen,
                'ProductNaam'           => $Allergenen[0]->ProductNaam,
                'ProductBarcode'        => $Allergenen[0]->Barcode
            ];
            $this->view('Magazijns/viewAllergeen', $data);
        }
    }
}
